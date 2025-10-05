class SubscriptionPackage {
  final int id;
  final String name;
  final String? description;
  final int durationMonths;
  final double price;
  final double? originalPrice;
  final bool isActive;
  final int sortOrder;
  final List<String>? features;
  final String? badge;
  final DateTime createdAt;
  final DateTime updatedAt;

  SubscriptionPackage({
    required this.id,
    required this.name,
    this.description,
    required this.durationMonths,
    required this.price,
    this.originalPrice,
    this.isActive = true,
    this.sortOrder = 0,
    this.features,
    this.badge,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SubscriptionPackage.fromJson(Map<String, dynamic> json) {
    return SubscriptionPackage(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      description: json['description'],
      durationMonths: json['duration_months'] ?? 0,
      price: double.tryParse(json['price'].toString()) ?? 0.0,
      originalPrice: json['original_price'] != null 
          ? double.tryParse(json['original_price'].toString()) 
          : null,
      isActive: json['is_active'] ?? true,
      sortOrder: json['sort_order'] ?? 0,
      features: json['features'] != null 
          ? List<String>.from(json['features']) 
          : null,
      badge: json['badge'],
      createdAt: DateTime.parse(json['created_at'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(json['updated_at'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'duration_months': durationMonths,
      'price': price,
      'original_price': originalPrice,
      'is_active': isActive,
      'sort_order': sortOrder,
      'features': features,
      'badge': badge,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  // Helper getters
  String get formattedPrice => '${price.toInt()} MRU';
  
  String? get formattedOriginalPrice => originalPrice != null 
      ? '${originalPrice!.toInt()} MRU' 
      : null;

  int? get discountPercentage {
    if (originalPrice == null || originalPrice! <= price) {
      return null;
    }
    return (((originalPrice! - price) / originalPrice!) * 100).round();
  }

  bool get hasDiscount => originalPrice != null && originalPrice! > price;

  String get durationText {
    if (durationMonths == 1) {
      return '1 mois';
    } else if (durationMonths == 12) {
      return '1 année';
    } else {
      return '$durationMonths mois';
    }
  }

  String get pricePerMonth {
    final monthlyPrice = price / durationMonths;
    return '${monthlyPrice.toInt()} MRU/mois';
  }
}
