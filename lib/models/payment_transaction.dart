import 'subscription_package.dart';
import 'user_subscription.dart';
import 'user.dart';

enum TransactionStatus { pending, approved, rejected, cancelled }

class PaymentTransaction {
  final int id;
  final int userId;
  final int? subscriptionId;
  final int packageId;
  final String transactionReference;
  final double amount;
  final String currency;
  final TransactionStatus status;
  final String paymentMethod;
  final String? transactionImageUrl;
  final String? userNotes;
  final String? adminNotes;
  final int? reviewedBy;
  final DateTime? reviewedAt;
  final DateTime? paidAt;
  final SubscriptionPackage? package;
  final UserSubscription? subscription;
  final User? reviewer;
  final DateTime createdAt;
  final DateTime updatedAt;

  PaymentTransaction({
    required this.id,
    required this.userId,
    this.subscriptionId,
    required this.packageId,
    required this.transactionReference,
    required this.amount,
    this.currency = 'MRU',
    required this.status,
    this.paymentMethod = 'bank_transfer',
    this.transactionImageUrl,
    this.userNotes,
    this.adminNotes,
    this.reviewedBy,
    this.reviewedAt,
    this.paidAt,
    this.package,
    this.subscription,
    this.reviewer,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PaymentTransaction.fromJson(Map<String, dynamic> json) {
    return PaymentTransaction(
      id: json['id'] ?? 0,
      userId: json['user_id'] ?? 0,
      subscriptionId: json['subscription_id'],
      packageId: json['package_id'] ?? 0,
      transactionReference: json['transaction_reference'] ?? '',
      amount: double.tryParse(json['amount'].toString()) ?? 0.0,
      currency: json['currency'] ?? 'MRU',
      status: _parseStatus(json['status']),
      paymentMethod: json['payment_method'] ?? 'bank_transfer',
      transactionImageUrl: json['transaction_image_url'],
      userNotes: json['user_notes'],
      adminNotes: json['admin_notes'],
      reviewedBy: json['reviewed_by'],
      reviewedAt: json['reviewed_at'] != null 
          ? DateTime.parse(json['reviewed_at']) 
          : null,
      paidAt: json['paid_at'] != null 
          ? DateTime.parse(json['paid_at']) 
          : null,
      package: json['package'] != null 
          ? SubscriptionPackage.fromJson(json['package']) 
          : null,
      subscription: json['subscription'] != null 
          ? UserSubscription.fromJson(json['subscription']) 
          : null,
      reviewer: json['reviewer'] != null 
          ? User.fromJson(json['reviewer']) 
          : null,
      createdAt: DateTime.parse(json['created_at'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(json['updated_at'] ?? DateTime.now().toIso8601String()),
    );
  }

  static TransactionStatus _parseStatus(String? status) {
    switch (status) {
      case 'pending':
        return TransactionStatus.pending;
      case 'approved':
        return TransactionStatus.approved;
      case 'rejected':
        return TransactionStatus.rejected;
      case 'cancelled':
        return TransactionStatus.cancelled;
      default:
        return TransactionStatus.pending;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'subscription_id': subscriptionId,
      'package_id': packageId,
      'transaction_reference': transactionReference,
      'amount': amount,
      'currency': currency,
      'status': status.name,
      'payment_method': paymentMethod,
      'transaction_image_url': transactionImageUrl,
      'user_notes': userNotes,
      'admin_notes': adminNotes,
      'reviewed_by': reviewedBy,
      'reviewed_at': reviewedAt?.toIso8601String(),
      'paid_at': paidAt?.toIso8601String(),
      'package': package?.toJson(),
      'subscription': subscription?.toJson(),
      'reviewer': reviewer?.toJson(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  // Helper getters
  bool get isPending => status == TransactionStatus.pending;
  bool get isApproved => status == TransactionStatus.approved;
  bool get isRejected => status == TransactionStatus.rejected;
  bool get isCancelled => status == TransactionStatus.cancelled;

  String get statusLabel {
    switch (status) {
      case TransactionStatus.pending:
        return 'En attente';
      case TransactionStatus.approved:
        return 'Approuvé';
      case TransactionStatus.rejected:
        return 'Rejeté';
      case TransactionStatus.cancelled:
        return 'Annulé';
    }
  }

  String get statusColor {
    switch (status) {
      case TransactionStatus.pending:
        return 'warning';
      case TransactionStatus.approved:
        return 'success';
      case TransactionStatus.rejected:
        return 'danger';
      case TransactionStatus.cancelled:
        return 'secondary';
    }
  }

  String get formattedAmount => '${amount.toInt()} $currency';

  String get paymentMethodLabel {
    switch (paymentMethod) {
      case 'bank_transfer':
        return 'Virement bancaire';
      case 'mobile_money':
        return 'Mobile Money';
      default:
        return paymentMethod;
    }
  }
}
