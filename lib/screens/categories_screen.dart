import 'package:flutter/material.dart';
import '../data/static_data.dart';
import '../models/app_category.dart';
import '../utils/constants.dart';
import '../widgets/category_chip.dart';
import 'catalog_screen.dart';

/// Screen displaying all application categories
class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = AppCategories.all;

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConstants.categories),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(AppConstants.paddingM),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.0,
          crossAxisSpacing: AppConstants.paddingM,
          mainAxisSpacing: AppConstants.paddingM,
        ),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final appCount = StaticData.getAppsByCategory(category.id).length;
          
          return CategoryChip(
            category: category,
            showCount: true,
            appCount: appCount,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CatalogScreen(
                    initialCategory: category.id,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
