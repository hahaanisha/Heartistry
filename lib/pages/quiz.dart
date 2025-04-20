import 'package:flutter/material.dart';
import '../classes/api_service.dart';
import 'colors.dart';


class QuizPage extends StatefulWidget {
  final String rightName;

  QuizPage({required this.rightName});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  late Future<Map<String, dynamic>> futureQuizData;
  List<bool> _isSelected = [false, false, false, false];
  String? feedback;
  int points = 0;

  @override
  void initState() {
    super.initState();
    futureQuizData = fetchQuizData(widget.rightName);
  }

  Future<Map<String, dynamic>> fetchQuizData(String rightName) async {
    ApiService apiService = ApiService();
    print(rightName);
    return await apiService.fetchQuizData(rightName);
  }

  void showFeedbackDialog(String feedback) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Feedback', style: TextStyle(color: AppColors.textColor)),
          content: Text(feedback, style: TextStyle(color: AppColors.textColor)),
          backgroundColor: AppColors.backgroundColor,
          actions: <Widget>[
            TextButton(
              child: Text('OK', style: TextStyle(color: AppColors.btnColor)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void updatePoints(int index) {
    if (index == 0) {
      points += 3;
    } else if (index == 1) {
      points += 2;
    } else if (index == 2) {
      points += 1;
    } // No points for index 3 as it is a negative outcome
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: Row(
          children: [
            // Image.asset("assets/images/RightsQuest_logo.png", width: 170,),
            // SizedBox(width: size.width * 0.3),
            InkWell(
              onTap: () {
                // Direct To Profile Page on Tap
              },
              child: Icon(Icons.person, color: AppColors.textColor),
            ),
          ],
        ),
        backgroundColor: AppColors.appBarColor,
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: futureQuizData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    color: AppColors.btnColor,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Loading for you most suitable scenarios',
                    style: TextStyle(color: AppColors.textColor),
                  ),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 20),
                  Text(
                    'Error: ${snapshot.error}',
                    style: TextStyle(
                      color: AppColors.textColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            );
          } else if (snapshot.hasData) {
            var quizData = snapshot.data!;
            var scenario = quizData['situation'] ?? 'No scenario available';
            var mostPositive = quizData['most_happy'] ?? 'No option available';
            var positive = quizData['happy'] ?? 'No option available';
            var neutral = quizData['neutral'] ?? 'No option available';
            var negative = quizData['sad'] ?? 'No option available';
            var feedback = quizData['feedback'] ?? 'No feedback available';
            List<String> _optionTexts = [
              mostPositive,
              positive,
              neutral,
              negative,
            ];

            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Container(
                      child: Row(
                        children: [
                          Flexible(
                            child: Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.btnColor.withOpacity(0.5),
                                    offset: const Offset(5.0, 5.0),
                                    blurRadius: 10.0,
                                    spreadRadius: 2.0,
                                  ),
                                  BoxShadow(
                                    color: AppColors.backgroundColor,
                                    offset: const Offset(0.0, 0.0),
                                    blurRadius: 0.0,
                                    spreadRadius: 0.0,
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  width: 2,
                                  color: Colors.grey,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  scenario,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.textColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: size.height * 0.05),
                    Row(
                      children: [
                        SizedBox(width: size.width * 0.65),
                      ],
                    ),
                    SizedBox(height: size.height * 0.01),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(4, (index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                _isSelected = [false, false, false, false];
                                _isSelected[index] = !_isSelected[index];
                                feedback = quizData['feedback'];
                                showFeedbackDialog(feedback!);
                                updatePoints(index);
                              });
                            },
                            child: Container(
                              constraints: BoxConstraints(minHeight: 50),
                              decoration: BoxDecoration(
                                color: _isSelected[index]
                                    ? index == 0
                                    ? Colors.green
                                    : index == 1 || index == 2
                                    ? Colors.yellow.shade800
                                    : Colors.red
                                    : Colors.grey[800],
                                borderRadius: BorderRadius.circular(25),
                                border: Border.all(
                                  width: 2,
                                  color: _isSelected[index]
                                      ? index == 0
                                      ? Colors.green
                                      : index == 1 || index == 2
                                      ? Colors.yellow.shade800
                                      : Colors.red
                                      : Colors.grey,
                                ),
                              ),
                              alignment: Alignment.center,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  _optionTexts[index],
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.textColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                    SizedBox(height: size.height * 0.05),
                    ElevatedButton(
                      onPressed: () {
                        // Handle submission logic here, e.g., navigate to the next screen or display a summary
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.btnColor,
                      ),
                      child: Text('Submit', style: TextStyle(color: AppColors.textColor)),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Center(
              child: Text('No data available', style: TextStyle(color: AppColors.textColor)),
            );
          }
        },
      ),
    );
  }
}
