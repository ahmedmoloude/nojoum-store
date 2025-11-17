import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'screens/main_navigation_screen.dart';
import 'services/auth_service.dart';
import 'services/language_service.dart';
import 'utils/constants.dart';
import 'utils/themes.dart';
import 'l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AuthService.initialize();
  await LanguageService.instance.initialize();

  runApp(const NoujoumStoreApp());
}

class NoujoumStoreApp extends StatelessWidget {
  const NoujoumStoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: LanguageService.instance,
      builder: (context, child) {
        return MaterialApp(
          title: AppConstants.appName,
          theme: AppThemes.lightTheme,
          home: const MainNavigationScreen(),
          debugShowCheckedModeBanner: false,

          // Internationalization configuration
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: LanguageService.supportedLocales,
          locale: LanguageService.instance.currentLocale,

          // RTL support
          builder: (context, child) {
            return Directionality(
              textDirection: LanguageService.instance.textDirection,
              child: child!,
            );
          },
        );
      },
    );
  }
}


