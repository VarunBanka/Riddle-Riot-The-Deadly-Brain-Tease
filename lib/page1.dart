import 'package:flutter/material.dart';
import 'package:chemistry_game/quiz_data.dart';

class Page1 extends StatefulWidget {
  @override
  _Page1State createState() => _Page1State();
}

class _Page1State extends State<Page1> with TickerProviderStateMixin {
  late AnimationController _animationController;
  double _blockPosition = 0;

  @override
  int _currentQuestionIndex = 0;
  late int? _selectedAnswerIndex = -1;

  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _animationController.forward();
    _animationController.addListener(() {
      setState(() {
        _blockPosition = MediaQuery.of(context).size.height -
            200 -
            (100 * _animationController.value);
        if (_animationController.isCompleted) {
          _showModalSheet();
        }
      });
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _showModalSheet() {
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
                                _showModalSheet(); // Show the next question if available
                              } else {
                                Navigator.pushNamed(context, '/page2');
                              }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Level 1'),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('levelOne.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(seconds: 2),
            curve: Curves.ease,
            left: (MediaQuery.of(context).size.width - 100) / 2,
            bottom: _blockPosition,
            child: Container(
              color: Colors.yellow,
              width: 100,
              height: 100,
            ),
          ),
        ],
      ),
    );
  }
}
