

import 'package:hive_flutter/adapters.dart';

class StorageService {
  static const String boxName = "favorites";

  Future<Box> openBox() async {
    if (!Hive.isBoxOpen(boxName)) {
      return await Hive.openBox(boxName);
    }
    return Hive.box(boxName);
  }

  Future<void> addFavorite(Map<String, dynamic> product) async {
    var box = await openBox();

    // Ensure we use `_id` if `barcode` is missing
    String? barcode = product['barcode']?.toString() ?? product['_id']?.toString();

    if (barcode != null && barcode.isNotEmpty) {
      if (!box.containsKey(barcode)) {
        await box.put(barcode, product);
        print("✅ Saved to Favorites: ${product['product_name'] ?? 'Unknown Product'} - Barcode: $barcode");
      } else {
        print("⚠️ Product already exists in Favorites.");
      }
    } else {
      print("❌ Invalid barcode key: $barcode");
    }
  }





  Future<void> removeFavorite(String barcode) async {
    var box = await Hive.openBox(boxName);
    await box.delete(barcode);
  }

  Future<List<Map<String, dynamic>>> getFavorites() async {
    var box = await Hive.openBox(boxName);
    return box.values.map((e) => Map<String, dynamic>.from(e)).toList();
  }
}