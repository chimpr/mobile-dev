import 'package:chimp_recruiter_mobile/screens/candidate_page.dart';
import 'package:flutter/material.dart';

class SignupDialog extends StatefulWidget {
  @override
  _SignupDialogState createState() => _SignupDialogState();
}

class _SignupDialogState extends State<SignupDialog> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  String _userType = 'Candidate';

  @override
  Widget build(BuildContext context) {

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      insetPadding: EdgeInsets.only(top: 10.0, left: 20.0, bottom: 30.0, right: 20.0),
      elevation: 16,
      child: Container(
        height: 470,
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
              'Sign Up',
              style: TextStyle(
                fontFamily: 'PermanentMarker',
                fontSize: 36,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            )),
            SizedBox(height: 10),
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
            SizedBox(height: 10),

            // Email field
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 10),

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

            // Confirm Password field
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextFormField(
                controller: _confirmPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 10),

            // User type radio buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  Text(
                    'I am a...',
                    style: TextStyle(
                      fontFamily: 'PermanentMarker',
                      fontSize: 18,
                    ),
                  ),
                  Radio<String>(
                    value: 'Recruiter',
                    groupValue: _userType,
                    onChanged: (value) {
                      setState(() {
                        _userType = value!;
                      });
                    },
                  ),
                  Text('Recruiter'),
                  Radio<String>(
                    value: 'Candidate',
                    groupValue: _userType,
                    onChanged: (value) {
                      setState(() {
                        _userType = value!;
                      });
                    },
                  ),
                  Text('Candidate'),
                ],
              ),
            ),

            // Buttons for the form
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(40),
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
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text('Confirm'),
                    ),
                
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(100, 50),
                        backgroundColor: Color(0xFFD4F6FF),
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text('Cancel'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
