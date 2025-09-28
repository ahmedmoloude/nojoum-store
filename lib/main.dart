import 'package:flutter/material.dart';
import 'screens/main_navigation_screen.dart';
import 'services/auth_service.dart';
import 'utils/constants.dart';
import 'utils/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AuthService.initialize();

  runApp(const NoujoumStoreApp());
}

class NoujoumStoreApp extends StatelessWidget {
  const NoujoumStoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appName,
      theme: AppThemes.lightTheme,
      home: const MainNavigationScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}


