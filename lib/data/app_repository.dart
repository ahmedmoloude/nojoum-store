import '../models/mauritanian_app.dart';
import '../models/app_category.dart';
import '../services/app_service.dart';
import '../services/category_service.dart';


class AppRepository {
  /// Get all apps
  static Future<List<MauritanianApp>> getApps({
    String? category,
    String? search,
    bool? featured,
    bool forceRefresh = false,
  }) async {
    // Fetch from API
    final apps = await AppService.getApps(
      category: category,
      search: search,
      featured: featured,
    );
    
    return apps;
  }
  
  /// Get single app by ID
  static Future<MauritanianApp?> getApp(String id) async {
    final app = await AppService.getApp(int.parse(id));
    return app;
  }
  
  /// Get featured apps
  static Future<List<MauritanianApp>> getFeaturedApps() async {
    return await AppService.getFeaturedApps();
  }
  
  /// Get top rated apps
  static Future<List<MauritanianApp>> getTopRatedApps() async {
    return await AppService.getTopRatedApps();
  }
  
  /// Get most downloaded apps
  static Future<List<MauritanianApp>> getMostDownloadedApps() async {
    return await AppService.getMostDownloadedApps();
  }
  
  /// Get all categories
  static Future<List<AppCategory>> getCategories({bool forceRefresh = false}) async {
    final categories = await CategoryService.getCategories();
    return categories;
  }
  
  /// Get category by ID
  static Future<AppCategory?> getCategory(String id) async {
    final category = await CategoryService.getCategory(int.parse(id));
    return category;
  }
}