import 'package:flutter/material.dart';
import 'package:grocery_scan_1/screens/splash_screen.dart';
import 'package:grocery_scan_1/theme/app_theme.dart';
import 'package:grocery_scan_1/theme/theme_provider.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';




Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: MyApp(),
    ),
  );
}




class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'Grocery Scanner',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          home: SplashScreen(),
        );
      },
    );
  }
}
