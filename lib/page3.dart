import 'package:flutter/material.dart';
import 'dart:async';
import 'package:chemistry_game/quiz_data.dart';

class Page3 extends StatefulWidget {
  const Page3({Key? key}) : super(key: key);
  @override
  _Page3State createState() => _Page3State();
}

class _Page3State extends State<Page3> {
  int _currentQuestionIndex = 0;
  late int? _selectedAnswerIndex = -1;

  showQuestions() {
    Map<String, dynamic> currentQuestion =
        QuizData.quizQuestions[_currentQuestionIndex];
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    currentQuestion['question'],
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(currentQuestion['options'].length,
                        (index) {
                      return RadioListTile(
                        title: Text(currentQuestion['options'][index]),
                        value: index,
                        groupValue: _selectedAnswerIndex,
                        // code here
                        onChanged: (value) {
                          setState(() {
                            _selectedAnswerIndex =
                                value; // Update the selected answer index
                            if (value == currentQuestion['answerIndex']) {
                              _currentQuestionIndex++;
                              Navigator.pop(context); // Close the modal sheet
                              _selectedAnswerIndex =
                                  null; // Reset the selected answer index
                              if (_currentQuestionIndex <
                                  QuizData.quizQuestions.length) {
                                showQuestions(); // Show the next question if available
                              } else {
                                Navigator.pushNamed(context, '/page2');
                              }
                            } else {
                              // Show an error message for wrong answer
                              Navigator.pushNamed(context, '/page1');
                            }
                          });
                        },
                      );
                    }),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  double balloonPositionX = 0.5; // Initial horizontal position of the balloon
  double balloonPositionY = 1.0; // Initial vertical position of the balloon
  List<double> blockPositions = [
    0.1,
    0.9,
    0.3,
    0.7
  ]; // idk if i really need this
  int currentBlockIndex = 0; // Index of the current block
  bool gameStarted = false;
  bool gameResultShown = false;
  bool gameWon = false;
  String question = "question 1 of lvl 1"; // q1 of l1
  String option1 = "option1";
  String option2 = "option1";
  String option3 = "option1";
  String option4 = "option1";
  String level = "Level: 1";

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

    Timer.periodic(Duration(milliseconds: 20), (timer) {
      if (balloonPositionY <= 0) {
        // Balloon reached the top
        timer.cancel();
        if (balloonPositionX >= blockPositions[currentBlockIndex] - 0.05 &&
            balloonPositionX <= blockPositions[currentBlockIndex] + 0.05) {
          // Balloon hit the current block
          setState(
            () {
              gameWon = true;
              showModalBottomSheet(
                context: context,
                builder: (ctx) => showQuestions(),
              );
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

  @override
  Widget build(BuildContext context) {
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
                      child: Container(
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
                        Text('Block A'),
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
                        Text('Block C'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            if (gameResultShown)
              Text(
                gameWon ? 'You Win!' : 'You Lose!',
                style: TextStyle(fontSize: 20),
              ),
            SizedBox(height: 20),
            Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (!gameStarted) {
                      startGame();
                    }
                  },
                  child: Text('Start'),
                ),
              ],
            ),
            SizedBox(height: 20),
            Column(
              children: [
                ElevatedButton(
                  onPressed: moveBalloonLeft,
                  child: Text('Left'),
                ),
              ],
            ),
            SizedBox(height: 20),
            Column(
              children: [
                ElevatedButton(
                  onPressed: moveBalloonRight,
                  child: Text('Right'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            if (gameStarted && gameResultShown && gameWon == false)
              ElevatedButton(
                onPressed: restartGame,
                child: Text('Restart'),
              ),
          ],
        ),
      ),
    );
  }
}
