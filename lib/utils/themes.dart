import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'constants.dart';

/// Theme configuration for Noujoum Store
class AppThemes {
  /// Light theme configuration
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      
      // Color scheme - Updated for logo-inspired palette
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppConstants.primaryGold,
        brightness: Brightness.light,
        primary: AppConstants.primaryGold,
        secondary: AppConstants.mauritanianGreen,
        surface: AppConstants.surfaceColor,
        background: AppConstants.backgroundColor,
        error: AppConstants.errorColor,
        tertiary: AppConstants.primaryOrange,
      ),

      // Primary colors - Updated to golden theme
      primaryColor: AppConstants.primaryGold,
      primaryColorDark: AppConstants.deepGold,
      primaryColorLight: AppConstants.lightGold,

      // Accent color - Updated to orange
      hintColor: AppConstants.primaryOrange,
      
      // Background colors
      scaffoldBackgroundColor: AppConstants.backgroundColor,
      canvasColor: AppConstants.surfaceColor,
      cardColor: AppConstants.cardColor,
      dividerColor: AppConstants.dividerColor,
      
      // App bar theme - Updated for golden theme
      appBarTheme: const AppBarTheme(
        elevation: AppConstants.elevationM,
        backgroundColor: AppConstants.primaryGold,
        foregroundColor: AppConstants.whiteTextColor,
        titleTextStyle: TextStyle(
          color: AppConstants.whiteTextColor,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        iconTheme: IconThemeData(
          color: AppConstants.whiteTextColor,
        ),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: AppConstants.primaryGold,
          statusBarIconBrightness: Brightness.light,
        ),
      ),
      
      // // Bottom navigation bar theme
      // bottomNavigationBarTheme:  BottomNavigationBarTheme(
      //   backgroundColor: AppConstants.surfaceColor,
      //   selectedItemColor: AppConstants.primaryBlue,
      //   unselectedItemColor: AppConstants.secondaryTextColor,
      //   type: BottomNavigationBarType.fixed,
      //   elevation: AppConstants.elevationM,
      // ),
      
      // Card theme
      cardTheme: const CardTheme(
        color: AppConstants.cardColor,
        elevation: AppConstants.elevationS,
        margin: EdgeInsets.all(AppConstants.marginS),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(AppConstants.borderRadiusM),
          ),
        ),
      ),
      
      // Elevated button theme - Updated for golden theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppConstants.primaryGold,
          foregroundColor: AppConstants.whiteTextColor,
          elevation: AppConstants.elevationS,
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.paddingL,
            vertical: AppConstants.paddingM,
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(AppConstants.borderRadiusM),
            ),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      
      // Outlined button theme - Updated for golden theme
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppConstants.primaryGold,
          side: const BorderSide(
            color: AppConstants.primaryGold,
            width: 1.5,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.paddingL,
            vertical: AppConstants.paddingM,
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(AppConstants.borderRadiusM),
            ),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      
      // Text button theme - Updated for golden theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppConstants.primaryGold,
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.paddingM,
            vertical: AppConstants.paddingS,
          ),
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      
      // Floating action button theme - Updated for orange theme
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppConstants.primaryOrange,
        foregroundColor: AppConstants.whiteTextColor,
        elevation: AppConstants.elevationM,
      ),
      
      // Input decoration theme
      inputDecorationTheme: const InputDecorationTheme(
        filled: true,
        fillColor: AppConstants.surfaceColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(AppConstants.borderRadiusM),
          ),
          borderSide: BorderSide(
            color: AppConstants.dividerColor,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(AppConstants.borderRadiusM),
          ),
          borderSide: BorderSide(
            color: AppConstants.dividerColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(AppConstants.borderRadiusM),
          ),
          borderSide: BorderSide(
            color: AppConstants.primaryBlue,
            width: 2.0,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(AppConstants.borderRadiusM),
          ),
          borderSide: BorderSide(
            color: AppConstants.errorColor,
          ),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: AppConstants.paddingM,
          vertical: AppConstants.paddingM,
        ),
      ),
      
      // Chip theme - Updated for golden theme
      chipTheme: const ChipThemeData(
        backgroundColor: AppConstants.backgroundColor,
        selectedColor: AppConstants.primaryGold,
        secondarySelectedColor: AppConstants.deepGold,
        labelStyle: TextStyle(
          color: AppConstants.primaryTextColor,
        ),
        secondaryLabelStyle: TextStyle(
          color: AppConstants.whiteTextColor,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: AppConstants.paddingM,
          vertical: AppConstants.paddingS,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(AppConstants.borderRadiusL),
          ),
        ),
      ),
      
      // Icon theme
      iconTheme: const IconThemeData(
        color: AppConstants.primaryTextColor,
        size: AppConstants.iconSizeM,
      ),
      
      // Primary icon theme
      primaryIconTheme: const IconThemeData(
        color: AppConstants.whiteTextColor,
        size: AppConstants.iconSizeM,
      ),
      
      // Text theme
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: AppConstants.primaryTextColor,
        ),
        displayMedium: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: AppConstants.primaryTextColor,
        ),
        displaySmall: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: AppConstants.primaryTextColor,
        ),
        headlineLarge: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: AppConstants.primaryTextColor,
        ),
        headlineMedium: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: AppConstants.primaryTextColor,
        ),
        headlineSmall: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: AppConstants.primaryTextColor,
        ),
        titleLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppConstants.primaryTextColor,
        ),
        titleMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: AppConstants.primaryTextColor,
        ),
        titleSmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: AppConstants.primaryTextColor,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: AppConstants.primaryTextColor,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: AppConstants.primaryTextColor,
        ),
        bodySmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.normal,
          color: AppConstants.secondaryTextColor,
        ),
        labelLarge: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: AppConstants.primaryTextColor,
        ),
        labelMedium: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: AppConstants.secondaryTextColor,
        ),
        labelSmall: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w500,
          color: AppConstants.hintTextColor,
        ),
      ),
    );
  }

  /// Dark theme configuration (for future implementation)
  static ThemeData get darkTheme {
    return lightTheme.copyWith(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xFF121212),
      cardColor: const Color(0xFF1E1E1E),
      // Add dark theme specific configurations here
    );
  }
}
