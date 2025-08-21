import 'package:flutter/material.dart';

/// App constants for Noujoum Store
class AppConstants {
  // App Information
  static const String appName = 'Noujoum Store';
  static const String appTagline = 'Discover & Publish Mauritanian Digital Solutions';
  static const String appTaglineArabic = 'اكتشف وانشر الحلول الرقمية الموريتانية';
  static const String appVersion = '1.0.0';

  // Professional Marketplace Colors
  static const Color primaryBlue = Color(0xFF0d47a1);
  static const Color royalBlue = Color(0xFF1976d2);
  static const Color teal = Color(0xFF00695c);
  static const Color cyan = Color(0xFF00bcd4);
  static const Color orange = Color(0xFFff9800);
  static const Color deepOrange = Color(0xFFff5722);
  static const Color successGreen = Color(0xFF4caf50);
  
  // Additional theme colors
  static const Color backgroundColor = Color(0xFFeceff1);
  static const Color surfaceColor = Color(0xFFFFFFFF);
  static const Color cardColor = Color(0xFFFFFFFF);
  static const Color dividerColor = Color(0xFFE0E0E0);
  
  // Text colors
  static const Color primaryTextColor = Color(0xFF212121);
  static const Color secondaryTextColor = Color(0xFF757575);
  static const Color hintTextColor = Color(0xFF9E9E9E);
  static const Color whiteTextColor = Color(0xFFFFFFFF);
  
  // Status colors
  static const Color successColor = Color(0xFF4CAF50);
  static const Color errorColor = Color(0xFFF44336);
  static const Color warningColor = Color(0xFFFF9800);
  static const Color infoColor = Color(0xFF2196F3);
  
  // Gradient colors
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryGreen, darkGreen],
  );
  
  static const LinearGradient accentGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryYellow, accentYellow],
  );
  
  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFFF8F9FA), Color(0xFFE9ECEF)],
  );

  // Spacing and sizing
  static const double paddingXS = 4.0;
  static const double paddingS = 8.0;
  static const double paddingM = 16.0;
  static const double paddingL = 24.0;
  static const double paddingXL = 32.0;
  
  static const double marginXS = 4.0;
  static const double marginS = 8.0;
  static const double marginM = 16.0;
  static const double marginL = 24.0;
  static const double marginXL = 32.0;
  
  static const double borderRadiusS = 4.0;
  static const double borderRadiusM = 8.0;
  static const double borderRadiusL = 12.0;
  static const double borderRadiusXL = 16.0;
  
  static const double elevationS = 2.0;
  static const double elevationM = 4.0;
  static const double elevationL = 8.0;
  static const double elevationXL = 16.0;

  // Icon sizes
  static const double iconSizeS = 16.0;
  static const double iconSizeM = 24.0;
  static const double iconSizeL = 32.0;
  static const double iconSizeXL = 48.0;
  
  // App icon sizes
  static const double appIconSizeS = 40.0;
  static const double appIconSizeM = 60.0;
  static const double appIconSizeL = 80.0;
  static const double appIconSizeXL = 120.0;

  // Animation durations
  static const Duration animationDurationFast = Duration(milliseconds: 200);
  static const Duration animationDurationMedium = Duration(milliseconds: 300);
  static const Duration animationDurationSlow = Duration(milliseconds: 500);

  // Grid and list configurations
  static const int gridCrossAxisCount = 2;
  static const double gridChildAspectRatio = 0.8;
  static const double gridSpacing = 16.0;
  
  // Search and filter
  static const int searchDebounceMs = 300;
  static const int maxSearchResults = 50;
  
  // Contact methods
  static const String phonePrefix = '+222';
  static const String emailDomain = '.mr';
  static const String whatsappPrefix = 'https://wa.me/';
  
  // Placeholder images
  static const String placeholderAppIcon = 'https://via.placeholder.com/150/00A651/FFFFFF?text=APP';
  static const String placeholderScreenshot = 'https://via.placeholder.com/300x600/00A651/FFFFFF?text=SCREENSHOT';
  
  // App store categories
  static const List<String> targetAudiences = [
    'Public',
    'Business',
    'Government',
  ];
  
  static const List<String> developerTypes = [
    'Individual',
    'Company',
    'Government',
  ];
  
  // Sort options
  static const List<String> sortOptions = [
    'Nom (A-Z)',
    'Nom (Z-A)',
    'Plus récent',
    'Plus ancien',
    'Mieux noté',
    'Plus téléchargé',
  ];
  
  // Filter options
  static const List<String> ratingFilters = [
    'Toutes les notes',
    '4+ étoiles',
    '3+ étoiles',
    '2+ étoiles',
    '1+ étoile',
  ];

  // Text styles keys for localization
  static const String welcomeTitle = 'Bienvenue sur Noujoum Store';
  static const String welcomeSubtitle = 'Découvrez les meilleures applications mauritaniennes';
  static const String featuredApps = 'Applications en vedette';
  static const String allApps = 'Toutes les applications';
  static const String categories = 'Catégories';
  static const String search = 'Rechercher';
  static const String filter = 'Filtrer';
  static const String sort = 'Trier';
  static const String contactDeveloper = 'Contacter le développeur';
  static const String share = 'Partager';
  static const String addToFavorites = 'Ajouter aux favoris';
  static const String removeFromFavorites = 'Retirer des favoris';
  static const String noResults = 'Aucun résultat trouvé';
  static const String tryDifferentSearch = 'Essayez une recherche différente';
  static const String loading = 'Chargement...';
  static const String error = 'Erreur';
  static const String retry = 'Réessayer';
  
  // Contact labels
  static const String email = 'Email';
  static const String phone = 'Téléphone';
  static const String website = 'Site web';
  static const String whatsapp = 'WhatsApp';
  
  // App details labels
  static const String developer = 'Développeur';
  static const String category = 'Catégorie';
  static const String rating = 'Note';
  static const String downloads = 'Téléchargements';
  static const String dateAdded = 'Ajouté le';
  static const String screenshots = 'Captures d\'écran';
  static const String description = 'Description';
  static const String tags = 'Tags';
  
  // Navigation labels
  static const String home = 'Accueil';
  static const String catalog = 'Catalogue';
  static const String favorites = 'Favoris';
  static const String profile = 'Profil';
  
  // Error messages
  static const String errorLoadingApps = 'Erreur lors du chargement des applications';
  static const String errorContactingDeveloper = 'Erreur lors du contact avec le développeur';
  static const String errorSharingApp = 'Erreur lors du partage de l\'application';
  static const String errorAddingToFavorites = 'Erreur lors de l\'ajout aux favoris';
  
  // Success messages
  static const String addedToFavorites = 'Ajouté aux favoris';
  static const String removedFromFavorites = 'Retiré des favoris';
  static const String appShared = 'Application partagée';
}
