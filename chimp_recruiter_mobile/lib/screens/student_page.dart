import 'package:flutter/material.dart';

class StudentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
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
          "Welcome, Student.",
        ),
      ),
      body: Stack(
        children: [
          // Background image
          Positioned(
            top: -100,
            left: 0,
            right: 0,
            bottom: 0,
            child: Image.asset(
              'assets/images/online-education.png',
              fit: BoxFit.contain,
            ),
          ),

          // Bottom buttons
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0, left: 0, bottom: 30.0, right: 0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [

                  // QR Code button
                  ElevatedButton(
                    onPressed: () {
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(130, 100),
                      maximumSize: Size(150, 100),
                      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                      backgroundColor: Color(0xFFD4F6FF),
                      textStyle: TextStyle(fontSize: 18),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Generate', style: TextStyle(fontSize: 16)),
                        Text('QR Code', style: TextStyle(fontSize: 16)),
                      ],
                    ),
                  ),

                  SizedBox(width: 30),

                  // Previous recruiters button
                  ElevatedButton(
                    onPressed: () {
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(130, 100),
                      maximumSize: Size(150, 100),
                      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                      backgroundColor: Color(0xFFD4F6FF),
                      textStyle: TextStyle(fontSize: 18),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Previous', style: TextStyle(fontSize: 16)),
                        Text('Recruiters', style: TextStyle(fontSize: 16)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
