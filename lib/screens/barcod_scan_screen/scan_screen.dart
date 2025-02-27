
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:grocery_scan_1/screens/barcod_scan_screen/result_screen.dart';

import '../../service/barcode_service.dart';


class ScanScreen extends StatelessWidget {
  final BarcodeService _barcodeService = BarcodeService();
  final TextEditingController _manualEntryController = TextEditingController();


  Future<void> scanBarcode(BuildContext context) async {
    String? scanResult = await _barcodeService.scanBarcode(context);
    if (scanResult != null && scanResult != '-1') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ResultScreen(barcode: scanResult)),
      );
    }
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Scan Product"),

      ),
      backgroundColor:  Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.qr_code_scanner, size: 100, color: Colors.green),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => scanBarcode(context),
              child: Text("Scan Barcode"),
            ),
            SizedBox(height: 30),
            Text("Or enter barcode manually"),
            SizedBox(height: 15,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: _manualEntryController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter barcode",
                ),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                if (_manualEntryController.text.isNotEmpty) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ResultScreen(barcode: _manualEntryController.text)),
                  );
                }
              },
              child: Text("Search Product"),
            ),

          ],
        ),
      ),
    );
  }
}