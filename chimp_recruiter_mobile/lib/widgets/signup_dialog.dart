import 'package:chimp_recruiter_mobile/screens/student_page.dart';
import 'package:chimp_recruiter_mobile/screens/recruiter_page.dart';
import 'package:flutter/material.dart';

class SignupDialog extends StatefulWidget {
  @override
  _SignupDialogState createState() => _SignupDialogState();
}

class _SignupDialogState extends State<SignupDialog> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  String _userType = 'Student';
  String? _firstNameError;
  String? _lastNameError;
  String? _emailError;
  String? _passwordError;
  String? _confirmPasswordError;

  // Checks for valid email format
  bool _isValidEmail(String email) {
    String pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(email);
  }

  // Check password format (8 characters, 1 Upper, 1 Symbol, 1 Number)
  bool _isValidPassword(String password) {
    String pattern = r'^(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(password);
  }

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

            // First name field
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextFormField(
                controller: _firstNameController,
                decoration: InputDecoration(
                  labelText: 'First Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  errorText: _firstNameError, 
                ),
              ),
            ),
            SizedBox(height: 10),

            // Last name field
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextFormField(
                controller: _lastNameController,
                decoration: InputDecoration(
                  labelText: 'Last Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  errorText: _lastNameError,
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
                  errorText: _emailError,
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
                  errorText: _passwordError,
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
                  errorText: _confirmPasswordError,
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
                    value: 'Student',
                    groupValue: _userType,
                    onChanged: (value) {
                      setState(() {
                        _userType = value!;
                      });
                    },
                  ),
                  Text('Student'),
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

                        // Check if first name is empty
                        if (_firstNameController.text.isEmpty) {
                          setState(() {
                            _firstNameError = "Empty Field";
                          });
                          return;
                        } else {
                          setState(() {
                            _firstNameError = null;
                          });
                        }

                        // Check if last name is empty
                        if (_lastNameController.text.isEmpty) {
                          setState(() {
                            _lastNameError = "Empty Field";
                          });
                          return;
                        } else {
                          setState(() {
                            _lastNameError = null;
                          });
                        }

                        // Validate Email
                        if (!_isValidEmail(_emailController.text)) {
                          setState(() {
                            _emailError = 'Invalid Email Address';
                          });
                          return;
                        } else {
                          setState(() {
                            _emailError = null;
                          });
                        }

                        // Validate Password
                        if (!_isValidPassword(_passwordController.text)) {
                          setState(() {
                            _passwordError = 'Invalid Password';
                          });
                          return;
                        } else {
                          setState(() {
                            _passwordError = null;
                          });
                        }

                        // Check confirmation password match
                        if (_passwordController.text != _confirmPasswordController.text) {
                          setState(() {
                            _confirmPasswordError = 'Passwords do not match';
                          });
                          return;
                        }
                        else {
                          setState(() {
                            _confirmPasswordError = null;
                          });
                        }

                        // Perform signup API here then open the dialog box for email code

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
