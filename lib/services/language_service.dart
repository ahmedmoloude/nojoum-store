import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageService extends ChangeNotifier {
  static const String _languageKey = 'selected_language';
  static const String _defaultLanguageCode = 'fr'; // Default to French
  
  Locale _currentLocale = const Locale(_defaultLanguageCode);
  
  // Supported locales
  static const List<Locale> supportedLocales = [
    Locale('ar'), // Arabic
    Locale('fr'), // French
  ];
  
  // Language display names
  static const Map<String, String> languageNames = {
    'ar': 'العربية',
    'fr': 'Français',
  };
  
  Locale get currentLocale => _currentLocale;
  
  String get currentLanguageCode => _currentLocale.languageCode;
  
  String get currentLanguageName => languageNames[currentLanguageCode] ?? 'Français';
  
  bool get isRTL => _currentLocale.languageCode == 'ar';
  
  static LanguageService? _instance;
  
  static LanguageService get instance {
    _instance ??= LanguageService._internal();
    return _instance!;
  }
  
  LanguageService._internal();
  
  /// Initialize the language service and load saved language preference
  Future<void> initialize() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedLanguageCode = prefs.getString(_languageKey);
      
      if (savedLanguageCode != null && 
          supportedLocales.any((locale) => locale.languageCode == savedLanguageCode)) {
        _currentLocale = Locale(savedLanguageCode);
      } else {
        // Use system locale if supported, otherwise default to French
        final systemLocale = PlatformDispatcher.instance.locale;
        if (supportedLocales.any((locale) => locale.languageCode == systemLocale.languageCode)) {
          _currentLocale = Locale(systemLocale.languageCode);
        } else {
          _currentLocale = const Locale(_defaultLanguageCode);
        }
      }
      
      notifyListeners();
    } catch (e) {
      // If there's an error, use default language
      _currentLocale = const Locale(_defaultLanguageCode);
    }
  }
  
  /// Change the current language and save preference
  Future<void> changeLanguage(String languageCode) async {
    if (!supportedLocales.any((locale) => locale.languageCode == languageCode)) {
      return; // Invalid language code
    }
    
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_languageKey, languageCode);
      
      _currentLocale = Locale(languageCode);
      notifyListeners();
    } catch (e) {
      // Handle error silently or show user feedback
      debugPrint('Error saving language preference: $e');
    }
  }
  
  /// Get the text direction for the current language
  TextDirection get textDirection {
    return isRTL ? TextDirection.rtl : TextDirection.ltr;
  }
  
  /// Check if a locale is supported
  static bool isLocaleSupported(Locale locale) {
    return supportedLocales.any((supportedLocale) => 
        supportedLocale.languageCode == locale.languageCode);
  }
  
  /// Get locale from language code
  static Locale? getLocaleFromCode(String languageCode) {
    try {
      return supportedLocales.firstWhere(
        (locale) => locale.languageCode == languageCode,
      );
    } catch (e) {
      return null;
    }
  }
  
  /// Reset to default language
  Future<void> resetToDefault() async {
    await changeLanguage(_defaultLanguageCode);
  }
  
  /// Get all available languages with their display names
  Map<String, String> getAvailableLanguages() {
    return Map.fromEntries(
      supportedLocales.map((locale) => MapEntry(
        locale.languageCode,
        languageNames[locale.languageCode] ?? locale.languageCode,
      )),
    );
  }
}
