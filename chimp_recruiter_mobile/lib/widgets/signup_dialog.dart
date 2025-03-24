import 'package:chimp_recruiter_mobile/screens/student_page.dart';
import 'package:chimp_recruiter_mobile/screens/recruiter_page.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

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

  final Uri apiUrl = Uri.parse('http://10.0.2.2:5001/api');

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
  
   Future<void> _signup() async {
    String firstName = _firstNameController.text.trim();
    String lastName = _lastNameController.text.trim();
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();
    String confirmPassword = _confirmPasswordController.text.trim();

    setState(() {
      _firstNameError = firstName.isEmpty ? "Empty Field" : null;
      _lastNameError = lastName.isEmpty ? "Empty Field" : null;
      _emailError = !_isValidEmail(email) ? "Invalid Email Address" : null;
      _passwordError = !_isValidPassword(password) ? "Invalid Password" : null;
      _confirmPasswordError = (password != confirmPassword) ? "Passwords do not match" : null;
    });

    if (_firstNameError != null ||
        _lastNameError != null ||
        _emailError != null ||
        _passwordError != null ||
        _confirmPasswordError != null) {
      return;
    }

    Uri endpointUri;

    Map<String, dynamic> requestData = {
      "FirstName": firstName,
      "LastName": lastName,
      "Email": email,
      "Password": password,
    };
    
    if (_userType == "Recruiter") {
      endpointUri = Uri.parse('${apiUrl.origin}/api/recruiter/signup');
      requestData.addAll({
        "LinkedIn": "N/A",
        "Company": "N/A",
        "Events": [],
      });
    } else {
      endpointUri = Uri.parse('${apiUrl.origin}/api/student/signup');
      requestData.addAll({
        "School": "N/A",
        "Grad_Semester": "N/A",
        "Grad_Year": "N/A",
        "Bio": "N/A",
        "Job_Performance": [],
      });
    }

    try {
      final response = await http.post(
        endpointUri,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(requestData),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 201) {
        print("Signup Successful: $responseData");
        Navigator.pop(context);
      } else {
        print("Signup Failed: ${responseData['error']}");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(responseData['error'] ?? "Signup failed")),
        );
      }
    } catch (error) {
      print("API Error: $error");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Network error. Please try again.")),
      );
    }
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
                        _signup();
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
