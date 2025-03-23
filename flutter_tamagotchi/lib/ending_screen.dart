import 'package:flutter/material.dart';

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
    } else {
      return "Poor Ending";
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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
    );
  }
}
