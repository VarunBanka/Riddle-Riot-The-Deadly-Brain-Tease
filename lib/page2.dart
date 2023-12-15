// tnis page isnt in use ffs

import 'package:flutter/material.dart';
import 'dart:async';

double balloonPositionX = 0.5; // Initial horizontal position of the balloon
double balloonPositionY = 2.0; // Initial vertical position of the balloon
bool gameStarted = false;
bool gameResultShown = false;
bool gameWon = false;

class Page2 extends StatefulWidget {
  const Page2({Key? key}) : super(key: key);
  @override
  _Page2State createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  @override
  Widget build(BuildContext context) {
    @override
    void initState() {
      super.initState();
    } // dont mess with this func, cause idk why it is even alive xd, jk...

    void startGame() {
      setState(() {
        balloonPositionX = 0.5; // Reset horizontal position of the balloon
        balloonPositionY = 0.8; // Reset vertical position of the balloon
        gameStarted = true;
        gameResultShown = false;
        gameWon = false;
      });

      Timer.periodic(const Duration(milliseconds: 20), (timer) {
        // setState(() {
        // balloonPositionY -= 0.0005; // Move the balloon upwards
        // });
      });
    }

    void moveBalloonRight() {
      if (balloonPositionX < 1) {
        setState(() {
          balloonPositionX += 0.05; // Move the balloon to the right
        });
      }
    }

    void moveBalloonLeft() {
      if (balloonPositionX > 0) {
        setState(() {
          balloonPositionX -= 0.05; // Move the balloon to the left
        });
      }
    }

    void restartGame() {
      setState(() {
        balloonPositionX = 0.5; // Reset balloon position
        // currentBlockIndex = 0; // Reset the current block index
        gameStarted = false;
        gameResultShown = false;
        gameWon = false;
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Level 3'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: double.infinity,
              height: 400,
              child: Stack(
                children: [
                  Positioned(
                    top: balloonPositionY * 400,
                    left: MediaQuery.of(context).size.width * balloonPositionX -
                        25,
                    child: GestureDetector(
                      onTap: () {
                        if (!gameStarted) {
                          startGame();
                        }
                      },
                      child: SizedBox(
                        width: 50,
                        height: 50,
                        child: Image.asset(
                          'player.png',
                          width: 100,
                          height: 100,
                        ),
                        // decoration: const BoxDecoration(
                        //   color: Colors.red,
                        //   shape: BoxShape.circle,
                        // ),
                      ),
                    ),
                  ),
                  // Render all four blocks at fixed positions

                  Positioned(
                    top: 0,
                    left: MediaQuery.of(context).size.width * 0.1,
                    child: Column(
                      children: [
                        Container(
                          width: 10,
                          height: 100,
                          color: Colors.blue,
                        ),
                        const Text('Block A'),
                      ],
                    ),
                  ),

                  Positioned(
                    top: 0,
                    left: MediaQuery.of(context).size.width * 0.7,
                    child: Column(
                      children: [
                        Container(
                          width: 10,
                          height: 100,
                          color: Colors.orange,
                        ),
                        const Text('Block C'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            if (gameResultShown)
              Text(
                gameWon ? 'You Win!' : 'You Lose!',
                style: const TextStyle(fontSize: 20),
              ),
            const SizedBox(height: 20),
            Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (!gameStarted) {
                      startGame();
                    }
                  },
                  child: const Text('Start'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Column(
              children: [
                ElevatedButton(
                  onPressed: moveBalloonLeft,
                  child: const Text('Left'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Column(
              children: [
                ElevatedButton(
                  onPressed: moveBalloonRight,
                  child: const Text('Right'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            if (gameStarted && gameResultShown && gameWon == false)
              ElevatedButton(
                onPressed: restartGame,
                child: const Text('Restart'),
              ),
          ],
        ),
      ),
    );
  }
}
