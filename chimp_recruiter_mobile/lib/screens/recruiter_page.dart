import 'package:flutter/material.dart';

class RecruiterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFC6E7FF),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            alignment: Alignment.center,
            width: 450,
            decoration: BoxDecoration(
              color: Color(0xFFD4F6FF),
              
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              'Logout',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ),
        ),
        title: Text(
          "Welcome, Recruiter.",
        ),
      ),
      body: Stack(
        children: [
          // Background image
          Positioned(
            top: -350,
            left: 0,
            right: 0,
            bottom: 0,
            child: Image.asset(
              'assets/images/letter.png',
              fit: BoxFit.contain,
            ),
          ),

          // Table/grid for the events
          Positioned(
            left: 0,
            right: 0,
            bottom: 10,
            child: Container(
              height: MediaQuery.of(context).size.height / 2,
              decoration: BoxDecoration(
                color: Color(0xFFC6E7FF),
                borderRadius: BorderRadius.all(Radius.circular(20)),
                border: Border.all(
                  color: Colors.black,
                  width: 2,
                  style: BorderStyle.solid,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.transparent,
                    spreadRadius: 2,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Center(
                child: Text('Implement this part later (popuulate with events)'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
