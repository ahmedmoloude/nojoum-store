import 'subscription_package.dart';

enum SubscriptionStatus { freeTrial, active, expired, cancelled }

class UserSubscription {
  final int id;
  final int userId;
  final int? packageId;
  final SubscriptionStatus status;
  final DateTime startsAt;
  final DateTime expiresAt;
  final DateTime? freeTrialEndsAt;
  final bool isFreeTrial;
  final double? amountPaid;
  final String currency;
  final String? notes;
  final SubscriptionPackage? package;
  final DateTime createdAt;
  final DateTime updatedAt;

  UserSubscription({
    required this.id,
    required this.userId,
    this.packageId,
    required this.status,
    required this.startsAt,
    required this.expiresAt,
    this.freeTrialEndsAt,
    this.isFreeTrial = false,
    this.amountPaid,
    this.currency = 'MRU',
    this.notes,
    this.package,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserSubscription.fromJson(Map<String, dynamic> json) {
    return UserSubscription(
      id: json['id'] ?? 0,
      userId: json['user_id'] ?? 0,
      packageId: json['package_id'],
      status: _parseStatus(json['status']),
      startsAt: DateTime.parse(json['starts_at'] ?? DateTime.now().toIso8601String()),
      expiresAt: DateTime.parse(json['expires_at'] ?? DateTime.now().toIso8601String()),
      freeTrialEndsAt: json['free_trial_ends_at'] != null 
          ? DateTime.parse(json['free_trial_ends_at']) 
          : null,
      isFreeTrial: json['is_free_trial'] ?? false,
      amountPaid: json['amount_paid'] != null 
          ? double.tryParse(json['amount_paid'].toString()) 
          : null,
      currency: json['currency'] ?? 'MRU',
      notes: json['notes'],
      package: json['package'] != null 
          ? SubscriptionPackage.fromJson(json['package']) 
          : null,
      createdAt: DateTime.parse(json['created_at'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(json['updated_at'] ?? DateTime.now().toIso8601String()),
    );
  }

  static SubscriptionStatus _parseStatus(String? status) {
    switch (status) {
      case 'free_trial':
        return SubscriptionStatus.freeTrial;
      case 'active':
        return SubscriptionStatus.active;
      case 'expired':
        return SubscriptionStatus.expired;
      case 'cancelled':
        return SubscriptionStatus.cancelled;
      default:
        return SubscriptionStatus.freeTrial;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'package_id': packageId,
      'status': status.name,
      'starts_at': startsAt.toIso8601String(),
      'expires_at': expiresAt.toIso8601String(),
      'free_trial_ends_at': freeTrialEndsAt?.toIso8601String(),
      'is_free_trial': isFreeTrial,
      'amount_paid': amountPaid,
      'currency': currency,
      'notes': notes,
      'package': package?.toJson(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  // Helper getters
  bool get isActive => status == SubscriptionStatus.active && expiresAt.isAfter(DateTime.now());
  
  bool get isInFreeTrial => isFreeTrial && 
      status == SubscriptionStatus.freeTrial && 
      (freeTrialEndsAt?.isAfter(DateTime.now()) ?? expiresAt.isAfter(DateTime.now()));
  
  bool get isExpired => expiresAt.isBefore(DateTime.now()) || status == SubscriptionStatus.expired;
  
  int get daysRemaining {
    if (isExpired) return 0;
    return expiresAt.difference(DateTime.now()).inDays;
  }

  String get statusLabel {
    switch (status) {
      case SubscriptionStatus.freeTrial:
        return 'Essai gratuit';
      case SubscriptionStatus.active:
        return 'Actif';
      case SubscriptionStatus.expired:
        return 'Expiré';
      case SubscriptionStatus.cancelled:
        return 'Annulé';
    }
  }

  String get timeRemainingText {
    if (isExpired) return 'Expiré';
    
    final days = daysRemaining;
    if (days == 0) {
      return 'Expire aujourd\'hui';
    } else if (days == 1) {
      return 'Expire demain';
    } else if (days < 30) {
      return 'Expire dans $days jours';
    } else {
      final months = (days / 30).floor();
      return 'Expire dans $months mois';
    }
  }

  String? get formattedAmountPaid => amountPaid != null 
      ? '${amountPaid!.toInt()} $currency' 
      : null;
}
