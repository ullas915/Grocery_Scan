import 'dart:io';
import 'package:flutter/material.dart';

import '../../service/ai_service.dart';



class AiResultScreen extends StatefulWidget {
  final String imagePath;

  AiResultScreen({required this.imagePath});

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<AiResultScreen> {
  List<Map<String, String>> details = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    analyzeImage(widget.imagePath);
  }

  Future<void> analyzeImage(String imagePath) async {
    final apiService = ApiService();
    String productDetails = await apiService.analyzeImage(imagePath);

    setState(() {
      details = _parseResponse(productDetails);
      isLoading = false;
    });
  }

  // Function to clean text and format it into a structured list
  List<Map<String, String>> _parseResponse(String response) {
    List<Map<String, String>> structuredData = [];
    List<String> lines = response.split("\n");

    for (String line in lines) {
      // Remove unwanted characters (*, #, extra spaces)
      line = line.replaceAll(RegExp(r'[*#]'), '').trim();

      if (line.contains(":")) {
        List<String> parts = line.split(":");
        structuredData.add({
          "title": parts[0].trim(),
          "value": parts.sublist(1).join(":").trim()
        });
      }
    }

    return structuredData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Product Details')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 16.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    blurRadius: 10,
                    spreadRadius: 3,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.file(File(widget.imagePath), fit: BoxFit.cover,width: 280,height: 280,),
              ),
            ),
            isLoading
                ? Center(child: CircularProgressIndicator())
                : Expanded(
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: ListView.builder(
                    itemCount: details.length,
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            details[index]['title'] ?? "",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            details[index]['value'] ?? "",
                            style: TextStyle(fontSize: 14),
                          ),
                          Divider(),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
