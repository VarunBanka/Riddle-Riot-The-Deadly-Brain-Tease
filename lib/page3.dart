import 'package:flutter/material.dart';
import 'dart:async';

int _currentQuestionIndex = 0;
int? _selectedAnswerIndex = -1;
String clue1 = "I am a hydrocarbon. Who am I ?";
String clue2 = "I am burning with blue flame . Who am I ?";
String clue3 = "I have tetrahedral structure. Who am I ?";
String clue4 = "I am better known as MARSH GAS. Who am I ?";
int hint = 0;
double balloonPositionX = 0.5; // Initial horizontal position of the balloon
double balloonPositionY = 1.0; // Initial vertical position of the balloon
List<double> blockPositions = [0.1, 0.9, 0.3, 0.7]; // idk if i really need this
int currentBlockIndex = 0; // Index of the current block
bool gameStarted = false;
bool gameResultShown = false;
bool gameWon = false;

class Page3 extends StatefulWidget {
  const Page3({Key? key}) : super(key: key);
  @override
  _Page3State createState() => _Page3State();
}

class _Page3State extends State<Page3> {
  @override
  Widget build(BuildContext context) {
    void showHint() {
      setState(() {
        hint = hint + 1;
      });
      if (hint == 1) {
        setState(() {
          clue1 = clue2;
        });
      }
      if (hint == 2) {
        setState(() {
          clue1 = clue3;
        });
      }
      if (hint == 3) {
        setState(() {
          clue1 = clue4;
        });
      }
    }

    void showModalSheet() {
      showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return Center(
            child: SizedBox(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      clue1,
                      textAlign: TextAlign.start,
                      style: const TextStyle(fontSize: 20),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/page1');
                      },
                      child: const Text("Butane"),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/page1');
                      },
                      child: const Text("Propane"),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/page1');
                      },
                      child: const Text("Acetylene"),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/page4');
                      },
                      child: const Text("Methane"),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    ElevatedButton(
                      // onPressed: showHint,
                      onPressed: showHint,
                      child: const Text("Hint"),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    }

    @override
    void initState() {
      super.initState();
    } // dont mess with this func, cause idk why it is even alive xd, jk...

    void startGame() {
      setState(() {
        balloonPositionX = 0.5; // Reset horizontal position of the balloon
        balloonPositionY = 1.0; // Reset vertical position of the balloon
        gameStarted = true;
        gameResultShown = false;
        gameWon = false;
      });

      Timer.periodic(const Duration(milliseconds: 20), (timer) {
        if (balloonPositionY <= 0) {
          // Balloon reached the top
          timer.cancel();
          if (balloonPositionX >= blockPositions[currentBlockIndex] - 0.05 &&
              balloonPositionX <= blockPositions[currentBlockIndex] + 0.05) {
            // Balloon hit the current block
            setState(
              () {
                gameWon = true;
                showModalSheet();
              },
            );
          } else {
            // Balloon missed the current block
            setState(() {
              gameWon = false;
            });
          }
          setState(() {
            gameResultShown = true;
          });

          // Move to the next block
          currentBlockIndex++;
          if (currentBlockIndex >= blockPositions.length) {
            currentBlockIndex = 0;
          }
        } else {
          setState(() {
            balloonPositionY -= 0.005; // Move the balloon upwards
          });
        }
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
        currentBlockIndex = 0; // Reset the current block index
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
