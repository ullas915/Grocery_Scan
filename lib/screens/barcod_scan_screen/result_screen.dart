import 'package:flutter/material.dart';
import 'package:grocery_scan_1/screens/favorites_screen.dart';

import '../../service/product_service.dart';
import '../../service/storage_service.dart';


class ResultScreen extends StatefulWidget {
  final String barcode;
  ResultScreen({required this.barcode});

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  Map<String, dynamic>? product;
  bool isLoading = false;
  final ProductService _productService = ProductService();
  final StorageService _storageService = StorageService();


  @override
  void initState() {
    super.initState();
    getProductDetails();
  }

  Future<void> getProductDetails() async {
    setState(() => isLoading = true);
    final productData = await _productService.fetchProduct(widget.barcode);
    setState(() {
      product = productData;
      isLoading = false;
    });
  }
  Future<void> addToFavorites() async {
    if (product != null) {
      if (product!['barcode'] == null || product!['barcode'].toString().isEmpty) {
        product!['barcode'] = product!['_id']?.toString(); // Assign `_id` as barcode
      }

      print("🛒 Adding to Favorites: ${product!['product_name'] ?? 'Unknown Product'} - Barcode: ${product!['barcode']}");
      await _storageService.addFavorite(product!);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Added to favorites!")));
    } else {
      print("❌ Product data is null, cannot save to favorites.");
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Product Details"),
      ),
      backgroundColor:  Theme.of(context).colorScheme.background,

      body: Center(
        child: isLoading
            ? CircularProgressIndicator()
            : product == null
            ? Text("Product not found!")
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              product!['image_url'] ?? '',
              height: 200,
              width: 200,
              errorBuilder: (context, error, stackTrace) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error,color: Colors.lightGreenAccent,size: 100,),
                    SizedBox(height: 3,),
                    Text("Image not found..")
                  ],
                );
              },
            ),
            Center(child: Text("Name: ${product!['product_name']}", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
            Center(child: Text("Brand: ${product!['brands']}", style: TextStyle(fontSize: 16))),
              Text("Nutritional Information", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              DataTable(columns: [
                DataColumn(label: Text("Nutrient")),
                DataColumn(label: Text("Amount per 100g")),
              ], rows: [
                DataRow(cells: [DataCell(Text("Calories")), DataCell(Text("${product!['nutriments']?['energy-kcal_100g'] ?? 'N/A'} kcal"))]),
                DataRow(cells: [DataCell(Text("Protein")), DataCell(Text("${product!['nutriments']?['proteins_100g'] ?? 'N/A'} g"))]),
                DataRow(cells: [DataCell(Text("Fat")), DataCell(Text("${product!['nutriments']?['fat_100g'] ?? 'N/A'} g"))]),
                DataRow(cells: [DataCell(Text("Carbohydrates")), DataCell(Text("${product!['nutriments']?['carbohydrates_100g'] ?? 'N/A'} g"))]),
                DataRow(cells: [DataCell(Text("Sugars")), DataCell(Text("${product!['nutriments']?['sugars_100g'] ?? 'N/A'} g"))]),
              ]),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: addToFavorites,
              child: Text("Add to Favorites"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Scan Again"),
            ),
          ],
        ),
      ),
    );
  }
}