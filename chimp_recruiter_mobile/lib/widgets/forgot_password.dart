import 'package:flutter/material.dart';

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
  bool _isEmailValid = false;

  

  // implement api call to see if username exists, temp set to true
  bool doesExistEmail(String email) {
    return true;
  }

  // Password validation
  bool isValidPassword(String password) {
    String pattern = r'^(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(password);
  }

  // implement the email send
  void sendCodeToEmail(String email) {
    // implement the email API code

    setState(() {
      _isCodeSent = true;
    });
  }

  // check if email exists
  void handleFindButton() {
    if (_emailController.text.isNotEmpty && doesExistEmail(_emailController.text)) {
      setState(() {
        _isEmailEntered = true;
        _isEmailValid = true;
      });

      // do the email API
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
      backgroundColor: Color(0xFFFFFFFF),
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
                    onPressed: () {
                      // check if password is valid
                      if (_passwordController.text == _confirmPasswordController.text &&
                          isValidPassword(_passwordController.text)) {
                        
                          // implement the password change API

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Password reset successful! Return to login.")),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Passwords do not match or are invalid")),
                        );
                      }
                    },
                    child: Text("Reset Password"),
                  ),
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
