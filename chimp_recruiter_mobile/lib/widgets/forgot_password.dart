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

  final String apiUrl = 'http://chimprecruiter.online:5001/api';

  bool isValidPassword(String password) {
    String pattern = r'^(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(password);
  }

  Future<void> sendCodeToEmail(String email) async {
    setState(() => _isLoading = true);

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
        String errorMessage = responseBody['message'] ?? 'An error occurred. Please try again.';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage)),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Unexpected error. Please try again.")),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> verifyCode() async {
    setState(() => _isLoading = true);

    final response = await http.post(
      Uri.parse('$apiUrl/verify-code'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "email": _emailController.text,
        "code": _codeController.text,
      }),
    );

    setState(() => _isLoading = false);

    if (response.statusCode == 200) {
      setState(() => _isCodeVerified = true);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Code verified. Enter a new password.")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Invalid code. Try again.")),
      );
    }
  }

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
        SnackBar(content: Text(
          "Password must be at least 8 characters, include 1 uppercase letter, 1 number, and 1 special character.",
        )),
      );
      return;
    }

    setState(() => _isLoading = true);

    final response = await http.post(
      Uri.parse('$apiUrl/change-password'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "email": _emailController.text,
        "password": password,
      }),
    );

    setState(() => _isLoading = false);

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
      setState(() => _isEmailValid = true);
      sendCodeToEmail(_emailController.text);
    } else {
      setState(() => _isEmailValid = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFD4F6FF),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Forgot Password",
          style: TextStyle(
            fontFamily: 'PermanentMarker',
            fontSize: 26,
            color: Colors.black,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              if (!_isEmailEntered) buildCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Enter your email:"),
                    SizedBox(height: 10),
                    TextField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: "Email",
                        errorText: !_isEmailValid ? "Please enter a valid email address" : null,
                        filled: true,
                        fillColor: Colors.grey[100],
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 20),
                    themedButton("Find", handleFindButton),
                  ],
                ),
              ),
              if (_isEmailEntered && _isCodeSent && !_isCodeVerified) buildCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Enter the 6-digit code sent to your email:"),
                    SizedBox(height: 10),
                    TextField(
                      controller: _codeController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: "6-digit Code",
                        filled: true,
                        fillColor: Colors.grey[100],
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 20),
                    themedButton("Verify Code", verifyCode),
                  ],
                ),
              ),
              if (_isEmailEntered && _isCodeVerified) buildCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Create a new password:"),
                    SizedBox(height: 10),
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: "Password",
                        filled: true,
                        fillColor: Colors.grey[100],
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text("Confirm your password:"),
                    SizedBox(height: 10),
                    TextField(
                      controller: _confirmPasswordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: "Confirm Password",
                        filled: true,
                        fillColor: Colors.grey[100],
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 20),
                    themedButton("Reset Password", changePassword),
                  ],
                ),
              ),
              if (_isLoading) SizedBox(height: 20),
              if (_isLoading) CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }

  // Reusable card container with styling
  Widget buildCard({required Widget child}) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: child,
    );
  }

  // Reusable styled button
  Widget themedButton(String label, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Color.fromARGB(255, 126, 195, 245),
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: Colors.black, width: 2),
        ),
        elevation: 4,
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 16,
          color: Colors.black,
        ),
      ),
    );
  }
}
