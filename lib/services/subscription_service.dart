import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../models/subscription_package.dart';
import '../models/user_subscription.dart';
import '../models/payment_transaction.dart';
import 'api_service.dart';

class SubscriptionService {
  static String get baseUrl => ApiService.baseUrl;

  // Get authorization headers
  Future<Map<String, String>> _getHeaders() async {
    final token = await ApiService.getToken();
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  // Get all active subscription packages
  Future<List<SubscriptionPackage>> getPackages() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/subscription/packages'),
        headers: await _getHeaders(),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success']) {
          return (data['data'] as List)
              .map((json) => SubscriptionPackage.fromJson(json))
              .toList();
        }
      }
      throw Exception('Failed to load packages');
    } catch (e) {
      throw Exception('Error loading packages: $e');
    }
  }

  // Get user's subscription status
  Future<Map<String, dynamic>> getSubscriptionStatus() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/subscription/status'),
        headers: await _getHeaders(),
      );


    
      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        log('Subscription status response: $data');
        if (data['success']) {
          final result = data['data'];
          return {
            'hasSubscription': result['hasSubscription'] ?? false,
            'canPublish': result['canPublish'] ?? false,
            'isFreeTrial': result['isFreeTrial'] ?? false,
            'subscriptionStatus': result['subscriptionStatus'] ?? '',
            'subscription': result['subscription'] != null 
                ? UserSubscription.fromJson(result['subscription'])
                : null,
            'daysRemaining': result['daysRemaining'],
            'expiresAt': result['expiresAt'] != null 
                ? DateTime.parse(result['expiresAt'])
                : null,
          };
        }
      }
      throw Exception('Failed to load subscription status');
    } catch (e) {
      throw Exception('Error loading subscription status: $e');
    }
  }

  // Get payment information
  Future<Map<String, String>> getPaymentInfo() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/subscription/payment-info'),
        headers: await _getHeaders(),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success']) {
          final paymentInfo = data['data'];
          return {
            'phoneNumber': paymentInfo['phone_number'] ?? '',
            'bankName': paymentInfo['bank_name'] ?? '',
            'accountNumber': paymentInfo['account_number'] ?? '',
            'instructions': paymentInfo['instructions'] ?? '',
          };
        }
      }
      throw Exception('Failed to load payment info');
    } catch (e) {
      throw Exception('Error loading payment info: $e');
    }
  }

  // Create a payment transaction
  Future<PaymentTransaction> createPayment({
    required int packageId,
    required File transactionImage,
    required DateTime paidAt,
    String? userNotes,
  }) async {
    try {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/subscription/payment'),
      );

      // Add headers
      final headers = await _getHeaders();
      request.headers.addAll(headers);

      // Add fields
      request.fields['package_id'] = packageId.toString();
      request.fields['paid_at'] = paidAt.toIso8601String();
      if (userNotes != null) {
        request.fields['user_notes'] = userNotes;
      }

      // Add image file
      request.files.add(
        await http.MultipartFile.fromPath(
          'transaction_image',
          transactionImage.path,
        ),
      );

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 201) {
        final data = json.decode(response.body);
        if (data['success']) {
          return PaymentTransaction.fromJson(data['data']['transaction']);
        }
      }

      final errorData = json.decode(response.body);
      throw Exception(errorData['message'] ?? 'Failed to create payment');
    } catch (e) {
      throw Exception('Error creating payment: $e');
    }
  }

  // Get user's payment transactions
  Future<List<PaymentTransaction>> getTransactions({int page = 1}) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/subscription/transactions?page=$page'),
        headers: await _getHeaders(),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success']) {
          return (data['data']['data'] as List)
              .map((json) => PaymentTransaction.fromJson(json))
              .toList();
        }
      }
      throw Exception('Failed to load transactions');
    } catch (e) {
      throw Exception('Error loading transactions: $e');
    }
  }

  // Get a specific transaction
  Future<PaymentTransaction> getTransaction(int id) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/subscription/transactions/$id'),
        headers: await _getHeaders(),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success']) {
          return PaymentTransaction.fromJson(data['data']);
        }
      }
      throw Exception('Failed to load transaction');
    } catch (e) {
      throw Exception('Error loading transaction: $e');
    }
  }

  // Cancel a pending transaction
  Future<void> cancelTransaction(int id) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/subscription/transactions/$id/cancel'),
        headers: await _getHeaders(),
      );

      if (response.statusCode != 200) {
        final errorData = json.decode(response.body);
        throw Exception(errorData['message'] ?? 'Failed to cancel transaction');
      }
    } catch (e) {
      throw Exception('Error cancelling transaction: $e');
    }
  }

  // Get subscription settings
  Future<Map<String, dynamic>> getSettings() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/subscription/settings'),
        headers: await _getHeaders(),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success']) {
          return data['data'];
        }
      }
      throw Exception('Failed to load settings');
    } catch (e) {
      throw Exception('Error loading settings: $e');
    }
  }
}
