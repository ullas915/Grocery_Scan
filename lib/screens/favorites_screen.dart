import 'package:flutter/material.dart';

import '../service/storage_service.dart';


class FavoritesScreen extends StatefulWidget {
  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  List<Map<String, dynamic>> favorites = [];
  final StorageService _storageService = StorageService();

  @override
  void initState() {
    super.initState();
    loadFavorites();
  }
  Future<void> loadFavorites() async {
    final favs = await _storageService.getFavorites();
    print("Favorites Loaded: ${favs.length} items"); // Debugging
    for (var fav in favs) {
      print("Favorite Product: ${fav['product_name']} - Barcode: ${fav['barcode']}");
    }
    setState(() => favorites = favs);
  }



  Future<void> removeFavorite(String barcode) async {
    await _storageService.removeFavorite(barcode);
    loadFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Favorites")),
      body: favorites.isEmpty
          ? Center(child: Text("No favorites added yet."))
          : ListView.builder(
        itemCount: favorites.length,
        itemBuilder: (context, index) {
          final item = favorites[index];
          return ListTile(
            leading: Image.network(
              item['image_url'] ?? '',
              height: 50,
              width: 50,
              errorBuilder: (context, error, stackTrace) {
                return Icon(Icons.image_not_supported);
              },
            ),
            title: Text(item['product_name'] ?? 'Unknown Product'),
            subtitle: Text(item['brands'] ?? 'Unknown Brand'),
            trailing: IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () => removeFavorite(item['barcode']),
            ),
          );
        },
      ),
    );
  }
}