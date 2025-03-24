import 'dart:typed_data';

import 'package:chimp_recruiter_mobile/screens/rating_page.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QRScannerDialog extends StatefulWidget {
  @override
  _QRScannerDialogState createState() => _QRScannerDialogState();
}

class _QRScannerDialogState extends State<QRScannerDialog> {
  

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
                    final Uint8List? image = capture.image;
                    for (final barcode in barcodes) {
                      print('Barcode is: ${barcode.rawValue}');
                    }
                    if (image != null) {

                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => RatingPage(),
                            
                          ),

                      );
                      /*
                      showDialog(
                        context: context,
                        builder: (context) {
                          return; // TO DO: idea is to do another dialog to confirm student name
                        }
                      );*/
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
