import 'package:chimp_recruiter_mobile/widgets/qr_scanner_dialog.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RecruiterPage extends StatefulWidget {

  final Map<String, dynamic> userData;

  RecruiterPage({required this.userData});

  @override
  _RecruiterPageState createState() => _RecruiterPageState();
}

class _RecruiterPageState extends State<RecruiterPage> {

    List<dynamic> events = [];
    bool isLoading = true;
    bool hasError = false;

    @override
    void initState() {
      super.initState();
      fetchEvents();
    }

    Future<void> fetchEvents() async {
    final recruiterId = widget.userData['ID'];
    final url = Uri.parse('http://chimprecruiter.online:5001/api/event/list/$recruiterId');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        setState(() {
          events = data['events'];
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load events');
      }
    } catch (e) {
      print('Error fetching events: $e');
      setState(() {
        isLoading = false;
        hasError = true;
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

        leadingWidth: 100,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            alignment: Alignment.center,
            width: 150,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 255, 81, 81),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              'Logout',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ),
        ),
        title: Text("Welcome, ${widget.userData['FirstName']}"),
      ),
      body: Stack(
        children: [
          
          // background image
          Positioned(
            top: -350,
            left: 0,
            right: 0,
            bottom: 0,
            child: Image.asset(
              'assets/images/letter.png',
              fit: BoxFit.contain,
            ),
          ),

          Positioned(
            left: 0,
            right: 0,
            bottom: MediaQuery.of(context).size.height / 2 - 10,
            child: Center(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Color(0xFFC6E7FF),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.black,
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 4,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
                child: Text(
                  "Your Events:",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              
            ),
          ),

          Positioned(
            right: 16,
            bottom: MediaQuery.of(context).size.height / 2 + 50,
            child: ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return QRScannerDialog(
                      recruiterId: widget.userData['ID'],
                    );
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 126, 195, 245),
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                  side: BorderSide(color: Colors.black, width: 2),
                ),
                elevation: 4,
              ),
              child: Text(
                "Scan",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          // table/grid for the events
          Positioned(
            left: 0,
            right: 0,
            bottom: 10,
            child: Container(
              height: MediaQuery.of(context).size.height / 2 - 10,
              decoration: BoxDecoration(
                color: Color(0xFFC6E7FF),
                borderRadius: BorderRadius.all(Radius.circular(10)),
                border: Border.all(
                  color: Colors.black,
                  width: 2,
                  style: BorderStyle.solid,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.transparent,
                    spreadRadius: 2,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: events.isEmpty
                  ? Center(child: Text("No events available"))
                  : ListView.builder(
                      itemCount: events.length,
                      itemBuilder: (context, index) {
                        // currently just holds the string of the objectid
                        final eventId = events[index];
                        return Container(
                          margin: EdgeInsets.symmetric(vertical: 8),
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              
                              Expanded(
                                child: Text(
                                  eventId,
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
