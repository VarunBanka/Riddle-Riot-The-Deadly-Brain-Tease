import 'package:flutter/material.dart';
import 'package:chemistry_game/page1.dart';
import 'package:chemistry_game/page2.dart';
import 'package:chemistry_game/page3.dart';
import 'package:chemistry_game/page4.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riddle Riot: The Deadly Brain Tease'),
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (ctx) => const Text("Made by Varun Banka"),
              );
            },
            icon: const Icon(Icons.developer_board),
          ),
        ],
      ),
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
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/page1');
                  },
                  child: const Text('Level 1'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Navigator.pushNamed(context, '/page2');
                    showModalBottomSheet(
                      context: context,
                      builder: (ctx) => const Text("Please start with Level 1"),
                    );
                  },
                  child: const Text('Level 2'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Navigator.pushNamed(context, '/page3');
                    showModalBottomSheet(
                      context: context,
                      builder: (ctx) => const Text("Please start with Level 1"),
                    );
                  },
                  child: const Text('Level 3'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Navigator.pushNamed(context, '/page4');
                    showModalBottomSheet(
                      context: context,
                      builder: (ctx) => const Text("Please start with Level 1"),
                    );
                  },
                  child: const Text('Level 4'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
