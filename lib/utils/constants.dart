import 'package:flutter/material.dart';

/// App constants for Noujoum Store
class AppConstants {
  // App Information
  static const String appName = 'Noujoum Store';
  static const String appTagline = '';
  static const String appTaglineArabic = 'اكتشف وانشر الحلول الرقمية الموريتانية';
  static const String appVersion = '1.0.0';

  // Logo-inspired Color Palette
  // Primary Golden Colors (from trophy and crescent)
  static const Color primaryGold = Color(0xFFFFB000);        // Main golden yellow
  static const Color goldenYellow = Color(0xFFF4B942);       // Lighter golden tone
  static const Color deepGold = Color(0xFFE6A000);           // Darker golden shade
  static const Color lightGold = Color(0xFFFFC947);          // Light golden accent

  // Secondary Orange Colors (from shop awning)
  static const Color primaryOrange = Color(0xFFE67E22);      // Main orange
  static const Color deepOrange = Color(0xFFD35400);         // Deep orange
  static const Color lightOrange = Color(0xFFF39C12);        // Light orange accent

  // Mauritanian Green (from flag)
  static const Color mauritanianGreen = Color(0xFF228B22);   // Forest green from flag
  static const Color darkGreen = Color(0xFF2E8B57);          // Sea green variant
  static const Color lightGreen = Color(0xFF32CD32);         // Lime green accent

  // Supporting Colors
  static const Color richRed = Color(0xFFC0392B);            // Rich red accent
  static const Color creamBeige = Color(0xFFF5F5DC);         // Cream/beige background
  static const Color warmGray = Color(0xFF7F8C8D);           // Warm gray

  // Legacy colors for backward compatibility (mapped to new palette)
  static const Color primaryBlue = primaryGold;              // Map to golden
  static const Color royalBlue = deepGold;                   // Map to deep gold
  static const Color teal = mauritanianGreen;                // Map to Mauritanian green
  static const Color cyan = lightGreen;                      // Map to light green
  static const Color orange = primaryOrange;                 // Map to primary orange
  static const Color successGreen = mauritanianGreen;        // Map to Mauritanian green

  // Additional legacy mappings for removed colors
  static const Color primaryGreen = mauritanianGreen;        // Map to Mauritanian green
  static const Color primaryYellow = goldenYellow;           // Map to golden yellow
  static const Color accentYellow = lightGold;               // Map to light gold

  // Updated theme colors for logo-inspired palette
  static const Color backgroundColor = Color(0xFFFAF8F5);    // Warm cream background
  static const Color surfaceColor = Color(0xFFFFFFFF);       // Pure white for cards
  static const Color cardColor = Color(0xFFFFFEFC);          // Slightly warm white for cards
  static const Color dividerColor = Color(0xFFE8E6E3);       // Warm gray divider
  
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
  
  // Gradient colors - Updated for new color palette
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [mauritanianGreen, darkGreen],
  );

  static const LinearGradient accentGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [goldenYellow, lightGold],
  );

  // New gradients for the logo-inspired theme
  static const LinearGradient goldGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryGold, deepGold],
  );

  static const LinearGradient orangeGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryOrange, deepOrange],
  );

  static const LinearGradient mauritanianGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [mauritanianGreen, darkGreen],
  );
  
  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFFFAF8F5), Color(0xFFF0EDE8)],  // Warm cream gradient
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
