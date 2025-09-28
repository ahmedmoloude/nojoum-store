/// Enums for marketplace app properties
enum AppType { mobile, web, desktop, saas, api, plugin, template }
enum Platform { iOS, android, windows, macOS, linux, web, api }
enum LicenseType { oneTime, monthly, yearly, custom, free }
enum PricingModel { free, freemium, paid, enterprise, custom }
enum SupportType { email, phone, chat, training, documentation }

/// Model representing a Mauritanian application in the Noujoum Store Marketplace
class MauritanianApp {
  final String id;
  final String appName;
  final String tagline;
  final String description;
  final String detailedDescription;

  // Developer/Publisher Info
  final String developerName;
  final String developerEmail;
  final String developerPhone;
  final String developerWhatsApp;
  final String companyName;
  final String developerWebsite;

  // App Technical Details
  final AppType appType;
  final List<Platform> supportedPlatforms;
  final String currentVersion;
  final String iconUrl;
  final List<String> screenshots;
  final List<String> demoVideos;
  final String liveDemo; // Demo URL or trial link
  final String downloadLink; // If applicable

  // Licensing & Pricing
  final LicenseType licenseType;
  final PricingModel pricingModel;
  final String pricing; // "Free", "500 MRU/month", "Custom pricing"
  final bool hasFreeTrial;
  final int trialDays;
  final bool isOpenSource;

  // Business Information
  final String targetAudience; // Individual, Small Business, Enterprise, Government
  final List<String> businessSectors; // Healthcare, Education, Retail, etc.
  final String businessValue; // What problem it solves
  final List<String> keyFeatures;
  final String technicalRequirements;

  // Support & Documentation
  final bool hasDocumentation;
  final String documentationUrl;
  final List<SupportType> supportOptions;
  final List<String> languages; // Arabic, French, English

  // Marketplace Metrics
  final int downloads;
  final int activeUsers;
  final double rating; // 1-5 stars
  final int viewCount;
  final DateTime publishDate;
  final DateTime lastUpdate;
  final bool isVerified;
  final bool isFeatured;

  // Categories & Discovery
  final String primaryCategory;
  final String subcategory;
  final List<String> tags;
  final String searchKeywords;

  const MauritanianApp({
    required this.id,
    required this.appName,
    required this.tagline,
    required this.description,
    required this.detailedDescription,

    // Developer/Publisher Info
    required this.developerName,
    required this.developerEmail,
    required this.developerPhone,
    this.developerWhatsApp = '',
    this.companyName = '',
    this.developerWebsite = '',

    // App Technical Details
    required this.appType,
    required this.supportedPlatforms,
    this.currentVersion = '1.0.0',
    required this.iconUrl,
    required this.screenshots,
    this.demoVideos = const [],
    this.liveDemo = '',
    this.downloadLink = '',

    // Licensing & Pricing
    required this.licenseType,
    required this.pricingModel,
    required this.pricing,
    this.hasFreeTrial = false,
    this.trialDays = 0,
    this.isOpenSource = false,

    // Business Information
    required this.targetAudience,
    required this.businessSectors,
    required this.businessValue,
    required this.keyFeatures,
    this.technicalRequirements = '',

    // Support & Documentation
    this.hasDocumentation = false,
    this.documentationUrl = '',
    this.supportOptions = const [],
    this.languages = const ['French'],

    // Marketplace Metrics
    this.downloads = 1000,
    this.activeUsers = 500,
    this.rating = 4.0,
    this.viewCount = 0,
    required this.publishDate,
    required this.lastUpdate,
    this.isVerified = false,
    this.isFeatured = false,

    // Categories & Discovery
    required this.primaryCategory,
    required this.subcategory,
    required this.tags,
    this.searchKeywords = '',
  });

  // Convenience getters for backward compatibility
  String get name => appName;
  String get category => primaryCategory;
  String get contactEmail => developerEmail;
  String get contactPhone => developerPhone;
  String get websiteUrl => developerWebsite;
  int get downloadCount => downloads;
  DateTime get dateAdded => publishDate;
  String get developerType => companyName.isNotEmpty ? 'Company' : 'Individual';

