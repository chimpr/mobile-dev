import 'package:flutter/material.dart';

class RatingPage extends StatefulWidget {
  RatingPage();

  @override
  _RatingPageState createState() => _RatingPageState();
}

class _RatingPageState extends State<RatingPage> {
  final Map<String, double> ratings = {
    'Communication': 3,
    'Creativity': 3,
    'Efficiency': 3,
    'Technical Knowledge': 3,
    'Adaptability': 3,
    'Bonus': 3,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Rate Student')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ...ratings.keys.map((category) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    category,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Slider(
                    value: ratings[category]!,
                    min: 1,
                    max: 5,
                    divisions: 4,
                    label: ratings[category]!.round().toString(),
                    onChanged: (value) {
                      setState(() {
                        ratings[category] = value;
                      });
                    },
                  ),
                ],
              );
            }).toList(),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // do later
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
