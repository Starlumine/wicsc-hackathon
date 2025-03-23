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

  @override
  void initState() {
    super.initState();
    _scenes = generateScenes(widget.playerName);
  }

  void _onChoiceSelected(Choice choice) {
    setState(() {
      _gameState.applyChoice(choice);
    });

    final nextScene = _scenes[_gameState.currentSceneId];
    if (nextScene != null && nextScene.choices.isEmpty) {
      Future.delayed(const Duration(milliseconds: 500), () {
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
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentScene = _scenes[_gameState.currentSceneId]!;
    String? bgImage = currentScene.backgroundImage;

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
          Container( // Add a semi-transparent overlay if needed
            color: Colors.black.withOpacity(0.5), 
          ),
          SafeArea(
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
                      padding: const EdgeInsets.only(top: 12.0),
                      child: ElevatedButton(
                        onPressed: () => _onChoiceSelected(choice),
                        child: Text(
                          choice.text,
                          style: Theme.of(context).textTheme.bodyMedium,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    'Money: \$${_gameState.money}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}