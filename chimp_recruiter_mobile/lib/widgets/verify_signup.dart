import 'package:flutter/material.dart';

class VerifySignup extends StatefulWidget {
  @override
  _VerifySignupState createState() => _VerifySignupState();
}

class _VerifySignupState extends State<VerifySignup> {

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
