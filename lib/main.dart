import 'package:flutter/material.dart';
import 'package:chemistry_game/page1.dart';
import 'package:chemistry_game/page2.dart';
import 'package:chemistry_game/page3.dart';
import 'package:chemistry_game/page4/mainForPage4.dart';

var kDarkColourSchm = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 5, 99, 125),
);

var kColorSchm = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 96, 59, 181),
);

void main() {
  runApp(
    MaterialApp(
      darkTheme: ThemeData.dark().copyWith(
        useMaterial3: true,
        colorScheme: kDarkColourSchm,
      ),
      theme: ThemeData().copyWith(
        useMaterial3: true,
        colorScheme: kColorSchm,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kColorSchm.primaryContainer,
          ),
        ),
        textTheme: ThemeData().textTheme.copyWith(
                titleLarge: TextStyle(
              fontWeight: FontWeight.normal,
              color: kColorSchm.secondaryContainer,
              fontSize: 14,
            )),
      ),
      themeMode: ThemeMode.system,
      home: const MyApp(),
    ),
  );
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
      theme: ThemeData.dark(),
      home: const MyHomePage(),
      routes: {
        '/page1': (context) => const Page1(),
        '/page2': (context) => const Page2(),
        '/page3': (context) => const Page3(),
        '/page4': (context) => const MyGame(),
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
