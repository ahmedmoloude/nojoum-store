import 'dart:developer';

import '../models/mauritanian_app.dart';
import 'api_service.dart';

class AppService {
  // Get all apps with optional filters
  static Future<List<MauritanianApp>> getApps({
    String? category,
    String? search,
    String? sort,
    bool? featured,
    bool? approved,
    int page = 1,
    int perPage = 20,
  }) async {
    try {
      final queryParams = <String, String>{
        'page': page.toString(),
        'per_page': perPage.toString(),
      };

      if (category != null) queryParams['category'] = category;
      if (search != null) queryParams['search'] = search;
      if (sort != null) queryParams['sort'] = sort;
      if (featured != null) queryParams['featured'] = featured.toString();
      if (approved != null) queryParams['approved'] = approved.toString();

      final queryString = queryParams.entries
          .map((e) => '${e.key}=${Uri.encodeComponent(e.value)}')
          .join('&');

      log('Fetching apps with query: /apps?$queryString');
      final response = await ApiService.get('/apps?$queryString');

      log('Apps response received: ${response.toString().substring(0, 200)}...');

      // Handle paginated response structure
      final responseData = response['data'];
      final List<dynamic> appsData = responseData is Map ? (responseData['data'] ?? []) : (responseData ?? []);

      log('Found ${appsData.length} apps in response');

      final apps = appsData.map((json) {
        try {
          return MauritanianApp.fromApiJson(json);
        } catch (e) {
          log('Error parsing app JSON: $e');
          log('Problematic JSON: ${json.toString()}');
          rethrow;
        }
      }).toList();

      log('Successfully parsed ${apps.length} apps');
      return apps;
    } catch (e) {
      log('Error in getApps: $e');
      rethrow;
    }
  }
  
  // Get single app by ID
  static Future<MauritanianApp> getApp(int id) async {
    final response = await ApiService.get('/apps/$id');
    return MauritanianApp.fromApiJson(response['data']);
  }
  
  // Get featured apps
  static Future<List<MauritanianApp>> getFeaturedApps() async {
    try {
      log('Fetching featured apps from: /apps/featured/list');
      final response = await ApiService.get('/apps/featured/list');

      log('Featured apps response: ${response.toString().substring(0, 200)}...');
      final List<dynamic> appsData = response['data'] ?? [];

      log('Found ${appsData.length} featured apps');

      final apps = appsData.map((json) {
        try {
          return MauritanianApp.fromApiJson(json);
        } catch (e) {
          log('Error parsing featured app JSON: $e');
          log('Problematic JSON: ${json.toString()}');
          rethrow;
        }
      }).toList();

      log('Successfully parsed ${apps.length} featured apps');
      return apps;
    } catch (e) {
      log('Error in getFeaturedApps: $e');
      rethrow;
    }
  }
  
  // Get top rated apps
  static Future<List<MauritanianApp>> getTopRatedApps() async {
    final response = await ApiService.get('/apps/top-rated/list');
    final List<dynamic> appsData = response['data'] ?? [];
    return appsData.map((json) => MauritanianApp.fromApiJson(json)).toList();
  }

  // Get most downloaded apps
  static Future<List<MauritanianApp>> getMostDownloadedApps() async {
    final response = await ApiService.get('/apps/most-downloaded/list');
    final List<dynamic> appsData = response['data'] ?? [];
    return appsData.map((json) => MauritanianApp.fromApiJson(json)).toList();
  }
  
  // Create new app (for authenticated users)
  static Future<MauritanianApp> createApp(Map<String, dynamic> appData) async {
    final response = await ApiService.post('/apps', appData);

    log('Create app response: ${response.toString()}');
    return MauritanianApp.fromApiJson(response['data']);
  }
  
  // Update app (for app owners)
  static Future<MauritanianApp> updateApp(int id, Map<String, dynamic> appData) async {
    final response = await ApiService.put('/apps/$id', appData);
    return MauritanianApp.fromApiJson(response['data']);
  }
  
  // Delete app (for app owners)
  static Future<void> deleteApp(int id) async {
    await ApiService.delete('/apps/$id');
  }
  
  // Get user's apps
  static Future<List<MauritanianApp>> getUserApps() async {
    try {
      log('Fetching user apps');
      final response = await ApiService.get('/my-apps');

      log('User apps response: ${response.toString()}');

      // Handle paginated response structure (same as getApps method)
      final responseData = response['data'];
      final List<dynamic> appsData = responseData is Map ? (responseData['data'] ?? []) : (responseData ?? []);

      log('Found ${appsData.length} user apps');
      return appsData.map((json) => MauritanianApp.fromApiJson(json)).toList();
    } catch (e) {
      log('Error fetching user apps: $e');
      rethrow;
    }
  }

  // Get marketplace statistics
  static Future<Map<String, dynamic>> getStats() async {
    final response = await ApiService.get('/stats');
    return response['data'] ?? {};
  }

  // Test API connectivity
  static Future<bool> testConnection() async {
    try {
      log('Testing API connection...');
      final response = await ApiService.get('/test');
      log('Test response: $response');
      return response['success'] == true;
    } catch (e) {
      log('API connection test failed: $e');
      return false;
    }
  }
}
