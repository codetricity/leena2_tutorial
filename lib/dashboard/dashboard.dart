import 'package:flutter/material.dart';
import '../main.dart';

class Dashboard extends StatelessWidget {
  final LeenaGame game;
  const Dashboard({Key? key, required this.game}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'Magic: ${game.gemScore}',
                style: const TextStyle(fontSize: 24, fontFamily: 'Arcade'),
              ),
              const SizedBox(
                width: 100.0,
              ),
              Text('Power Remaining: ${game.remainingTime}',
                  style: const TextStyle(fontSize: 24.0, fontFamily: 'Arcade')),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
          const SizedBox(
            height: 30,
          ),
          game.remainingTime > 0
              ? Container()
              : const Text(
                  'GAME OVER',
                  style: TextStyle(
                      color: Colors.red, fontSize: 60, fontFamily: 'Arcade'),
                ),
        ],
      ),
    );
  }
}
