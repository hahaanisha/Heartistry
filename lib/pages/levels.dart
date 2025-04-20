import 'package:flutter/material.dart';
import 'package:journal_app/pages/quiz.dart';
import 'package:journal_app/pages/colors.dart'; // Ensure this is the correct path to your colors.dart

class LevelsPage extends StatelessWidget {
  final List<String> levels = [
    'Verbal Bullying',
    'Physical Bullying',
    'Social Bullying',
    'Prejudicial Bullying',
    'Social Bullying'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: Text('Increase your EQ 📈', style: TextStyle(color: AppColors.textColor)),
        backgroundColor: AppColors.appBarColor,
        iconTheme: IconThemeData(
          color: AppColors.textColor,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Select a category',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.textColor,
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: levels.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.btnColor, // Background color of the button from colors.dart
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0), // Rounded corners
                        ),
                        padding: EdgeInsets.symmetric(vertical: 20.0), // Vertical padding
                        textStyle: TextStyle(
                          fontSize: 18,
                          color: AppColors.textColor, // Text color from colors.dart
                        ),
                      ),
                      child: Text(levels[index]),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => QuizPage(rightName: levels[index]),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20), // Add space between the ListView and the quote
            Text(
              '“No one heals himself by wounding another. Remember,You have power over your mind – not outside events. Realize this, and you will find strength.” ',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontStyle: FontStyle.italic,
                color: AppColors.textColor,
              ),
            ),
            SizedBox(height: 20), // Add some padding at the bottom
          ],
        ),
      ),
    );
  }
}
