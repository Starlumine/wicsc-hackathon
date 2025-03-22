import 'package:flutter/material.dart';

class EndingScreen extends StatelessWidget {
  final int finalMoney;
  final int finalWisdom;

  const EndingScreen({
    super.key,
    required this.finalMoney,
    required this.finalWisdom,
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("The End", style: Theme.of(context).textTheme.displayLarge),
              const SizedBox(height: 30),
              Text("Money: \$${finalMoney}", style: Theme.of(context).textTheme.bodyMedium),
              Text("Wisdom: $finalWisdom", style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 30),
              Text(getEnding(), style: Theme.of(context).textTheme.titleMedium),
            ],
          ),
        ),
      ),
    );
  }
}
