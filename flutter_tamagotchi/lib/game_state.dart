class GameState {
  int money = 340000;
  int wisdom = 0;
  String currentSceneId = 'start';

  void applyChoice(Choice choice) {
    money += choice.moneyChange;
    wisdom += choice.wisdomChange;
    currentSceneId = choice.nextSceneId;
  }
}

class Choice {
  final String text;
  final String nextSceneId;
  final int moneyChange;
  final int wisdomChange;

  Choice({
    required this.text,
    required this.nextSceneId,
    required this.moneyChange,
    required this.wisdomChange,
  });
}

class Scene {
  final String id;
  final String text;
  final List<Choice> choices;
  final String? backgroundImage;
  final int moneyChange;

  Scene({
    required this.id,
    required this.text,
    required this.choices,
    this.backgroundImage,
    this.moneyChange = 0,
  });
}
