import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../widgets/login_dialog.dart';
import '../screens/candidate_page.dart';
import '../screens/recruiter_page.dart';
import '../screens/webview_page.dart';
import '../routes/custom_route.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFC6E7FF),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/businessman.png'),
          ),
        ),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: Column(
                  children: [
                    Text(
                      'CHIMPR',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 72,
                        fontFamily: 'PermanentMarker',
                        fontWeight: FontWeight.w800,
                        letterSpacing: 2,
                      ),
                    ),
                    Text(
                      '"We Put The Fair In Career Fair"',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 22,
                        fontFamily: 'PermanentMarker',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(top: 10.0, left: 30.0, bottom: 30.0, right: 30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return LoginDialog();
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(130, 100),
                      backgroundColor: Color(0xFFD4F6FF),
                      textStyle: TextStyle(
                        fontFamily: 'PermanentMarker',
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    child: Text('Login'),
                  ),
                  SizedBox(width: 50),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context, MaterialPageRoute(
                          builder: (context) => WebViewContainer(), 
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(130, 100),
                      backgroundColor: Color(0xFFD4F6FF),
                      textStyle: TextStyle(
                        fontFamily: 'PermanentMarker',
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    child: Text('Signup'),
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