  /// Create a copy of this app with updated fields
  MauritanianApp copyWith({
    String? id,
    String? appName,
    String? tagline,
    String? description,
    String? detailedDescription,
    String? developerName,
    String? developerEmail,
    String? developerPhone,
    String? developerWhatsApp,
    String? companyName,
    String? developerWebsite,
    AppType? appType,
    List<Platform>? supportedPlatforms,
    String? currentVersion,
    String? iconUrl,
    List<String>? screenshots,
    List<String>? demoVideos,
    String? liveDemo,
    String? downloadLink,
    LicenseType? licenseType,
    PricingModel? pricingModel,
    String? pricing,
    bool? hasFreeTrial,
    int? trialDays,
    bool? isOpenSource,
    String? targetAudience,
    List<String>? businessSectors,
    String? businessValue,
    List<String>? keyFeatures,
    String? technicalRequirements,
    bool? hasDocumentation,
    String? documentationUrl,
    List<SupportType>? supportOptions,
    List<String>? languages,
    int? downloads,
    int? activeUsers,
    double? rating,
    int? viewCount,
    DateTime? publishDate,
    DateTime? lastUpdate,
    bool? isVerified,
    bool? isFeatured,
    String? primaryCategory,
    String? subcategory,
    List<String>? tags,
    String? searchKeywords,
  }) {
    return MauritanianApp(
      id: id ?? this.id,
      appName: appName ?? this.appName,
      tagline: tagline ?? this.tagline,
      description: description ?? this.description,
      detailedDescription: detailedDescription ?? this.detailedDescription,
      developerName: developerName ?? this.developerName,
      developerEmail: developerEmail ?? this.developerEmail,
      developerPhone: developerPhone ?? this.developerPhone,
      developerWhatsApp: developerWhatsApp ?? this.developerWhatsApp,
      companyName: companyName ?? this.companyName,
      developerWebsite: developerWebsite ?? this.developerWebsite,
      appType: appType ?? this.appType,
      supportedPlatforms: supportedPlatforms ?? this.supportedPlatforms,
      currentVersion: currentVersion ?? this.currentVersion,
      iconUrl: iconUrl ?? this.iconUrl,
      screenshots: screenshots ?? this.screenshots,
      demoVideos: demoVideos ?? this.demoVideos,
      liveDemo: liveDemo ?? this.liveDemo,
      downloadLink: downloadLink ?? this.downloadLink,
      licenseType: licenseType ?? this.licenseType,
      pricingModel: pricingModel ?? this.pricingModel,
      pricing: pricing ?? this.pricing,
      hasFreeTrial: hasFreeTrial ?? this.hasFreeTrial,
      trialDays: trialDays ?? this.trialDays,
      isOpenSource: isOpenSource ?? this.isOpenSource,
      targetAudience: targetAudience ?? this.targetAudience,
      businessSectors: businessSectors ?? this.businessSectors,
      businessValue: businessValue ?? this.businessValue,
      keyFeatures: keyFeatures ?? this.keyFeatures,
      technicalRequirements: technicalRequirements ?? this.technicalRequirements,
      hasDocumentation: hasDocumentation ?? this.hasDocumentation,
      documentationUrl: documentationUrl ?? this.documentationUrl,
      supportOptions: supportOptions ?? this.supportOptions,
      languages: languages ?? this.languages,
      downloads: downloads ?? this.downloads,
      activeUsers: activeUsers ?? this.activeUsers,
      rating: rating ?? this.rating,
      viewCount: viewCount ?? this.viewCount,
      publishDate: publishDate ?? this.publishDate,
      lastUpdate: lastUpdate ?? this.lastUpdate,
      isVerified: isVerified ?? this.isVerified,
      isFeatured: isFeatured ?? this.isFeatured,
      primaryCategory: primaryCategory ?? this.primaryCategory,
      subcategory: subcategory ?? this.subcategory,
      tags: tags ?? this.tags,
      searchKeywords: searchKeywords ?? this.searchKeywords,
    );
  }

