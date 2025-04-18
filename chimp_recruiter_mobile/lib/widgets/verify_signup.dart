import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:chimp_recruiter_mobile/screens/home_screen.dart';


class VerifySignup extends StatefulWidget {
  final String email;
  final Map<String, dynamic> requestData;
  final bool isRecruiter;

  VerifySignup({required this.email, required this.requestData, required this.isRecruiter});

  @override
  _VerifySignupState createState() => _VerifySignupState();
}

class _VerifySignupState extends State<VerifySignup> {

  final TextEditingController _codeController = TextEditingController();

  bool _isLoading = false;
  bool _isEmailEntered = false;
  bool _isCodeSent = false;
  bool _isCodeVerified = false;

  final String apiUrl = 'http://chimprecruiter.online:5001/api';

  @override
  void initState() {
    super.initState();
    sendCodeToEmail(widget.email);
  }

  Future<void> sendCodeToEmail(String email) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await http.post(
        Uri.parse('$apiUrl/send-new-code'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email}),
      );

      print(response.statusCode);

      if (response.statusCode == 200) {
        setState(() {
          _isCodeSent = true;
          _isEmailEntered = true;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Verification code sent.")),
        );
      } else {
        final responseBody = jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(responseBody['message'] ?? 'Error sending code')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Network error")),
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

    try {
      final response = await http.post(
        Uri.parse('$apiUrl/verify-code'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": widget.email,
          "code": _codeController.text.trim(),
        }),
      );

      if (response.statusCode == 200) {
        setState(() {
          _isCodeVerified = true;
        });

        final endpoint = widget.isRecruiter
          ? '$apiUrl/recruiter/signup'
          : '$apiUrl/student/signup';

        final signupResponse = await http.post(
          Uri.parse(endpoint),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(widget.requestData),
        );

        if (signupResponse.statusCode == 201) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Signup successful.")),
          );

          await Future.delayed(Duration(seconds: 1));
          if (!mounted) return;
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => HomeScreen()),
            (route) => false,
          );
        } else {
          final body = jsonDecode(signupResponse.body);
          final error = body['error'] ?? 'Signup failed.';

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(error)),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Invalid code. Try again.")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error verifying code.")),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

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
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  if (_isEmailEntered && _isCodeSent && !_isCodeVerified) ...[
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
                  if (_isCodeVerified)
                    Center(
                      child: Text(
                        "✅ Email Verified!",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                ],
              ),
      ),
    );
  }
}
