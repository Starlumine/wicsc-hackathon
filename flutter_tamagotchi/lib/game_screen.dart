import 'package:flutter/material.dart';
import 'game_state.dart';
import 'scenes.dart';
import 'ending_screen.dart';

class GameScreen extends StatefulWidget {
  final String playerName;
  
  const GameScreen({super.key, required this.playerName});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final GameState _gameState = GameState();
  late Map<String, Scene> _scenes;

  double kittyX = 0;
  bool animateKitty = false;

  @override
  void initState() {
    super.initState();
    _scenes = generateScenes(widget.playerName);
  }

  void _onChoiceSelected(Choice choice) {
    setState(() {
      _gameState.applyChoice(choice);
      kittyX = 2.0;
      animateKitty = true;
    });

    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        animateKitty = false;
        kittyX = 0;
      });

      final nextScene = _scenes[_gameState.currentSceneId];
      if (nextScene != null && nextScene.choices.isEmpty) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => EndingScreen(
              finalMoney: _gameState.money,
              finalWisdom: _gameState.wisdom,
              playerName: widget.playerName,
            ),
          ),
        );
      }
    });
  }

  String getKittyImage() {
    if (_gameState.money > 500000) {
      return 'media/kitty_rich.png';
    } else if (_gameState.money < 100000) {
      return 'media/kitty_dirty.png';
    } else {
      return 'media/kitty.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentScene = _scenes[_gameState.currentSceneId]!;
    String? bgImage = currentScene.backgroundImage;

    const textStyle = TextStyle(
      fontFamily: 'PressStart2P',
      fontSize: 15,
      color: Colors.black,
      shadows: [
        Shadow(blurRadius: 1.0, color: Colors.white, offset: Offset(1, 1)),
      ],
    );

    return Scaffold(
      body: Stack(
        children: [
          if (bgImage != null)
            Positioned.fill(
              child: Image.asset(
                bgImage,
                fit: BoxFit.cover,
              ),
            ),
          Container(
            color: Colors.white, 
          ),
          SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      currentScene.text,
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    ...currentScene.choices.map(
                      (choice) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: ElevatedButton(
                          onPressed: () => _onChoiceSelected(choice),
                          child: Text(
                            choice.text,
                            style: textStyle,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      'Money: \$${_gameState.money}',
                      style: textStyle,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 750),
            bottom: 20,
            left: MediaQuery.of(context).size.width * kittyX,
            child: Image.asset(
              getKittyImage(),
              width: 128,
              height: 128,
            ),
          ),
        ],
      ),
    );
  }
}