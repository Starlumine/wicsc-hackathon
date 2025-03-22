import 'package:flutter/material.dart';
import 'game_state.dart';
import 'scenes.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final GameState _gameState = GameState();

  void _onChoiceSelected(Choice choice) {
    setState(() {
      _gameState.applyChoice(choice);
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentScene = scenes[_gameState.currentSceneId]!;

    return Scaffold(
      appBar: AppBar(
        title: Text('Budget Life', style: Theme.of(context).textTheme.titleMedium),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              currentScene.text,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 20),
            ...currentScene.choices.map((choice) => ElevatedButton(
              onPressed: () => _onChoiceSelected(choice),
              child: Text(choice.text, style: Theme.of(context).textTheme.bodyMedium),
            )),
            const Spacer(),
            Text('Money: \$${_gameState.money}', style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}
