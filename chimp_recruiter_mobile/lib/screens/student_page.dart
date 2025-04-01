import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class StudentPage extends StatefulWidget {

  final Map<String, dynamic> userData;

  StudentPage({required this.userData});

  @override
  _StudentPageState createState() => _StudentPageState();
}
class _StudentPageState extends State<StudentPage> {

  String? qrImageUrl;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchQrCode();
  }

  Future<void> fetchQrCode() async {
    final Uri apiUrl = Uri.parse('http://10.0.2.2:5001/api/generate-qr');

    try {
      final response = await http.post(
        apiUrl,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"userId": widget.userData['ID']}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          qrImageUrl = 'http://10.0.2.2:5001${data['qrImage']}';
          isLoading = false;
        });
      } else {
        print('Error: ${response.body}');
        setState(() => isLoading = false);
      }
    } catch (e) {
      print('Exception: $e');
      setState(() => isLoading = false);
    }
  }    

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/dogtag.png'),
                fit: BoxFit.cover,
              ),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.white.withOpacity(0.6), const Color.fromARGB(255, 214, 229, 255).withOpacity(0.6)],
              ),
            ),
          ),

          Positioned(
            top: 20,
            right: 20,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text('Logout', style: TextStyle(color: Colors.white)),
            ),
          ),

          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 300),
                Text(
                  '${widget.userData['FirstName']} ${widget.userData['LastName']}',
                  style: TextStyle(
                    fontFamily: 'PermanentMarker',
                    color: Colors.black,
                    fontSize: 32,
                  ),
                ),
                SizedBox(height: 25),

                isLoading
                    ? CircularProgressIndicator()
                    : qrImageUrl != null
                        ? Image.network(
                            qrImageUrl!,
                            width: 280,
                            height: 280,
                            fit: BoxFit.fill,
                          )
                        : Text("Failed to load QR code"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}