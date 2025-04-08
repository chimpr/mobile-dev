import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:chimp_recruiter_mobile/screens/home_screen.dart';

class RatingPage extends StatefulWidget {
  final String recruiterId;
  final String eventId;
  final Map<String, dynamic> studentData;

  RatingPage({required this.recruiterId, required this.eventId, required this.studentData});

  @override
  _RatingPageState createState() => _RatingPageState();
}

class _RatingPageState extends State<RatingPage> {
  final Map<String, int> ratings = {
    'Communication': 3,
  };

  bool _isSubmitting = false;

  Future<void> submitScan() async {
    setState(() {
      _isSubmitting = true;
    });

    int totalScore = ratings.values.reduce((a, b) => a + b);
    final studentId = widget.studentData['_id'];
    final recruiterId = widget.recruiterId;
    final eventId = widget.eventId;

    final url = Uri.parse('http://chimprecruiter.online:5001/api/scans');
    final storage = FlutterSecureStorage();
    final token = await storage.read(key: 'jwt');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'Student_ID': studentId,
          'Recruiter_ID': recruiterId,
          'Event_ID' : eventId,
          'Score': totalScore,
        }),
      );

      if (response.statusCode == 201) {
        final data = json.decode(response.body);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Score has been submitted.')),
        );

        Navigator.pop(context);
      } else if (response.statusCode == 403) {
        await storage.delete(key: 'jwt');
        if (!mounted) return;

        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => HomeScreen()),
          (route) => false,
        );
      } else {
        print('Failed with status: ${response.statusCode}');
        print('Response body: ${response.body}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to submit score.')),
        );
      }
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred.')),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {

  final studentName = '${widget.studentData['FirstName']} ${widget.studentData['LastName']}';
  String imagePath = 'assets/images/rating${ratings['Communication']}.png';

  return Scaffold(
    appBar: AppBar(
      backgroundColor: Color(0xFFD4F6FF),
      elevation: 0,
      leadingWidth: 100,
      leading: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(left: 10, top: 8, bottom: 8),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 255, 81, 81),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            'Cancel',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
        ),
      ),
    ),
    body: Container(
      color: Color(0xFFD4F6FF),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 20),
                Text(
                  style: TextStyle(
                    fontFamily: 'PermanentMarker',
                    fontSize: 28,
                  ),
                  "How Would You Rate"
                  ),
                Text(
                style: TextStyle(
                  fontFamily: 'PermanentMarker',
                  fontSize: 28,
                ),
                "$studentName?"
                ),
                SizedBox(height: 20),
      
                Image.asset(
                  imagePath,
                  width: 200,
                  height: 200,
                  fit: BoxFit.contain,
                ),
                SizedBox(height: 20),
                
                ...ratings.keys.map((category) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        category,
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 20),
                      Wrap(
                        spacing: 8.0,
                        children: List<Widget>.generate(5, (index) {
                          final score = index + 1;
                          return ChoiceChip(
                            label: Text(
                              score.toString(),
                              style: TextStyle(
                                fontSize: 20,
                              ),
                              ),
                            labelPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                            selected: ratings[category] == score,
                            onSelected: (bool selected) {
                              setState(() {
                                ratings[category] = score;
                              });
                            },
                            showCheckmark: false,
                            selectedColor: Color.fromARGB(255, 108, 222, 253),
                            backgroundColor: Colors.grey.shade200,
                            labelStyle: TextStyle(
                              color: ratings[category] == score ? Colors.white : Colors.black,
                            ),
                          );
                        }),
                      ),
                      SizedBox(height: 20),
                    ],
                  );
                }).toList(),
                SizedBox(height: 30),
                Text(
                  'Score: ${ratings.values.map((value) => (value).toInt()).reduce((a, b) => a + b)}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    submitScan();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 108, 222, 253),
                  ),
                  child: Text('Submit'),
                ),
                SizedBox(height: 10),
              ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
