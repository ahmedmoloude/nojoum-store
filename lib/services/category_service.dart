import '../models/app_category.dart';
import 'api_service.dart';

class CategoryService {
  // Get all categories
  static Future<List<AppCategory>> getCategories() async {
    final response = await ApiService.get('/categories');
    final List<dynamic> categoriesData = response['data'] ?? [];

    print('Categories data: $categoriesData');
    return categoriesData.map((json) => AppCategory.fromApiJson(json)).toList();
  }
  
  // Get single category by ID
  static Future<AppCategory> getCategory(int id) async {
    final response = await ApiService.get('/categories/$id');
    return AppCategory.fromApiJson(response['data']);
  }
  
  // Get apps by category
  static Future<List<dynamic>> getAppsByCategory(int categoryId, {
    int page = 1,
    int perPage = 20,
  }) async {
    final response = await ApiService.get('/categories/$categoryId/apps?page=$page&per_page=$perPage');
    return response['data'] ?? [];
  }
}
