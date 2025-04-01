import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _emailController = TextEditingController();
  final _codeController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isEmailEntered = false;
  bool _isCodeSent = false;
  bool _isEmailValid = true;
  bool _isCodeVerified = false;
  bool _isLoading = false;

  final String apiUrl = 'http://10.0.2.2:5001/api';

  // Password validation
  bool isValidPassword(String password) {
    String pattern = r'^(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(password);
  }

  Future<void> sendCodeToEmail(String email) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await http.post(
        Uri.parse('$apiUrl/send-reset-code'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email}),
      );

      if (response.statusCode == 200) {
        setState(() {
          _isCodeSent = true;
          _isEmailEntered = true;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Verification code sent. Check your email.")),
        );
      } else {
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        String errorMessage = 'An error occurred. Please try again.';
        if (responseBody.containsKey('error')) {
          final errorField = responseBody['error'];
          if (errorField is String) {
            errorMessage = errorField;
          } else if (errorField is Map) {
            errorMessage = errorField['message'] ?? errorField.toString();
          }
        } else if (responseBody.containsKey('message')) {
          errorMessage = responseBody['message'];
        }
        
        ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    }
    } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Unexpected error. Please try again.")),
        );
    } finally {
      setState(() {
        _isLoading = false;
      }); 
    }
  }

  Future<void> verifyCode() async {
    setState(() {
      _isLoading = true;
    });

    final response = await http.post(
      Uri.parse('$apiUrl/verify-code'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "email": _emailController.text,
        "code": _codeController.text,
      }),
    );

    setState(() {
      _isLoading = false;
    });

    if (response.statusCode == 200) {
      setState(() {
        _isCodeVerified = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Enter your new password.")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Invalid code. Try again.")),
      );
    }
  }

  // Function to change the password
  Future<void> changePassword() async {
  String password = _passwordController.text;
  String confirmPassword = _confirmPasswordController.text;

  if (password != confirmPassword) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Passwords do not match.")),
    );
    return;
  }

  if (!isValidPassword(password)) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Password must be at least 8 characters, "
          "include 1 uppercase letter, 1 number, and 1 special character.")),
    );
    return;
  }

  setState(() {
    _isLoading = true;
  });

  final response = await http.post(
    Uri.parse('$apiUrl/change-password'),
    headers: {"Content-Type": "application/json"},
    body: jsonEncode({
      "email": _emailController.text,
      "password": password,
    }),
  );

  setState(() {
    _isLoading = false;
  });

  if (response.statusCode == 200) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Password reset successful.")),
    );
    Navigator.pop(context);
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Error changing password. Try again.")),
    );
  }
}

  void handleFindButton() {
    if (_emailController.text.isNotEmpty) {
      setState(() {
        _isEmailValid = true;
      });
      sendCodeToEmail(_emailController.text);
    } else {
      setState(() {
        _isEmailValid = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text("Forgot Password"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            if (!_isEmailEntered)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Enter your email:"),
                  TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: "Email",
                      errorText: !_isEmailValid ? "Please enter a valid email address" : null,
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: handleFindButton,
                    child: Text("Find"),
                  ),
                ],
              ),
            if (_isEmailEntered && _isCodeSent && !_isCodeVerified)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Enter the 6-digit code sent to your email:"),
                  TextField(
                    controller: _codeController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "6-digit Code",
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: verifyCode,
                    child: Text("Verify Code"),
                  ),
                ],
              ),
            if (_isEmailEntered && _isCodeVerified)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Create a new password:"),
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "Password",
                    ),
                  ),
                  SizedBox(height: 20),
                  Text("Confirm your password:"),
                  TextField(
                    controller: _confirmPasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "Confirm Password",
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: changePassword,
                    child: Text("Reset Password"),
                  ),
                ],
              ),
            if (_isLoading) Center(child: CircularProgressIndicator()),
          ],
        ),
      ),
    );
  }
}
