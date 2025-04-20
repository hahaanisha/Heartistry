import 'package:flutter/material.dart';
import 'package:journal_app/pages/home.dart'; // Import home.dart for navigation
import 'package:journal_app/pages/gym.dart'; // Import gym.dart for navigation
import 'package:journal_app/pages/chat.dart'; // Import chat.dart for navigation
import 'package:journal_app/pages/about.dart';
import 'package:journal_app/pages/levels.dart'; // Corrected import
import 'colors.dart'; // Import colors.dart

class MyJournalApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Empathy Journal',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
      routes: {
        '/home': (context) => Home(),
        '/gym': (context) => Gym(), // Ensure this is uncommented
        '/chat': (context) => LevelsPage(),
        '/about': (context) => AboutPage(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Welcome to Heartistry',
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
        backgroundColor: AppColors.appBarColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              'Hey There✨',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0, color: AppColors.textColor),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.0),
            Text(
              'How are you feeling today?',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0, color: AppColors.textColor),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 4.0),
            Container(
              decoration: BoxDecoration(
                color: Colors.black26,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
                borderRadius: BorderRadius.circular(12.0),
              ),
              padding: EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      _showEmotionDialog(context, 'Upset', 'Keep your spirits high!');
                    },
                    child: EmotionBox(image: 'assets/images/very_sad.png', text: 'Upset'),
                  ),
                  GestureDetector(
                    onTap: () {
                      _showEmotionDialog(context, 'Sad', 'It\'s okay to feel sad. Take your time to heal.');
                    },
                    child: EmotionBox(image: 'assets/images/sad.png', text: 'Sad'),
                  ),
                  GestureDetector(
                    onTap: () {
                      _showEmotionDialog(context, 'Neutral', 'Balance is good. Keep moving forward.');
                    },
                    child: EmotionBox(image: 'assets/images/neutral.png', text: 'Neutral'),
                  ),
                  GestureDetector(
                    onTap: () {
                      _showEmotionDialog(context, 'Happy', 'Enjoy the moment and share your joy!');
                    },
                    child: EmotionBox(image: 'assets/images/happy.png', text: 'Happy'),
                  ),
                  GestureDetector(
                    onTap: () {
                      _showEmotionDialog(context, 'Excited', 'Channel that excitement into something amazing!');
                    },
                    child: EmotionBox(image: 'assets/images/very_happy.png', text: 'Excited'),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'What do you want to do?',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0, color: AppColors.textColor),
              textAlign: TextAlign.center,
            ),
            Text(
              'Get Started with your Empathy Journey',
              style: TextStyle(fontSize: 16.0, color: AppColors.textColor),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/home'); // Navigate to home.dart
                  },
                  child: Column(
                    children: <Widget>[
                      ActionBox(image: 'assets/images/reflect.png', text: 'Reflect and Write'),
                      SizedBox(height: 8.0),
                      Text(
                        'Reflect and Write',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0, color: AppColors.textColor),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/gym'); // Navigate to gym.dart
                  },
                  child: Column(
                    children: <Widget>[
                      ActionBox(image: 'assets/images/gym.png', text: 'Empathy Gym'),
                      SizedBox(height: 8.0),
                      Text(
                        'Lets Learn',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0, color: AppColors.textColor),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/chat'); // Navigate to chat.dart
                  },
                  child: Column(
                    children: <Widget>[
                      ActionBox(image: 'assets/images/chat.png', text: 'Chat it out'),
                      SizedBox(height: 8.0),
                      Text(
                        'Empathy Exercises',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0, color: AppColors.textColor),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/about'); // Navigate to about.dart
                  },
                  child: Column(
                    children: <Widget>[
                      ActionBox(image: 'assets/images/story.png', text: 'Our Story'),
                      SizedBox(height: 8.0),
                      Text(
                        'Our Story',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0, color: AppColors.textColor),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),
          ],
        ),
      ),
      backgroundColor: AppColors.backgroundColor,
    );
  }

  void _showEmotionDialog(BuildContext context, String emotion, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(emotion),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

class EmotionBox extends StatelessWidget {
  final String image;
  final String text;

  EmotionBox({required this.image, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 64.0,
      height: 96.0,
      child: Column(
        children: <Widget>[
          Image.asset(
            image,
            height: 48.0,
            width: 48.0,
            fit: BoxFit.contain,
          ),
          SizedBox(height: 4.0),
          Text(
            text,
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class ActionBox extends StatelessWidget {
  final String image;
  final String text;

  ActionBox({required this.image, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140.0,
      height: 140.0,
      decoration: BoxDecoration(
        color: Colors.black26,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            image,
            height: 100.0,
            width: 100.0,
            fit: BoxFit.contain,
          ),

        ],
      ),
    );
  }
}