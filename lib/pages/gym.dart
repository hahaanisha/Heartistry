import 'package:flutter/material.dart';
import 'colors.dart'; // Import colors.dart

class Gym extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Empathy Gym',
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
        iconTheme: IconThemeData(
          color: AppColors.textColor,
        ),
        backgroundColor: AppColors.appBarColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'Lets learn about types of Bullying',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0, color: AppColors.textColor),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 16.0),
              _buildExpansionTile(
                context,
                'Verbal Bullying',
                'Verbal bullying involves using words to harm others. This can include name-calling, insults, and verbal threats. It aims to belittle or intimidate the victim through harmful language.',
              ),
              _buildExpansionTile(
                context,
                'Physical Bullying',
                'Physical bullying involves using physical force to harm someone. This can include hitting, kicking, pushing, or any other form of physical aggression. It aims to cause physical harm or fear.',
              ),
              _buildExpansionTile(
                context,
                'Social Bullying',
                'Social bullying involves harming someone’s social relationships. This can include spreading rumors, excluding someone from a group, or public humiliation. It aims to damage the victim’s social standing.',
              ),
              _buildExpansionTile(
                context,
                'Prejudicial Bullying',
                'Prejudicial bullying involves targeting individuals based on their race, religion, or other personal characteristics. It includes making derogatory remarks or exhibiting discriminatory behavior. The goal is to marginalize or demean the victim based on their identity.',
              ),
              _buildExpansionTile(
                context,
                'Cyberbullying',
                'Cyberbullying involves using digital platforms to harass, threaten, or embarrass someone. This can include sending harmful messages, spreading false information online, or engaging in other forms of online abuse. It leverages the anonymity and reach of the internet to target individuals.',
              ),
            ],
          ),
        ),
      ),
      backgroundColor: AppColors.backgroundColor,
    );
  }

  Widget _buildExpansionTile(BuildContext context, String title, String content) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ExpansionTile(
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.textColor),
        ),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              content,
              style: TextStyle(fontSize: 16.0, color: AppColors.textColor),
            ),
          ),
        ],
      ),
    );
  }
}
