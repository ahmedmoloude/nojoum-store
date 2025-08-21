/// Model representing advertisement banners in the marketplace
class AdBanner {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final String targetUrl;
  final AdType adType;
  final AdPlacement placement;
  final DateTime startDate;
  final DateTime endDate;
  final bool isActive;
  final int impressions;
  final int clicks;
  final String sponsorName;

  const AdBanner({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.targetUrl,
    required this.adType,
    required this.placement,
    required this.startDate,
    required this.endDate,
    this.isActive = true,
    this.impressions = 0,
    this.clicks = 0,
    this.sponsorName = '',
  });

  /// Check if ad is currently valid
  bool get isValid {
    final now = DateTime.now();
    return isActive && 
           now.isAfter(startDate) && 
           now.isBefore(endDate);
  }

  /// Calculate click-through rate
  double get clickThroughRate {
    if (impressions == 0) return 0.0;
    return (clicks / impressions) * 100;
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'targetUrl': targetUrl,
      'adType': adType.name,
      'placement': placement.name,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'isActive': isActive,
      'impressions': impressions,
      'clicks': clicks,
      'sponsorName': sponsorName,
    };
  }

  /// Create from JSON
  factory AdBanner.fromJson(Map<String, dynamic> json) {
    return AdBanner(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      targetUrl: json['targetUrl'],
      adType: AdType.values.firstWhere((e) => e.name == json['adType']),
      placement: AdPlacement.values.firstWhere((e) => e.name == json['placement']),
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      isActive: json['isActive'] ?? true,
      impressions: json['impressions'] ?? 0,
      clicks: json['clicks'] ?? 0,
      sponsorName: json['sponsorName'] ?? '',
    );
  }
}

/// Types of advertisements
enum AdType {
  banner,
  carousel,
  sponsored,
  native,
  video
}

/// Ad placement locations
enum AdPlacement {
  homeTop,
  homeBetweenCategories,
  categoryTop,
  searchResults,
  appDetail,
  publisherDashboard
}
