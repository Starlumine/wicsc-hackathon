import 'dart:math';
import 'game_state.dart';

final Random _random = Random();

Map<String, Scene> generateScenes(String playerName) {
  bool businessSuccess = _random.nextBool();
  bool stockSuccess = _random.nextBool();
  bool robbChance = _random.nextBool();

  String backgroundImage = _random.nextBool() 
    ? 'media/robbery.png' 
    : 'media/mom.png';

  String background = stockSuccess 
    ? 'media/rich.png' 
    : 'media/moneyloss.png';

  return {
    'start': Scene(
      id: 'start',
      text: 'Hey, $playerName! You have a bunch of money, so you feel like splurging. What do you want to do first?',
      backgroundImage: 'media/house_car.png',
      choices: [
        Choice(text: 'Buy a house', nextSceneId: 'buy_house', moneyChange: 0, wisdomChange: 0),
        Choice(text: 'Buy a car', nextSceneId: 'buy_car', moneyChange: 0, wisdomChange: 0),
      ],
    ),

    // Buying House & Car Paths
    'buy_house': Scene(
      id: 'buy_house',
      backgroundImage: 'media/buy_house.png',
      text: 'The real estate agent shows you two houses:',
      choices: [
        Choice(text: 'Buy a really nice house', nextSceneId: 'random_robbery_or_mom', moneyChange: -250000, wisdomChange: 0),
        Choice(text: 'Buy a humble house', nextSceneId: _random.nextBool() ? 'pipes_burst' : 'no_event', moneyChange: -100000, wisdomChange: 1),
      ],
    ),
    'buy_car': Scene(
      id: 'buy_car',
      text: 'You visit the dealership. Which car do you pick?',
      backgroundImage: 'media/buy_car.png',
      choices: [
        Choice(text: 'BMW (fancy but risky)', nextSceneId: 'random_robbery_or_mom', moneyChange: -50000, wisdomChange: 0),
        Choice(text: 'Honda Civic (reliable)', nextSceneId: _random.nextBool() ? 'find_money' : 'no_event', moneyChange: -25000, wisdomChange: 1),
      ],
    ),

    // Random Events
    'random_robbery_or_mom': Scene(
      id: 'random_robbery_or_mom',
      text: robbChance
          ? 'Oh no! You got robbed and lost \$20,000!'
          : 'Your mom sees how rich you are and asks you for \$20,000 to "help with bills"',
      backgroundImage: robbChance ? 'media/robbery.png' : 'media/mom.png',    
      choices: [
        Choice(text: 'Continue', nextSceneId: 'start_business', moneyChange: -20000, wisdomChange: 1),
      ],
    ),
    'pipes_burst': Scene(
      id: 'pipes_burst',
      text: 'Uh-oh! Pipes burst in your house. You pay \$5,000 for repairs.',
      backgroundImage: 'media/pipes.png',
      choices: [
        Choice(text: ':(', nextSceneId: 'start_business', moneyChange: -5000, wisdomChange: 1),
      ],
    ),
    'find_money': Scene(
      id: 'find_money',
      text: 'Lucky you! You found \$5,000 hidden in the backseat of your Civic!',
      backgroundImage: 'media/car_money.png',
      choices: [
        Choice(text: 'Awesome!', nextSceneId: 'start_business', moneyChange: 5000, wisdomChange: 0),
      ],
    ),
    'no_event': Scene(
      id: 'no_event',
      text: 'You continue with your day...',
      choices: [
        Choice(text: 'Continue', nextSceneId: 'start_business', moneyChange: 0, wisdomChange: 0),
      ],
    ),

    // Business or Investing
    'start_business': Scene(
      id: 'start_business',
      text: '$playerName, you know the money won\'t last forever. What do you want to do about it?',
      backgroundImage: 'media/business_invest.png',
      choices: [
        Choice(
          text: 'Start a business',
          nextSceneId: businessSuccess ? 'business_success' : 'business_fail',
          moneyChange: -100000,
          wisdomChange: 2,
        ),
        Choice(
          text: 'Try investing',
          nextSceneId: 'invest_options',
          moneyChange: 0,
          wisdomChange: 1,
        ),
      ],
    ),
    'business_success': Scene(
      id: 'business_success',
      text: 'Your business is booming! You make \$250,000 profit!',
      backgroundImage: 'media/rich.png',
      moneyChange: 250000,
      choices: [
        Choice(text: 'Continue', nextSceneId: 'dating', moneyChange: 0, wisdomChange: 0),
      ],
    ),
    'business_fail': Scene(
      id: 'business_fail',
      text: 'Sadly, your business didn’t work out. You lost \$100,000.',
      backgroundImage: 'media/moneyloss.png',
      moneyChange: -100000,
      choices: [
        Choice(text: 'Continue', nextSceneId: 'dating', moneyChange: 0, wisdomChange: 0),
      ],
    ),

    // Investing Paths
    'invest_options': Scene(
      id: 'invest_options',
      text: 'Where would you like to invest?',
      backgroundImage: 'media/property_stock.png',
      choices: [
        Choice(text: 'Invest in properties', nextSceneId: 'property_invest', moneyChange: 0, wisdomChange: 1),
        Choice(text: 'Invest in stocks', nextSceneId: 'stock_invest', moneyChange: 0, wisdomChange: 1),
      ],
    ),
    'property_invest': Scene(
      id: 'property_invest',
      backgroundImage: 'media/haunted.png',
      text: 'You choose a haunted apartment complex. Tenants are scared, but it’s profitable!',
      moneyChange: 200000,
      choices: [
        Choice(text: 'Continue', nextSceneId: 'dating', moneyChange: 0, wisdomChange: 0),
      ],
    ),
    'stock_invest': Scene(
      id: 'stock_invest',
      backgroundImage: background,
      text: stockSuccess
          ? 'You hit the jackpot investing in an AI startup! You got a lot of money.'
          : 'The startup failed. You lost part of your investment.',
      moneyChange: stockSuccess ? 150000 : -100000,
      choices: [
        Choice(text: 'Continue', nextSceneId: 'dating', moneyChange: 0, wisdomChange: 0),
      ],
    ),

    // Dating Paths
    'dating': Scene(
      id: 'dating',
      text: 'You decide you want to find a date.', 
      backgroundImage: 'media/dating.png',
      choices: [
        Choice(text: 'Date someone superficial but pretty', nextSceneId: 'disappointing', moneyChange: -200000, wisdomChange: -1),
        Choice(text: 'Date someone smart', nextSceneId: 'happy', moneyChange: 100000, wisdomChange: 1),
      ],
    ),
    'disappointing': Scene(
      id: 'disappointing',
      text: 'Your date runs away with most of your money.',
      backgroundImage: 'media/heartbroken.png',
      choices: [
        Choice(text: 'Continue', nextSceneId: 'end', moneyChange: -300000, wisdomChange: -2),
      ],
    ),
    'happy': Scene(
      id: 'happy',
      text: 'You and your partner are perfect for each other!',
      backgroundImage: 'media/couplecat.png',
      choices: [
        Choice(text: 'Continue', nextSceneId: 'end', moneyChange: 0, wisdomChange: 2),
      ],
    ),

    // Gambling Path
    /*
    'gambling': Scene(
      id: 'gambling',
      text: gambleSuccess 
          ? 'Lucky! You won the jackpot! Win \$20,000'
          : 'Oh no! You went on a downward spiral and lost \$20,000.',
      moneyChange: gambleSuccess ? 20000 : -20000,
      choices: [
        Choice(text: 'Continue', nextSceneId: 'end', moneyChange: 0, wisdomChange: 0),
      ],
    ),
*/
    // Final Scene
    'end': Scene(
      id: 'end',
      text: 'Throughout this journey, you\'ve have made a variety of financial decisions, some positive and others not so much. Your financial status and how well you\'ve done will be displayed on the next page. Take a moment to reflect on your choices and consider how you can be more mindful in the future when making financial decisions.',
      choices: [],
    ),
  };
}
