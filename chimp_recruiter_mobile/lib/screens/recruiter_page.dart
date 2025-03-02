import 'package:flutter/material.dart';

class RecruiterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Back to Home Page')),
      body: Center(
        child: Text(
          'Temporary Recruiter Page',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