  /// Convert to JSON for potential future API integration
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'appName': appName,
      'tagline': tagline,
      'description': description,
      'detailedDescription': detailedDescription,
      'developerName': developerName,
      'developerEmail': developerEmail,
      'developerPhone': developerPhone,
      'developerWhatsApp': developerWhatsApp,
      'companyName': companyName,
      'developerWebsite': developerWebsite,
      'appType': appType.name,
      'supportedPlatforms': supportedPlatforms.map((p) => p.name).toList(),
      'currentVersion': currentVersion,
      'iconUrl': iconUrl,
      'screenshots': screenshots,
      'demoVideos': demoVideos,
      'liveDemo': liveDemo,
      'downloadLink': downloadLink,
      'licenseType': licenseType.name,
      'pricingModel': pricingModel.name,
      'pricing': pricing,
      'hasFreeTrial': hasFreeTrial,
      'trialDays': trialDays,
      'isOpenSource': isOpenSource,
      'targetAudience': targetAudience,
      'businessSectors': businessSectors,
      'businessValue': businessValue,
      'keyFeatures': keyFeatures,
      'technicalRequirements': technicalRequirements,
      'hasDocumentation': hasDocumentation,
      'documentationUrl': documentationUrl,
      'supportOptions': supportOptions.map((s) => s.name).toList(),
      'languages': languages,
      'downloads': downloads,
      'activeUsers': activeUsers,
      'rating': rating,
      'viewCount': viewCount,
      'publishDate': publishDate.toIso8601String(),
      'lastUpdate': lastUpdate.toIso8601String(),
      'isVerified': isVerified,
      'isFeatured': isFeatured,
      'primaryCategory': primaryCategory,
      'subcategory': subcategory,
      'tags': tags,
      'searchKeywords': searchKeywords,
    };
  }

  /// Create from JSON for potential future API integration
  factory MauritanianApp.fromJson(Map<String, dynamic> json) {
    return MauritanianApp(
      id: json['id'],
      appName: json['appName'],
      tagline: json['tagline'] ?? '',
      description: json['description'],
      detailedDescription: json['detailedDescription'] ?? '',
      developerName: json['developerName'],
      developerEmail: json['developerEmail'],
      developerPhone: json['developerPhone'],
      developerWhatsApp: json['developerWhatsApp'] ?? '',
      companyName: json['companyName'] ?? '',
      developerWebsite: json['developerWebsite'] ?? '',
      appType: AppType.values.firstWhere((e) => e.name == json['appType']),
      supportedPlatforms: (json['supportedPlatforms'] as List)
          .map((p) => Platform.values.firstWhere((e) => e.name == p))
          .toList(),
      currentVersion: json['currentVersion'] ?? '1.0.0',
      iconUrl: json['iconUrl'],
      screenshots: List<String>.from(json['screenshots']),
      demoVideos: List<String>.from(json['demoVideos'] ?? []),
      liveDemo: json['liveDemo'] ?? '',
      downloadLink: json['downloadLink'] ?? '',
      licenseType: LicenseType.values.firstWhere((e) => e.name == json['licenseType']),
      pricingModel: PricingModel.values.firstWhere((e) => e.name == json['pricingModel']),
      pricing: json['pricing'],
      hasFreeTrial: json['hasFreeTrial'] ?? false,
      trialDays: json['trialDays'] ?? 0,
      isOpenSource: json['isOpenSource'] ?? false,
      targetAudience: json['targetAudience'],
      businessSectors: List<String>.from(json['businessSectors']),
      businessValue: json['businessValue'],
      keyFeatures: List<String>.from(json['keyFeatures']),
      technicalRequirements: json['technicalRequirements'] ?? '',
      hasDocumentation: json['hasDocumentation'] ?? false,
      documentationUrl: json['documentationUrl'] ?? '',
      supportOptions: (json['supportOptions'] as List)
          .map((s) => SupportType.values.firstWhere((e) => e.name == s))
          .toList(),
      languages: List<String>.from(json['languages'] ?? ['French']),
      downloads: json['downloads'] ?? 1000,
      activeUsers: json['activeUsers'] ?? 500,
      rating: json['rating']?.toDouble() ?? 4.0,
      viewCount: json['viewCount'] ?? 0,
      publishDate: DateTime.parse(json['publishDate']),
      lastUpdate: DateTime.parse(json['lastUpdate']),
      isVerified: json['isVerified'] ?? false,
      isFeatured: json['isFeatured'] ?? false,
      primaryCategory: json['primaryCategory'],
      subcategory: json['subcategory'],
      tags: List<String>.from(json['tags']),
      searchKeywords: json['searchKeywords'] ?? '',
    );
  }

  /// Create MauritanianApp from API JSON response
  factory MauritanianApp.fromApiJson(Map<String, dynamic> json) {
    return MauritanianApp(
      id: json['id'].toString(),
      appName: json['app_name'] ?? '',
      tagline: json['tagline'] ?? '',
      description: json['description'] ?? '',
      detailedDescription: json['detailed_description'] ?? '',
      developerName: json['developer_name'] ?? '',
      developerEmail: json['developer_email'] ?? '',
      developerPhone: json['developer_phone'] ?? '',
      developerWhatsApp: json['developer_whatsapp'] ?? json['developer_phone'] ?? '',
      companyName: json['company_name'] ?? '',
      developerWebsite: json['developer_website'] ?? '',
      appType: _parseAppType(json['app_type']),
      supportedPlatforms: _parsePlatforms(json['supported_platforms']),
      currentVersion: json['current_version'] ?? '1.0.0',
      iconUrl: json['icon_url'] ?? '',
      screenshots: List<String>.from(json['screenshots'] ?? []),
      demoVideos: [], // Not in current API
      liveDemo: json['live_demo'] ?? '',
      downloadLink: json['download_link'] ?? '',
      licenseType: _parseLicenseType(json['license_type']),
      pricingModel: _parsePricingModel(json['pricing_model']),
      pricing: json['pricing'] ?? 'Free',
      hasFreeTrial: json['has_free_trial'] ?? false,
      trialDays: json['trial_days'] ?? 0,
      isOpenSource: json['is_open_source'] ?? false,
      targetAudience: json['target_audience'] ?? '',
      businessSectors: List<String>.from(json['business_sectors'] ?? []),
      businessValue: json['business_value'] ?? '',
      keyFeatures: List<String>.from(json['key_features'] ?? []),
      technicalRequirements: json['technical_requirements'] ?? '',
      hasDocumentation: json['has_documentation'] ?? false,
      documentationUrl: json['documentation_url'] ?? '',
      supportOptions: _parseSupportOptions(json['support_options']),
      languages: List<String>.from(json['languages'] ?? ['Français']),
      downloads: json['downloads'] ?? 0,
      activeUsers: json['active_users'] ?? 0,
      rating: double.tryParse(json['rating']?.toString() ?? '0.0') ?? 0.0,
      viewCount: json['view_count'] ?? 0,
      publishDate: DateTime.parse(json['publish_date'] ?? DateTime.now().toIso8601String()),
      lastUpdate: DateTime.parse(json['updated_at'] ?? DateTime.now().toIso8601String()),
      isVerified: json['is_verified'] ?? false,
      isFeatured: json['is_featured'] ?? false,
      primaryCategory: json['category']?['name'] ?? json['primary_category'] ?? json['category_id']?.toString() ?? '',
      subcategory: json['subcategory'] ?? '',
      tags: List<String>.from(json['tags'] ?? []),
      searchKeywords: json['search_keywords'] ?? '',
    );
  }

  static AppType _parseAppType(String? type) {
    switch (type?.toLowerCase()) {
      case 'mobile': return AppType.mobile;
      case 'web': return AppType.web;
      case 'desktop': return AppType.desktop;
      case 'saas': return AppType.saas;
      case 'api': return AppType.api;
      case 'plugin': return AppType.plugin;
      case 'template': return AppType.template;
      default: return AppType.mobile;
    }
  }

  static List<Platform> _parsePlatforms(dynamic platforms) {
    if (platforms == null) return [Platform.android];
    
    List<String> platformList = List<String>.from(platforms);
    return platformList.map((p) {
      switch (p.toLowerCase()) {
        case 'ios': return Platform.iOS;
        case 'android': return Platform.android;
        case 'windows': return Platform.windows;
        case 'macos': return Platform.macOS;
        case 'linux': return Platform.linux;
        case 'web': return Platform.web;
        case 'api': return Platform.api;
        default: return Platform.android;
      }
    }).toList();
  }

  static LicenseType _parseLicenseType(String? type) {
    switch (type?.toLowerCase()) {
      case 'onetime': return LicenseType.oneTime;
      case 'monthly': return LicenseType.monthly;
      case 'yearly': return LicenseType.yearly;
      case 'custom': return LicenseType.custom;
      case 'free': return LicenseType.free;
      default: return LicenseType.free;
    }
  }

  static PricingModel _parsePricingModel(String? model) {
    switch (model?.toLowerCase()) {
      case 'free': return PricingModel.free;
      case 'freemium': return PricingModel.freemium;
      case 'paid': return PricingModel.paid;
      case 'enterprise': return PricingModel.enterprise;
      case 'custom': return PricingModel.custom;
      default: return PricingModel.free;
    }
  }

  static List<SupportType> _parseSupportOptions(dynamic options) {
    if (options == null) return [SupportType.email];
    
    List<String> optionList = List<String>.from(options);
    return optionList.map((o) {
      switch (o.toLowerCase()) {
        case 'email': return SupportType.email;
        case 'phone': return SupportType.phone;
        case 'chat': return SupportType.chat;
        case 'training': return SupportType.training;
        case 'documentation': return SupportType.documentation;
        default: return SupportType.email;
      }
    }).toList();
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is MauritanianApp && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'MauritanianApp(id: $id, name: $name, category: $category)';
  }
}
