import 'package:flutter/material.dart';
import 'package:chemistry_game/page1.dart';
import 'package:chemistry_game/page2.dart';
import 'package:chemistry_game/page3.dart';
import 'package:chemistry_game/page4.dart';

void main() {
  runApp(const MyApp());
}

about() {
  // dont mess with this func
  return const Center(
    child: SizedBox(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[Text("Made By Varun Banka")],
        ),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MyHomePage(),
      routes: {
        '/page1': (context) => Page1(),
        '/page2': (context) => Page2(),
        '/page3': (context) => Page3(),
        '/page4': (context) => Page4(),
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image.asset(
            'assets/background_image.png', // Replace with the path to your background image
            fit: BoxFit.cover,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment
                  .center, // Optional: Align the buttons at the center horizontally
              mainAxisSize: MainAxisSize
                  .min, // Ensure the column takes the minimum amount of vertical space
              children: <Widget>[
                const SizedBox(
                    height:
                        500), // Adjust the amount of space before the buttons
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/page1');
                  },
                  child: const Text('Start'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Navigator.pushNamed(context, '/page2');
                    showModalBottomSheet(
                      context: context,
                      builder: (ctx) => about(),
                    );
                  },
                  child: const Text('About'),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
