// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class ProductService {
//   final FirebaseFirestore _db = FirebaseFirestore.instance;
//
//   Future<Map<String, dynamic>?> fetchProduct(String barcode) async {
//     final response = await http.get(Uri.parse('https://world.openfoodfacts.org/api/v0/product/$barcode.json'));
//     if (response.statusCode == 200) {
//       final data = json.decode(response.body);
//       return data['status'] == 1 ? data['product'] : null;
//     }
//     return null;
//   }
//
//   Future<void> saveProduct(Map<String, dynamic> product) async {
//     await _db.collection('products').add({
//       'name': product['product_name'],
//       'brand': product['brands'],
//       'image': product['image_url'],
//       'ingredients': product['ingredients_text'],
//       'timestamp': FieldValue.serverTimestamp(),
//     });
//   }
// }


// for single api
// import 'dart:convert';
// import 'package:http/http.dart' as http;
//
// class ProductService {
//   Future<Map<String, dynamic>?> fetchProduct(String barcode) async {
//     final response = await http.get(Uri.parse('https://world.openfoodfacts.org/api/v0/product/$barcode.json'));
//     if (response.statusCode == 200) {
//       final data = json.decode(response.body);
//       return data['status'] == 1 ? data['product'] : null;
//     }
//     return null;
//   }
// }



//for multiple api
import 'dart:convert';
import 'package:http/http.dart' as http;

class ProductService {
  Future<Map<String, dynamic>?> fetchProduct(String barcode) async {
    Map<String, dynamic>? product;

    // 1️⃣ Try OpenFoodFacts API
    product = await _fetchFromOpenFoodFacts(barcode);
    if (product != null) return product;

    // 2️⃣ Try UPCitemDB API
    product = await _fetchFromUPCItemDB(barcode);
    if (product != null) return product;

    // 3️⃣ Try Barcode Lookup API
    product = await _fetchFromBarcodeLookup(barcode);
    if (product != null) return product;

    // // 4️⃣ Try Nutritionix API
    // product = await _fetchFromNutritionix(barcode);
    // if (product != null) return product;

    // 5️⃣ If all fail, return null
    return null;
  }

  Future<Map<String, dynamic>?> _fetchFromOpenFoodFacts(String barcode) async {
    final response = await http.get(Uri.parse('https://world.openfoodfacts.org/api/v0/product/$barcode.json'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['status'] == 1) return data['product'];
    }
    return null;
  }

  Future<Map<String, dynamic>?> _fetchFromUPCItemDB(String barcode) async {
    final apiKey = "YOUR_UPCITEMDB_API_KEY";
    final response = await http.get(Uri.parse('https://api.upcitemdb.com/prod/trial/lookup?upc=$barcode'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['code'] == "OK" && data['items'].isNotEmpty) return data['items'][0];
    }
    return null;
  }

  Future<Map<String, dynamic>?> _fetchFromBarcodeLookup(String barcode) async {
    final apiKey = "brbio1irw30ot3bastb1pw9v8gnfvs";
    final response = await http.get(Uri.parse('https://api.barcodelookup.com/v2/products?barcode=$barcode&key=$apiKey'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['products'].isNotEmpty) return data['products'][0];
    }
    return null;
  }

  //need api
  // Future<Map<String, dynamic>?> _fetchFromNutritionix(String barcode) async {
  //   final apiKey = "YOUR_NUTRITIONIX_API_KEY";
  //   final appId = "YOUR_NUTRITIONIX_APP_ID";
  //   final response = await http.get(Uri.parse('https://trackapi.nutritionix.com/v2/search/item?upc=$barcode'),
  //       headers: {
  //         "x-app-id": appId,
  //         "x-app-key": apiKey
  //       }
  //   );
  //   if (response.statusCode == 200) {
  //     final data = json.decode(response.body);
  //     if (data['foods'].isNotEmpty) return data['foods'][0];
  //   }
  //   return null;
  // }
}
