import 'package:flutter/material.dart';
import 'intro_screen.dart';

class EndingScreen extends StatelessWidget {
  final int finalMoney;
  final int finalWisdom;
  final String playerName;

  const EndingScreen({
    super.key,
    required this.finalMoney,
    required this.finalWisdom,
    required this.playerName,
  });

  String getEnding() {
    if (finalMoney > 300000 && finalWisdom > 3) {
      return "Rich Ending";
    } else if (finalMoney > 100000) {
      return "Stable Ending";
    } else if (finalMoney < 0) {
      return "Bankrupt Ending";
    } else {
      return "Poor Ending";
    }
  }
  
  String getKittyImage() {
    if (finalMoney > 300000 && finalWisdom > 3) {
      return 'media/kitty_rich.png';
    } else if (finalMoney > 100000) {
      return 'media/kitty.png';
    } else {
      return 'media/kitty_dirty.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
      fontFamily: 'PressStart2P',
      fontSize: 15,
      color: Colors.black,
      shadows: [
        Shadow(blurRadius: 1, color: Colors.white, offset: Offset(1, 1)),
      ],
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 200, 24, 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("The End", style: textStyle.copyWith(fontSize: 20), textAlign: TextAlign.center),
                    const SizedBox(height: 30),
                    Text("Well done, $playerName!", style: textStyle, textAlign: TextAlign.center),
                    const SizedBox(height: 20),
                    Text("Final Balance: \$${finalMoney}", style: textStyle, textAlign: TextAlign.center),
                    Text("Good decisions made: $finalWisdom", style: textStyle, textAlign: TextAlign.center),
                    const SizedBox(height: 30),
                    Text(getEnding(), style: textStyle, textAlign: TextAlign.center),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 100.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const IntroScreen()),
                  );
                },
                child: Text('Go Again!', style: textStyle.copyWith(fontSize: 10)),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 200.0),
              child: Image.asset(
                getKittyImage(),
                width: 256,
                height: 256,
              ),
            ),
          ),
        ],
      ),
    );
  }
}