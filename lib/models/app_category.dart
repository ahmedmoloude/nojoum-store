import 'package:flutter/material.dart';

/// Model representing an application category in the Noujoum Store
class AppCategory {
  final String id;
  final String name;
  final String nameArabic;
  final String description;
  final IconData icon;
  final Color color;
  final List<String> subcategories;

  const AppCategory({
    required this.id,
    required this.name,
    required this.nameArabic,
    required this.description,
    required this.icon,
    required this.color,
    required this.subcategories,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AppCategory && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'AppCategory(id: $id, name: $name)';
  }
}

/// Predefined categories for Mauritanian applications
class AppCategories {
  static const health = AppCategory(
    id: 'health',
    name: 'Santé',
    nameArabic: 'الصحة',
    description: 'Applications médicales et de santé',
    icon: Icons.local_hospital,
    color: Colors.red,
    subcategories: ['Médecine', 'Pharmacie', 'Fitness', 'Nutrition'],
  );

  static const education = AppCategory(
    id: 'education',
    name: 'Éducation',
    nameArabic: 'التعليم',
    description: 'Plateformes d\'apprentissage et éducatives',
    icon: Icons.school,
    color: Colors.blue,
    subcategories: ['E-learning', 'Langues', 'Sciences', 'Histoire'],
  );

  static const agriculture = AppCategory(
    id: 'agriculture',
    name: 'Agriculture',
    nameArabic: 'الزراعة',
    description: 'Outils agricoles et d\'élevage',
    icon: Icons.agriculture,
    color: Colors.green,
    subcategories: ['Élevage', 'Cultures', 'Météo', 'Marchés'],
  );

  static const transport = AppCategory(
    id: 'transport',
    name: 'Transport',
    nameArabic: 'النقل',
    description: 'Services de transport et logistique',
    icon: Icons.directions_car,
    color: Colors.orange,
    subcategories: ['Taxi', 'Livraison', 'Transport Public', 'Logistique'],
  );

  static const finance = AppCategory(
    id: 'finance',
    name: 'Finance',
    nameArabic: 'المالية',
    description: 'Services bancaires et financiers',
    icon: Icons.account_balance,
    color: Colors.indigo,
    subcategories: ['Banque Mobile', 'Budget', 'Investissement', 'Commerce'],
  );

  static const government = AppCategory(
    id: 'government',
    name: 'Services Publics',
    nameArabic: 'الخدمات العامة',
    description: 'Services gouvernementaux numériques',
    icon: Icons.account_balance_wallet,
    color: Colors.purple,
    subcategories: ['Documents', 'Impôts', 'État Civil', 'Citoyenneté'],
  );

  static const entertainment = AppCategory(
    id: 'entertainment',
    name: 'Divertissement',
    nameArabic: 'الترفيه',
    description: 'Jeux et applications culturelles',
    icon: Icons.games,
    color: Colors.pink,
    subcategories: ['Jeux', 'Musique', 'Culture', 'Sport'],
  );

  static const businessManagement = AppCategory(
    id: 'business_management',
    name: 'Gestion d\'Entreprise',
    nameArabic: 'إدارة الأعمال',
    description: 'Solutions de gestion pour PME mauritaniennes',
    icon: Icons.business_center,
    color: Colors.teal,
    subcategories: ['Gestion des stocks', 'Systèmes CRM', 'Logiciels de comptabilité', 'Gestion de projet', 'Gestion RH', 'Systèmes POS'],
  );

  static const healthcare = AppCategory(
    id: 'healthcare',
    name: 'Santé',
    nameArabic: 'الرعاية الصحية',
    description: 'Solutions numériques pour le secteur de la santé',
    icon: Icons.local_hospital,
    color: Colors.red,
    subcategories: ['Gestion des patients', 'Systèmes de pharmacie', 'Dossiers médicaux', 'Télémédecine', 'Suivi de santé', 'Gestion d\'assurance'],
  );

  static const retailEcommerce = AppCategory(
    id: 'retail_ecommerce',
    name: 'Commerce & E-commerce',
    nameArabic: 'التجارة الإلكترونية',
    description: 'Plateformes de vente et gestion commerciale',
    icon: Icons.shopping_cart,
    color: Colors.orange,
    subcategories: ['Boutiques en ligne', 'Systèmes d\'inventaire', 'Gestion clientèle', 'Traitement des paiements', 'Suivi de livraison', 'Outils marketing'],
  );

  static const news = AppCategory(
    id: 'news',
    name: 'Actualités',
    nameArabic: 'الأخبار',
    description: 'Information et médias locaux',
    icon: Icons.newspaper,
    color: Colors.brown,
    subcategories: ['Actualités', 'Politique', 'Sport', 'Culture'],
  );

  static const utilities = AppCategory(
    id: 'utilities',
    name: 'Utilitaires',
    nameArabic: 'الأدوات',
    description: 'Outils et utilitaires pratiques',
    icon: Icons.build,
    color: Colors.grey,
    subcategories: ['Calculatrices', 'Convertisseurs', 'Calendrier', 'Outils'],
  );

  /// Get all available categories
  static List<AppCategory> get all => [
        businessManagement,
        healthcare,
        education,
        government,
        retailEcommerce,
        agriculture,
        transport,
        finance,
        entertainment,
        news,
        utilities,
      ];

  /// Get category by ID
  static AppCategory? getById(String id) {
    try {
      return all.firstWhere((category) => category.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Get categories by target audience
  static List<AppCategory> getByAudience(String audience) {
    switch (audience.toLowerCase()) {
      case 'business':
        return [business, finance, utilities];
      case 'government':
        return [government, utilities];
      case 'public':
      default:
        return all;
    }
  }
}
