import 'package:flutter/material.dart';
import 'package:grocery_scan_1/screens/ai_scan_screen/ai_scan_screen.dart';
import 'package:provider/provider.dart';
import '../theme/theme_provider.dart';
import 'barcod_scan_screen/scan_screen.dart';
import 'favorites_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("GROCERY SCANNER"),
        actions: [
          IconButton(
            icon: Icon(themeProvider.isDarkMode ? Icons.dark_mode : Icons.light_mode),
            onPressed: () {
              themeProvider.toggleTheme();
            },
          ),
        ],
      ),
      backgroundColor:  Theme.of(context).colorScheme.background,
        body: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("KNOW THE PRODUCT", style: TextStyle(fontSize: 28)),
                  SizedBox(height: 35),
                  ElevatedButton(
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ScanScreen())),
                    child: Text("Scan BarCode Of The Product"),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => FavoritesScreen())),
                    child: Text("View Favorites Product"),
                  ),
                ],
              ),
            ),
            Container(
              height: 170, // Bottom sheet height
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "TRY OUT",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AiScanScreen())),
                      child: Text("AI Scan"),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),

    );
  }
}