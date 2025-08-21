import '../models/mauritanian_app.dart';

/// Static data containing all Mauritanian applications for the Noujoum Store Marketplace
class StaticData {
  /// List of all Mauritanian marketplace applications
  static final List<MauritanianApp> apps = [
    // Business Management Applications
    MauritanianApp(
      id: 'mauricrm_pro',
      appName: 'MauriCRM Pro',
      tagline: 'Système de gestion client professionnel',
      description: 'Solution CRM complète pour les entreprises mauritaniennes',
      detailedDescription: 'MauriCRM Pro est une solution de gestion de la relation client spécialement conçue pour les entreprises mauritaniennes. Gérez vos contacts, suivez vos ventes, automatisez votre marketing et améliorez votre service client.',
      developerName: 'TechSolutions Mauritanie',
      developerEmail: 'contact@techsolutions.mr',
      developerPhone: '+222 45 67 89 01',
      companyName: 'TechSolutions SARL',
      developerWebsite: 'https://techsolutions.mr',
      appType: AppType.saas,
      supportedPlatforms: [Platform.web, Platform.android, Platform.iOS],
      iconUrl: 'https://via.placeholder.com/150/0d47a1/FFFFFF?text=CRM',
      screenshots: [
        'https://via.placeholder.com/300x600/0d47a1/FFFFFF?text=Dashboard',
        'https://via.placeholder.com/300x600/0d47a1/FFFFFF?text=Contacts',
        'https://via.placeholder.com/300x600/0d47a1/FFFFFF?text=Sales',
      ],
      licenseType: LicenseType.monthly,
      pricingModel: PricingModel.paid,
      pricing: '500 MRU/mois',
      hasFreeTrial: true,
      trialDays: 14,
      targetAudience: 'PME et grandes entreprises',
      businessSectors: ['Commerce', 'Services', 'Industrie'],
      businessValue: 'Améliore la gestion client et augmente les ventes de 30%',
      keyFeatures: ['Gestion contacts', 'Suivi ventes', 'Rapports avancés', 'Intégration email'],
      supportOptions: [SupportType.email, SupportType.phone, SupportType.training],
      languages: ['Français', 'Arabe', 'Hassaniya'],
      downloads: 2500,
      activeUsers: 1200,
      publishDate: DateTime(2024, 1, 15),
      lastUpdate: DateTime(2024, 8, 1),
      isVerified: true,
      isFeatured: true,
      primaryCategory: 'business_management',
      subcategory: 'Systèmes CRM',
      tags: ['crm', 'ventes', 'clients', 'business'],
      rating: 4.6,
    ),

    MauritanianApp(
      id: 'pharmacie_finder',
      name: 'Pharmacie Finder MR',
      description: 'Trouvez rapidement les pharmacies ouvertes près de chez vous à Nouakchott et dans toute la Mauritanie. Vérifiez la disponibilité des médicaments.',
      iconUrl: 'https://via.placeholder.com/150/4ECDC4/FFFFFF?text=PF',
      screenshots: [
        'https://via.placeholder.com/300x600/4ECDC4/FFFFFF?text=Map',
        'https://via.placeholder.com/300x600/4ECDC4/FFFFFF?text=Search',
        'https://via.placeholder.com/300x600/4ECDC4/FFFFFF?text=Details',
      ],
      category: 'health',
      subcategory: 'Pharmacie',
      targetAudience: 'Public',
      developerName: 'TechMed Mauritanie',
      developerType: 'Company',
      contactEmail: 'contact@techmed.mr',
      contactPhone: '+222 45 67 89 02',
      websiteUrl: 'https://techmed.mr',
      tags: ['pharmacie', 'médicaments', 'urgence', 'localisation'],
      dateAdded: DateTime(2024, 2, 10),
      rating: 4.2,
      downloadCount: 8500,
      isFeatured: false,
    ),

    // Education Applications
    MauritanianApp(
      id: 'hassaniya_learn',
      name: 'Hassaniya Learn',
      description: 'Apprenez le dialecte hassaniya mauritanien avec des leçons interactives, des exercices de prononciation et des conversations pratiques.',
      iconUrl: 'https://via.placeholder.com/150/45B7D1/FFFFFF?text=HL',
      screenshots: [
        'https://via.placeholder.com/300x600/45B7D1/FFFFFF?text=Lessons',
        'https://via.placeholder.com/300x600/45B7D1/FFFFFF?text=Practice',
        'https://via.placeholder.com/300x600/45B7D1/FFFFFF?text=Progress',
      ],
      category: 'education',
      subcategory: 'Langues',
      targetAudience: 'Public',
      developerName: 'Linguistic Solutions MR',
      developerType: 'Company',
      contactEmail: 'info@linguisticsolutions.mr',
      contactPhone: '+222 45 67 89 03',
      websiteUrl: 'https://linguisticsolutions.mr',
      tags: ['hassaniya', 'langue', 'apprentissage', 'culture'],
      dateAdded: DateTime(2024, 1, 20),
      rating: 4.7,
      downloadCount: 12000,
      isFeatured: true,
    ),

    MauritanianApp(
      id: 'ecole_numerique',
      name: 'École Numérique MR',
      description: 'Plateforme d\'apprentissage en ligne pour les élèves mauritaniens. Cours de mathématiques, sciences, français et arabe adaptés au programme national.',
      iconUrl: 'https://via.placeholder.com/150/96CEB4/FFFFFF?text=EN',
      screenshots: [
        'https://via.placeholder.com/300x600/96CEB4/FFFFFF?text=Courses',
        'https://via.placeholder.com/300x600/96CEB4/FFFFFF?text=Exercises',
        'https://via.placeholder.com/300x600/96CEB4/FFFFFF?text=Results',
      ],
      category: 'education',
      subcategory: 'E-learning',
      targetAudience: 'Public',
      developerName: 'EduTech Mauritanie',
      developerType: 'Company',
      contactEmail: 'support@edutech.mr',
      contactPhone: '+222 45 67 89 04',
      websiteUrl: 'https://edutech.mr',
      tags: ['éducation', 'cours', 'élèves', 'programme'],
      dateAdded: DateTime(2024, 3, 5),
      rating: 4.4,
      downloadCount: 20000,
      isFeatured: true,
    ),

    // Agriculture Applications
    MauritanianApp(
      id: 'nomad_tracker',
      name: 'Nomad Tracker',
      description: 'Application de gestion du bétail pour les éleveurs nomades. Suivez vos troupeaux, gérez la santé animale et trouvez les meilleurs pâturages.',
      iconUrl: 'https://via.placeholder.com/150/FFEAA7/000000?text=NT',
      screenshots: [
        'https://via.placeholder.com/300x600/FFEAA7/000000?text=Livestock',
        'https://via.placeholder.com/300x600/FFEAA7/000000?text=Health',
        'https://via.placeholder.com/300x600/FFEAA7/000000?text=Pastures',
      ],
      category: 'agriculture',
      subcategory: 'Élevage',
      targetAudience: 'Public',
      developerName: 'Pastoral Tech',
      developerType: 'Company',
      contactEmail: 'info@pastoraltech.mr',
      contactPhone: '+222 45 67 89 05',
      websiteUrl: 'https://pastoraltech.mr',
      tags: ['élevage', 'bétail', 'nomade', 'pâturage'],
      dateAdded: DateTime(2024, 2, 15),
      rating: 4.3,
      downloadCount: 5500,
      isFeatured: false,
    ),

    MauritanianApp(
      id: 'desert_weather',
      name: 'Desert Weather MR',
      description: 'Prévisions météorologiques précises pour la Mauritanie. Alertes tempêtes de sable, prévisions agricoles et conditions de navigation.',
      iconUrl: 'https://via.placeholder.com/150/DDA0DD/000000?text=DW',
      screenshots: [
        'https://via.placeholder.com/300x600/DDA0DD/000000?text=Weather',
        'https://via.placeholder.com/300x600/DDA0DD/000000?text=Alerts',
        'https://via.placeholder.com/300x600/DDA0DD/000000?text=Forecast',
      ],
      category: 'agriculture',
      subcategory: 'Météo',
      targetAudience: 'Public',
      developerName: 'Fatima Mint Abdallahi',
      developerType: 'Individual',
      contactEmail: 'fatima@desertweather.mr',
      contactPhone: '+222 45 67 89 06',
      websiteUrl: 'https://desertweather.mr',
      tags: ['météo', 'tempête', 'agriculture', 'prévision'],
      dateAdded: DateTime(2024, 1, 30),
      rating: 4.6,
      downloadCount: 18000,
      isFeatured: true,
    ),

    // Transport Applications
    MauritanianApp(
      id: 'nouakchott_taxi',
      name: 'Nouakchott Taxi',
      description: 'Service de taxi à la demande pour Nouakchott. Réservez votre course, suivez votre chauffeur en temps réel et payez facilement.',
      iconUrl: 'https://via.placeholder.com/150/FF7675/FFFFFF?text=NT',
      screenshots: [
        'https://via.placeholder.com/300x600/FF7675/FFFFFF?text=Booking',
        'https://via.placeholder.com/300x600/FF7675/FFFFFF?text=Tracking',
        'https://via.placeholder.com/300x600/FF7675/FFFFFF?text=Payment',
      ],
      category: 'transport',
      subcategory: 'Taxi',
      targetAudience: 'Public',
      developerName: 'Urban Mobility MR',
      developerType: 'Company',
      contactEmail: 'contact@urbanmobility.mr',
      contactPhone: '+222 45 67 89 07',
      websiteUrl: 'https://urbanmobility.mr',
      tags: ['taxi', 'transport', 'nouakchott', 'réservation'],
      dateAdded: DateTime(2024, 3, 10),
      rating: 4.1,
      downloadCount: 25000,
      isFeatured: true,
    ),

    // Finance Applications
    MauritanianApp(
      id: 'chinguetti_banking',
      name: 'Chinguetti Banking',
      description: 'Solution bancaire mobile complète. Gérez vos comptes, effectuez des virements, payez vos factures et suivez vos dépenses.',
      iconUrl: 'https://via.placeholder.com/150/6C5CE7/FFFFFF?text=CB',
      screenshots: [
        'https://via.placeholder.com/300x600/6C5CE7/FFFFFF?text=Dashboard',
        'https://via.placeholder.com/300x600/6C5CE7/FFFFFF?text=Transfer',
        'https://via.placeholder.com/300x600/6C5CE7/FFFFFF?text=Bills',
      ],
      category: 'finance',
      subcategory: 'Banque Mobile',
      targetAudience: 'Public',
      developerName: 'FinTech Mauritanie',
      developerType: 'Company',
      contactEmail: 'support@fintech.mr',
      contactPhone: '+222 45 67 89 08',
      websiteUrl: 'https://fintech.mr',
      tags: ['banque', 'mobile', 'virement', 'factures'],
      dateAdded: DateTime(2024, 2, 20),
      rating: 4.8,
      downloadCount: 35000,
      isFeatured: true,
    ),

    // Government Applications
    MauritanianApp(
      id: 'etat_civil_mr',
      name: 'État Civil MR',
      description: 'Demandez vos documents d\'état civil en ligne. Actes de naissance, mariage, décès et certificats de nationalité disponibles 24h/24.',
      iconUrl: 'https://via.placeholder.com/150/A29BFE/FFFFFF?text=EC',
      screenshots: [
        'https://via.placeholder.com/300x600/A29BFE/FFFFFF?text=Documents',
        'https://via.placeholder.com/300x600/A29BFE/FFFFFF?text=Request',
        'https://via.placeholder.com/300x600/A29BFE/FFFFFF?text=Status',
      ],
      category: 'government',
      subcategory: 'État Civil',
      targetAudience: 'Public',
      developerName: 'Ministère de l\'Intérieur',
      developerType: 'Government',
      contactEmail: 'etatcivil@gov.mr',
      contactPhone: '+222 45 67 89 09',
      websiteUrl: 'https://etatcivil.gov.mr',
      tags: ['état civil', 'documents', 'gouvernement', 'officiel'],
      dateAdded: DateTime(2024, 1, 10),
      rating: 4.0,
      downloadCount: 45000,
      isFeatured: false,
    ),

    MauritanianApp(
      id: 'impots_mr',
      name: 'Impôts MR',
      description: 'Gérez vos déclarations fiscales en ligne. Calculez vos impôts, soumettez vos déclarations et suivez vos remboursements.',
      iconUrl: 'https://via.placeholder.com/150/FD79A8/FFFFFF?text=IM',
      screenshots: [
        'https://via.placeholder.com/300x600/FD79A8/FFFFFF?text=Declaration',
        'https://via.placeholder.com/300x600/FD79A8/FFFFFF?text=Calculator',
        'https://via.placeholder.com/300x600/FD79A8/FFFFFF?text=Status',
      ],
      category: 'government',
      subcategory: 'Impôts',
      targetAudience: 'Public',
      developerName: 'Direction Générale des Impôts',
      developerType: 'Government',
      contactEmail: 'impots@gov.mr',
      contactPhone: '+222 45 67 89 10',
      websiteUrl: 'https://impots.gov.mr',
      tags: ['impôts', 'déclaration', 'fiscalité', 'gouvernement'],
      dateAdded: DateTime(2024, 2, 5),
      rating: 3.8,
      downloadCount: 30000,
      isFeatured: false,
    ),

    // Entertainment Applications
    MauritanianApp(
      id: 'mauritanian_recipes',
      name: 'Recettes Mauritaniennes',
      description: 'Découvrez la richesse culinaire mauritanienne. Plus de 200 recettes traditionnelles avec instructions détaillées et vidéos.',
      iconUrl: 'https://via.placeholder.com/150/E17055/FFFFFF?text=RM',
      screenshots: [
        'https://via.placeholder.com/300x600/E17055/FFFFFF?text=Recipes',
        'https://via.placeholder.com/300x600/E17055/FFFFFF?text=Video',
        'https://via.placeholder.com/300x600/E17055/FFFFFF?text=Favorites',
      ],
      category: 'entertainment',
      subcategory: 'Culture',
      targetAudience: 'Public',
      developerName: 'Aicha Mint Mohamed',
      developerType: 'Individual',
      contactEmail: 'aicha@recettesmr.com',
      contactPhone: '+222 45 67 89 11',
      websiteUrl: 'https://recettesmr.com',
      tags: ['cuisine', 'recettes', 'tradition', 'culture'],
      dateAdded: DateTime(2024, 3, 1),
      rating: 4.9,
      downloadCount: 22000,
      isFeatured: true,
    ),

    MauritanianApp(
      id: 'chinguetti_music',
      name: 'Chinguetti Music',
      description: 'Écoutez la musique traditionnelle mauritanienne. Artistes locaux, musique hassaniya et concerts en direct.',
      iconUrl: 'https://via.placeholder.com/150/00B894/FFFFFF?text=CM',
      screenshots: [
        'https://via.placeholder.com/300x600/00B894/FFFFFF?text=Player',
        'https://via.placeholder.com/300x600/00B894/FFFFFF?text=Artists',
        'https://via.placeholder.com/300x600/00B894/FFFFFF?text=Playlists',
      ],
      category: 'entertainment',
      subcategory: 'Musique',
      targetAudience: 'Public',
      developerName: 'Cultural Media MR',
      developerType: 'Company',
      contactEmail: 'info@culturalmedia.mr',
      contactPhone: '+222 45 67 89 12',
      websiteUrl: 'https://culturalmedia.mr',
      tags: ['musique', 'culture', 'artistes', 'hassaniya'],
      dateAdded: DateTime(2024, 2, 25),
      rating: 4.4,
      downloadCount: 16000,
      isFeatured: false,
    ),

    // Business Applications
    MauritanianApp(
      id: 'business_mr',
      name: 'Business MR',
      description: 'Plateforme de gestion d\'entreprise pour les PME mauritaniennes. Comptabilité, facturation, gestion des stocks et CRM.',
      iconUrl: 'https://via.placeholder.com/150/00CEC9/FFFFFF?text=BM',
      screenshots: [
        'https://via.placeholder.com/300x600/00CEC9/FFFFFF?text=Dashboard',
        'https://via.placeholder.com/300x600/00CEC9/FFFFFF?text=Invoicing',
        'https://via.placeholder.com/300x600/00CEC9/FFFFFF?text=Inventory',
      ],
      category: 'business',
      subcategory: 'Gestion',
      targetAudience: 'Business',
      developerName: 'Enterprise Solutions MR',
      developerType: 'Company',
      contactEmail: 'contact@enterprisesolutions.mr',
      contactPhone: '+222 45 67 89 13',
      websiteUrl: 'https://enterprisesolutions.mr',
      tags: ['business', 'gestion', 'comptabilité', 'PME'],
      dateAdded: DateTime(2024, 1, 25),
      rating: 4.2,
      downloadCount: 8000,
      isFeatured: false,
    ),

    // News Applications
    MauritanianApp(
      id: 'mauritanian_news',
      name: 'Actualités Mauritaniennes',
      description: 'Toute l\'actualité mauritanienne en temps réel. Politique, économie, sport, culture et international.',
      iconUrl: 'https://via.placeholder.com/150/FDCB6E/000000?text=AM',
      screenshots: [
        'https://via.placeholder.com/300x600/FDCB6E/000000?text=News',
        'https://via.placeholder.com/300x600/FDCB6E/000000?text=Categories',
        'https://via.placeholder.com/300x600/FDCB6E/000000?text=Bookmarks',
      ],
      category: 'news',
      subcategory: 'Actualités',
      targetAudience: 'Public',
      developerName: 'Media Digital MR',
      developerType: 'Company',
      contactEmail: 'redaction@mediadigital.mr',
      contactPhone: '+222 45 67 89 14',
      websiteUrl: 'https://mediadigital.mr',
      tags: ['actualités', 'news', 'politique', 'sport'],
      dateAdded: DateTime(2024, 3, 15),
      rating: 4.3,
      downloadCount: 28000,
      isFeatured: true,
    ),

    // Utilities Applications
    MauritanianApp(
      id: 'islamic_calendar_mr',
      name: 'Calendrier Islamique MR',
      description: 'Calendrier islamique complet avec heures de prière pour toutes les villes mauritaniennes, direction de la Qibla et rappels.',
      iconUrl: 'https://via.placeholder.com/150/6C5CE7/FFFFFF?text=CI',
      screenshots: [
        'https://via.placeholder.com/300x600/6C5CE7/FFFFFF?text=Calendar',
        'https://via.placeholder.com/300x600/6C5CE7/FFFFFF?text=Prayer',
        'https://via.placeholder.com/300x600/6C5CE7/FFFFFF?text=Qibla',
      ],
      category: 'utilities',
      subcategory: 'Calendrier',
      targetAudience: 'Public',
      developerName: 'Islamic Apps MR',
      developerType: 'Company',
      contactEmail: 'contact@islamicapps.mr',
      contactPhone: '+222 45 67 89 15',
      websiteUrl: 'https://islamicapps.mr',
      tags: ['islam', 'prière', 'calendrier', 'qibla'],
      dateAdded: DateTime(2024, 1, 5),
      rating: 4.7,
      downloadCount: 40000,
      isFeatured: true,
    ),

    MauritanianApp(
      id: 'adrar_markets',
      name: 'Marchés d\'Adrar',
      description: 'Prix des produits agricoles en temps réel sur les marchés mauritaniens. Comparez les prix et trouvez les meilleures offres.',
      iconUrl: 'https://via.placeholder.com/150/E84393/FFFFFF?text=MA',
      screenshots: [
        'https://via.placeholder.com/300x600/E84393/FFFFFF?text=Prices',
        'https://via.placeholder.com/300x600/E84393/FFFFFF?text=Markets',
        'https://via.placeholder.com/300x600/E84393/FFFFFF?text=Trends',
      ],
      category: 'agriculture',
      subcategory: 'Marchés',
      targetAudience: 'Public',
      developerName: 'AgriTech Mauritanie',
      developerType: 'Company',
      contactEmail: 'info@agritech.mr',
      contactPhone: '+222 45 67 89 16',
      websiteUrl: 'https://agritech.mr',
      tags: ['marchés', 'prix', 'agriculture', 'commerce'],
      dateAdded: DateTime(2024, 2, 12),
      rating: 4.1,
      downloadCount: 12000,
      isFeatured: false,
    ),

    // Additional Transport
    MauritanianApp(
      id: 'mauritania_logistics',
      name: 'Mauritania Logistics',
      description: 'Plateforme logistique pour le transport de marchandises. Connectez expéditeurs et transporteurs à travers le pays.',
      iconUrl: 'https://via.placeholder.com/150/FF7675/FFFFFF?text=ML',
      screenshots: [
        'https://via.placeholder.com/300x600/FF7675/FFFFFF?text=Shipments',
        'https://via.placeholder.com/300x600/FF7675/FFFFFF?text=Tracking',
        'https://via.placeholder.com/300x600/FF7675/FFFFFF?text=Drivers',
      ],
      category: 'transport',
      subcategory: 'Logistique',
      targetAudience: 'Business',
      developerName: 'Logistics Solutions MR',
      developerType: 'Company',
      contactEmail: 'contact@logistics.mr',
      contactPhone: '+222 45 67 89 17',
      websiteUrl: 'https://logistics.mr',
      tags: ['logistique', 'transport', 'marchandises', 'business'],
      dateAdded: DateTime(2024, 3, 8),
      rating: 4.0,
      downloadCount: 6500,
      isFeatured: false,
    ),

    // Additional Finance
    MauritanianApp(
      id: 'budget_tracker_mr',
      name: 'Budget Tracker MR',
      description: 'Gérez votre budget personnel et familial. Suivez vos dépenses, définissez des objectifs d\'épargne et recevez des conseils financiers.',
      iconUrl: 'https://via.placeholder.com/150/74B9FF/FFFFFF?text=BT',
      screenshots: [
        'https://via.placeholder.com/300x600/74B9FF/FFFFFF?text=Budget',
        'https://via.placeholder.com/300x600/74B9FF/FFFFFF?text=Expenses',
        'https://via.placeholder.com/300x600/74B9FF/FFFFFF?text=Goals',
      ],
      category: 'finance',
      subcategory: 'Budget',
      targetAudience: 'Public',
      developerName: 'Mohamed Ould Cheikh',
      developerType: 'Individual',
      contactEmail: 'mohamed@budgettracker.mr',
      contactPhone: '+222 45 67 89 18',
      websiteUrl: 'https://budgettracker.mr',
      tags: ['budget', 'épargne', 'finances', 'personnel'],
      dateAdded: DateTime(2024, 2, 28),
      rating: 4.5,
      downloadCount: 14000,
      isFeatured: false,
    ),

    // Additional Education
    MauritanianApp(
      id: 'quran_learn_mr',
      name: 'Apprendre le Coran MR',
      description: 'Application d\'apprentissage du Coran avec récitation, traduction en français et en hassaniya, et mémorisation guidée.',
      iconUrl: 'https://via.placeholder.com/150/00B894/FFFFFF?text=QC',
      screenshots: [
        'https://via.placeholder.com/300x600/00B894/FFFFFF?text=Quran',
        'https://via.placeholder.com/300x600/00B894/FFFFFF?text=Audio',
        'https://via.placeholder.com/300x600/00B894/FFFFFF?text=Progress',
      ],
      category: 'education',
      subcategory: 'Religion',
      targetAudience: 'Public',
      developerName: 'Islamic Education MR',
      developerType: 'Company',
      contactEmail: 'contact@islamicedu.mr',
      contactPhone: '+222 45 67 89 19',
      websiteUrl: 'https://islamicedu.mr',
      tags: ['coran', 'islam', 'éducation', 'religion'],
      dateAdded: DateTime(2024, 1, 18),
      rating: 4.8,
      downloadCount: 32000,
      isFeatured: true,
    ),

    // Additional Health
    MauritanianApp(
      id: 'fitness_sahara',
      name: 'Fitness Sahara',
      description: 'Programmes d\'exercices adaptés au climat mauritanien. Entraînements à domicile, nutrition et suivi de la condition physique.',
      iconUrl: 'https://via.placeholder.com/150/FD79A8/FFFFFF?text=FS',
      screenshots: [
        'https://via.placeholder.com/300x600/FD79A8/FFFFFF?text=Workouts',
        'https://via.placeholder.com/300x600/FD79A8/FFFFFF?text=Nutrition',
        'https://via.placeholder.com/300x600/FD79A8/FFFFFF?text=Progress',
      ],
      category: 'health',
      subcategory: 'Fitness',
      targetAudience: 'Public',
      developerName: 'Healthy Life MR',
      developerType: 'Company',
      contactEmail: 'info@healthylife.mr',
      contactPhone: '+222 45 67 89 20',
      websiteUrl: 'https://healthylife.mr',
      tags: ['fitness', 'sport', 'santé', 'nutrition'],
      dateAdded: DateTime(2024, 3, 12),
      rating: 4.2,
      downloadCount: 9500,
      isFeatured: false,
    ),

    // Additional Entertainment
    MauritanianApp(
      id: 'desert_games',
      name: 'Jeux du Désert',
      description: 'Collection de jeux traditionnels mauritaniens en version numérique. Sig, Dames mauritaniennes et autres jeux populaires.',
      iconUrl: 'https://via.placeholder.com/150/A29BFE/FFFFFF?text=JD',
      screenshots: [
        'https://via.placeholder.com/300x600/A29BFE/FFFFFF?text=Games',
        'https://via.placeholder.com/300x600/A29BFE/FFFFFF?text=Sig',
        'https://via.placeholder.com/300x600/A29BFE/FFFFFF?text=Scores',
      ],
      category: 'entertainment',
      subcategory: 'Jeux',
      targetAudience: 'Public',
      developerName: 'Game Studio MR',
      developerType: 'Company',
      contactEmail: 'games@gamestudio.mr',
      contactPhone: '+222 45 67 89 21',
      websiteUrl: 'https://gamestudio.mr',
      tags: ['jeux', 'tradition', 'sig', 'divertissement'],
      dateAdded: DateTime(2024, 3, 20),
      rating: 4.6,
      downloadCount: 11000,
      isFeatured: false,
    ),
  ];

