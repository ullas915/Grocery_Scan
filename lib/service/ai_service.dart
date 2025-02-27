import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class ApiService {
  final String _apiKey = "AIzaSyDj27yFA_YW0S-_8NzbIEyTZO15UhK1xo8";  // Replace with your actual Gemini API key
  final String _geminiApiUrl = "https://generativelanguage.googleapis.com/v1/models/gemini-1.5-flash:generateContent"; // Updated model

  // Function to analyze the image using Gemini API
  Future<String> analyzeImage(String imagePath) async {
    try {
      // Convert image to Base64
      final bytes = await File(imagePath).readAsBytes();
      String base64Image = base64Encode(bytes);

      // Prepare the request payload with a text prompt
      final requestPayload = {
        "contents": [
          {
            "parts": [
              {"text": "Analyze this product image and provide details about what it is."},  // Added text prompt
              {
                "inlineData": {
                  "mimeType": "image/jpeg",
                  "data": base64Image
                }
              }
            ]
          }
        ]
      };

      // Send POST request to Gemini API
      final response = await http.post(
        Uri.parse("$_geminiApiUrl?key=$_apiKey"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(requestPayload),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print("API Response: $data");

        if (data['candidates'] != null && data['candidates'].isNotEmpty) {
          return data['candidates'][0]['content']['parts'][0]['text'] ?? "No description found.";
        } else {
          return "No relevant information found.";
        }
      } else {
        print("Error: ${response.statusCode} - ${response.body}");
        return "Failed to analyze the image. Please try again.";
      }
    } catch (e) {
      print("Exception: $e");
      return "An error occurred while analyzing the image.";
    }
  }
}
