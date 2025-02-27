// import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';
// import 'package:flutter/material.dart';
//
// class BarcodeService {
//   Future<String?> scanBarcode(BuildContext context) async {
//     final result = await Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => SimpleBarcodeScannerPage()),
//     );
//     return result.toString();
//   }
// }


import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';
import 'package:flutter/material.dart';

class BarcodeService {
  Future<String?> scanBarcode(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SimpleBarcodeScannerPage()),
    );
    return result.toString();
  }
}