import 'package:flutter/material.dart';
import 'package:leena2/main.dart';

class Dashboard extends StatelessWidget {
  final LeenaGame game;
  const Dashboard({Key? key, required this.game}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Magic: ${game.magicLevel}',
                style: TextStyle(fontSize: 24, fontFamily: 'Arcade'),
              ),
              const SizedBox(
                width: 100,
              ),
              Text(
                'Power Remaining: ${game.remainingTime}',
                style: const TextStyle(fontSize: 24.0, fontFamily: 'Arcade'),
              )
            ],
          ),
        ),
        SizedBox(
          height: 40,
        ),
        game.remainingTime > 0
            ? Container()
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'GAME OVER',
                    style: TextStyle(
                        fontSize: 80, color: Colors.red, fontFamily: 'Arcade'),
                  ),
                ],
              )
      ],
    );
  }
}
