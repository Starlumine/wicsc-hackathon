import 'game_state.dart';

final scenes = {
  'start': Scene(
    id: 'start',
    text: 'You just got laid off and buy a lottery ticket. You win \$1 million, but only get \$700,000 after taxes.',
    choices: [
      Choice(
        text: 'Buy a house',
        nextSceneId: 'buy_house',
        moneyChange: -250000,
        wisdomChange: 0,
      ),
      Choice(
        text: 'Buy a car',
        nextSceneId: 'buy_car',
        moneyChange: -50000,
        wisdomChange: 0,
      ),
    ],
  ),
  'buy_house': Scene(
    id: 'buy_house',
    text: 'The real estate ageent shows you two houses:',
    choices: [
      Choice(
        text: 'Buy a really nice house',
        nextSceneId: 'buy_nice_house',
        moneyChange: -250000,
        wisdomChange: 0,
      ),
      Choice(
        text: 'Buy a humble house',
        nextSceneId: 'buy_humble_house',
        moneyChange: -100000,
        wisdomChange: 0,
      ),
    ],
  ),
  'buy_car': Scene(
    id: 'buy_car',
    text: 'You bought a new car. Time to cruise!',
    choices: [],
  ),
};