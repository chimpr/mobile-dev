import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


class VerifySignup extends StatefulWidget {
  @override
  _VerifySignupState createState() => _VerifySignupState();
}

class _VerifySignupState extends State<VerifySignup> {
  final _emailController = TextEditingController();
  final _codeController = TextEditingController();

  bool _isEmailEntered = false;
  bool _isCodeSent = false;
  bool _isEmailValid = true;
  bool _isCodeVerified = false;
  bool _isLoading = false;

  final String apiUrl = 'http://chimprecruiter.online:5001/api';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text("Verify Signup"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            if (_isEmailEntered && _isCodeSent)
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
                ],
              ),
            if (_isEmailEntered && !_isCodeSent)
              Center(
                child: CircularProgressIndicator(),
              ),
          ],
        ),
      ),
    );
  }
}
