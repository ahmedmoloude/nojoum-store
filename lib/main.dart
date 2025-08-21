import 'package:flutter/material.dart';
import 'screens/marketplace_home_screen.dart';
import 'utils/constants.dart';
import 'utils/themes.dart';

void main() {
  runApp(const NoujoumStoreApp());
}

/// Main application widget for Noujoum Store Marketplace
class NoujoumStoreApp extends StatelessWidget {
  const NoujoumStoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appName,
      theme: AppThemes.lightTheme,
      home: const MarketplaceHomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}


