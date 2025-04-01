import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RatingPage extends StatefulWidget {
  final String recruiterId;
  final Map<String, dynamic> studentData;

  RatingPage({required this.recruiterId, required this.studentData});

  @override
  _RatingPageState createState() => _RatingPageState();
}

class _RatingPageState extends State<RatingPage> {
  final Map<String, int> ratings = {
    'Communication': 3,
  };


  @override
  Widget build(BuildContext context) {

  final studentName = '${widget.studentData['FirstName']} ${widget.studentData['LastName']}';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(

              children: [
                SizedBox(height: 20),
                Text("How Would You Rate $studentName?"),
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
                                fontSize: 16,
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
                    // do api later
                    int totalScore = ratings.values.map((value) => (value).toInt()).reduce((a, b) => a + b);
                    print("Total Score: $totalScore");
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFD4F6FF),
                  ),
                  child: Text('Submit'),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
