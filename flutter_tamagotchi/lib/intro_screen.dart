import 'package:flutter/material.dart';
import 'game_screen.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final List<String> introPages = [
    'You just got off another long, tiring shift at your 9–5.\n\nYou get a call from your boss and get told that you are being laid off.',
    'With your gas tank nearly empty you decide to stop at a nearby gas station, and while filling up, something catches your eye: a Mega Millions display with a huge jackpot sign.\n\nFeeling lucky, you grab a lottery ticket.',
    'Later that night, half-asleep on the couch, you scratch the ticket.\nOne number matches.\nThen another. You’ve won \$500,000!',
    'Next morning, you race back to the gas station to claim your prize.\nAfter taxes, you’re handed \$340,000.\n\n...Not quite as much as you imagined.',
    'You want to splurge!',
  ];

  final List<String> buttons = [
    'Aw man...',
    'Test my luck!',
    'WHAT?????',
    'Whoa...',
    'Let\'s go!',
  ];

  int currentPage = 0;

  void _nextPage() {
    if (currentPage < introPages.length - 1) {
      setState(() {
        currentPage++;
      });
    } else {
      _askForName();
    }
  }

  void _askForName() {
    final nameController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("What's your name?"),
          content: TextField(
            controller: nameController,
            decoration: const InputDecoration(hintText: 'Enter your name'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final name = nameController.text.trim();
                if (name.isNotEmpty) {
                  Navigator.of(context).pop();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GameScreen(playerName: name),
                    ),
                  );
                }
              },
              child: const Text('Start Game'),
            ),
          ],
        );
      },
    );
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
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      introPages[currentPage],
                      style: textStyle,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: _nextPage,
                      child: Text(
                        buttons[currentPage],
                        style: textStyle,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 40,
            left: 40,
            child: Image.asset(
              'media/kitty.png',
              width: 160,
              height: 160,
            ),
          ),
          Positioned(
            bottom: 200,
            left: 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'You',
                  style: textStyle.copyWith(fontSize: 10),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
