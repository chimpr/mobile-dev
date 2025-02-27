import 'package:flutter/material.dart';

void main() {
  runApp( MyApp() );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/chimp.jpg'),
            fit: BoxFit.cover,
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
                        fontFamily: 'IrishGrover',
                        fontWeight: FontWeight.w800,
                        letterSpacing: 2,
                      ),
                    ),
                    Text(
                      '"We Put The Fair In Career Fair"',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 24,
                        fontFamily: 'IrishGrover',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Spacer(),

            Align(
              alignment: Alignment(0, 0),
              child: Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: Text(
                  'I am a...',
                  style: TextStyle(
                    fontFamily: 'IrishGrover',
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 10.0, left: 30.0, bottom: 30.0, right: 30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        createRoute(RecruiterPage(), 1)
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(50, 100),
                      backgroundColor: Colors.amber[900],
                      textStyle: TextStyle(
                        fontFamily: 'IrishGrover',
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    child: Text('Recruiter'),
                  ),

                  SizedBox(width: 50),

                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        createRoute(CandidatePage(), 2),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(50, 100),
                      backgroundColor: Colors.amber[900],
                      textStyle: TextStyle(
                        fontFamily: 'IrishGrover',
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    child: Text('Candidate'),
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

class CandidatePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Back to Home Page')),
      body: Center(
        child: Text(
          'Temporary Candidate Page',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

class RecruiterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Back to Home Page')),
      body: Center(
        child: Text(
          'Temporary Recruiter Page',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

// Custom Route with Slide Transition (direction 1 is left-to-right, direction 2 is right-to-left)
Route createRoute(Widget page, int direction) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      Offset begin;

      if (direction == 1) {
        begin = Offset(-1.0, 0.0);
      }
      else if (direction == 2) {
        begin = Offset(1.0, 0.0);
      }
      else {
        begin = Offset(1.0, 0.0);
      }

      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}