  /// Get featured applications
  static List<MauritanianApp> get featuredApps =>
      apps.where((app) => app.isFeatured).toList();

  /// Get applications by category
  static List<MauritanianApp> getAppsByCategory(String category) =>
      apps.where((app) => app.category == category).toList();

  /// Get applications by target audience
  static List<MauritanianApp> getAppsByAudience(String audience) =>
      apps.where((app) => app.targetAudience == audience).toList();

  /// Get applications by developer type
  static List<MauritanianApp> getAppsByDeveloperType(String type) =>
      apps.where((app) => app.developerType == type).toList();

  /// Search applications by name or description
  static List<MauritanianApp> searchApps(String query) {
    final lowercaseQuery = query.toLowerCase();
    return apps.where((app) {
      return app.name.toLowerCase().contains(lowercaseQuery) ||
          app.description.toLowerCase().contains(lowercaseQuery) ||
          app.tags.any((tag) => tag.toLowerCase().contains(lowercaseQuery)) ||
          app.developerName.toLowerCase().contains(lowercaseQuery);
    }).toList();
  }

  /// Get app by ID
  static MauritanianApp? getAppById(String id) {
    try {
      return apps.firstWhere((app) => app.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Get recently added applications (last 30 days)
  static List<MauritanianApp> get recentApps {
    final thirtyDaysAgo = DateTime.now().subtract(const Duration(days: 30));
    return apps.where((app) => app.dateAdded.isAfter(thirtyDaysAgo)).toList()
      ..sort((a, b) => b.dateAdded.compareTo(a.dateAdded));
  }

  /// Get top rated applications
  static List<MauritanianApp> get topRatedApps {
    final sortedApps = List<MauritanianApp>.from(apps);
    sortedApps.sort((a, b) => b.rating.compareTo(a.rating));
    return sortedApps.take(10).toList();
  }

  /// Get most downloaded applications
  static List<MauritanianApp> get mostDownloadedApps {
    final sortedApps = List<MauritanianApp>.from(apps);
    sortedApps.sort((a, b) => b.downloadCount.compareTo(a.downloadCount));
    return sortedApps.take(10).toList();
  }
}
