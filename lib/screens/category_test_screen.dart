import 'package:flutter/material.dart';
import 'dart:developer';
import '../models/app_category.dart';
import '../services/category_service.dart';
import '../utils/constants.dart';

/// Test screen to verify category loading from API
class CategoryTestScreen extends StatefulWidget {
  const CategoryTestScreen({super.key});

  @override
  State<CategoryTestScreen> createState() => _CategoryTestScreenState();
}

class _CategoryTestScreenState extends State<CategoryTestScreen> {
  List<AppCategory> _categories = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    try {
      setState(() {
        _isLoading = true;
        _error = null;
      });

      log('Starting to load categories from API...');
      final categories = await CategoryService.getCategories();
      log('Successfully loaded ${categories.length} categories');
      
      for (var category in categories) {
        log('Category: ${category.id} - ${category.name}');
      }

      if (mounted) {
        setState(() {
          _categories = categories;
          _isLoading = false;
        });
      }
    } catch (e) {
      log('Error loading categories: $e');
      if (mounted) {
        setState(() {
          _error = e.toString();
          _isLoading = false;
          // Fallback to static categories
          _categories = AppCategories.all;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Categories'),
        backgroundColor: AppConstants.teal,
        foregroundColor: AppConstants.whiteTextColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadCategories,
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Loading categories...'),
          ],
        ),
      );
    }

    if (_error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.red,
            ),
            SizedBox(height: 16),
            Text(
              'Error loading categories:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                _error!,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.red),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loadCategories,
              child: Text('Retry'),
            ),
            SizedBox(height: 8),
            Text(
              'Using ${_categories.length} fallback categories',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          color: AppConstants.teal.withOpacity(0.1),
          child: Row(
            children: [
              Icon(Icons.check_circle, color: Colors.green),
              SizedBox(width: 8),
              Text(
                'Successfully loaded ${_categories.length} categories',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              SizedBox(width: 8),
              Text(
                'Total apps: ${_categories.fold(0, (sum, cat) => sum + cat.appCount)}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _categories.length,
            itemBuilder: (context, index) {
              final category = _categories[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: ListTile(
                  leading: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: category.color.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      category.icon,
                      color: category.color,
                    ),
                  ),
                  title: Text(
                    category.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('ID: ${category.id}'),
                      Text('Arabic: ${category.nameArabic}'),
                      Text('Description: ${category.description}'),
                      Text('App Count: ${category.appCount}',
                           style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
                      if (category.subcategories.isNotEmpty)
                        Text('Subcategories: ${category.subcategories.join(', ')}'),
                    ],
                  ),
                  isThreeLine: true,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
