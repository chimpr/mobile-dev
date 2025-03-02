import 'package:flutter/material.dart';

class CandidatePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Back to Home Page')),
      body: Center(
        child: Text(
          'Temporary Candidate Page',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
