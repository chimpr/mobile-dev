import 'dart:typed_data';
import 'dart:convert';
import 'package:chimp_recruiter_mobile/screens/rating_page.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:http/http.dart' as http;

class QRScannerDialog extends StatefulWidget {
  final String recruiterId;

  QRScannerDialog({required this.recruiterId});

  @override
  _QRScannerDialogState createState() => _QRScannerDialogState();
}

class _QRScannerDialogState extends State<QRScannerDialog> {
  bool isProcessing = false;

  bool isValidId(String id) {
    final regex = RegExp(r'^[a-fA-F0-9]{24}$');
    return regex.hasMatch(id);
  }

  Future<void> fetchStudentAndNavigate(String studentId) async {
    setState(() {
      isProcessing = true;
    });

    final url = Uri.parse('http://10.0.2.2:5001/api/student/$studentId');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final studentData = json.decode(response.body);
        if (!mounted) return;

        Navigator.of(context).pop(); // close dialog
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => RatingPage(
              recruiterId: widget.recruiterId,
              studentData: studentData,
            ),
          ),
        );
      } else if (response.statusCode == 404) {
        if (mounted) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Student not found")),
          );
        }
      } else {
        throw Exception("Unexpected server error");
      }
    } catch (e) {
      print("Error: $e");
      if (mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error fetching student info")),
        );
      }
    } finally {
      if (mounted) setState(() => isProcessing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      insetPadding: EdgeInsets.only(top: 10.0, left: 20.0, bottom: 30.0, right: 20.0),
      elevation: 16,
      child: Container(
        width: double.maxFinite,
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Scan QR Code',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),

            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: MobileScanner(
                  controller: MobileScannerController(
                    detectionSpeed: DetectionSpeed.noDuplicates,
                    returnImage: true,
                  ),
                  onDetect: (capture) {
                    final List<Barcode> barcodes = capture.barcodes;

                    for (final barcode in barcodes) {
                      final scannedId = barcode.rawValue;

                      if (scannedId != null) {
                        if (isValidId(scannedId)) {
                          fetchStudentAndNavigate(scannedId);
                          break;
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Invalid QR code. Please scan a valid student QR.")),
                          );
                        }
                      }
                    }
                  },
                ),
              ),
            ),
            SizedBox(height: 10),

            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Done'),
            ),
          ],
        ),
      ),
    );
  }
}
