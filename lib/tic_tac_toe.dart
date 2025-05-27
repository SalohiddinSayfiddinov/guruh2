import 'dart:math';

import 'package:flutter/material.dart';

class TicTacToe extends StatefulWidget {
  const TicTacToe({super.key});

  @override
  State<TicTacToe> createState() => _TicTacToeState();
}

class _TicTacToeState extends State<TicTacToe> {
  List<String> stickers = [
    '🤚',
    '👊',
    '✌️',
  ];

  int userNumber = 0;
  int botNumber = Random().nextInt(3);
  bool isStarted = false;
  String winner = "";

  void pressButton(int index) {
    // botni raqamini yangilash
    botNumber = Random().nextInt(3);

    // foydalanuvchi raqamini yangilash
    userNumber = index;

    // tugma bosilganini aniqlash
    isStarted = true;

    // g'olibni aniqlash
    checkWinner();

    // ekran yangilash
    setState(() {});
  }

  void checkWinner() {
    switch (userNumber) {
      case 0:
        switch (botNumber) {
          case 0:
            winner = 'Draw';
            break;
          case 1:
            winner = 'You Won';
            break;
          case 2:
            winner = 'You Lost';
            break;
        }
        break;
      case 1:
        switch (botNumber) {
          case 0:
            winner = 'You Lost';
            break;
          case 1:
            winner = 'Draw';
            break;
          case 2:
            winner = 'You Won';
            break;
        }
        break;
      case 2:
        switch (botNumber) {
          case 0:
            winner = 'You Won';
            break;
          case 1:
            winner = 'You Lost';
            break;
          case 2:
            winner = 'Draw';
            break;
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(winner),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 25.0,
            children: [
              Text(
                isStarted ? 'Bot \n${stickers[botNumber]}' : '',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 50),
              ),
              const Divider(),
              Text(
                isStarted ? 'User \n${stickers[userNumber]}' : '',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 50),
              ),
            ],
          ),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(left: 30.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FloatingActionButton(
                onPressed: () {
                  pressButton(0);
                },
                child: Text(
                  stickers[0],
                  style: const TextStyle(fontSize: 40.0),
                ),
              ),
              FloatingActionButton(
                onPressed: () {
                  pressButton(1);
                },
                child: Text(
                  stickers[1],
                  style: const TextStyle(fontSize: 40.0),
                ),
              ),
              FloatingActionButton(
                onPressed: () {
                  pressButton(2);
                },
                child: Text(
                  stickers[2],
                  style: const TextStyle(fontSize: 40.0),
                ),
              ),
            ],
          ),
        ));
  }
}
