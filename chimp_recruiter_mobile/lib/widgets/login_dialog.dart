import 'package:chimp_recruiter_mobile/screens/candidate_page.dart';
import 'package:flutter/material.dart';
import 'package:chimp_recruiter_mobile/screens/webview_page.dart';

class LoginDialog extends StatelessWidget {

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      insetPadding: EdgeInsets.only(top: 10.0, left: 20.0, bottom: 30.0, right: 20.0),
      elevation: 16,
      child: Container(
        height: 350,
        width: 400,
        decoration: BoxDecoration(
          color: Color(0xFFC6E7FF),
          borderRadius: BorderRadius.circular(40),
        ),
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            SizedBox(height: 20),
            Center(child: Text(
              'Log In',
              style: TextStyle(
                fontFamily: 'PermanentMarker',
                fontSize: 36,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            )),
            SizedBox(height: 20),
            // Copied this from stackoverflow, check what is needed here

            // Username field
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 20),

            // Password field
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 10),

            // Forgot password
            Padding(
              padding: const EdgeInsets.only(right: 20.0, left: 20.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context, 
                    MaterialPageRoute(
                      builder: (context) => WebViewContainer(),
                    ),
                  );
                },
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),

            // Buttons for the form
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  ElevatedButton(
                    onPressed: () {
                      // implement the login function later
                      Navigator.push(
                        context, MaterialPageRoute(
                          builder: (context) => CandidatePage(), 
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(100, 50),
                      backgroundColor: Color(0xFFD4F6FF),
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text('Enter'),
                  ),

                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(100, 50),
                      backgroundColor: Color(0xFFD4F6FF),
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text('Cancel'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
