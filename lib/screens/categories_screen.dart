import 'package:flutter/material.dart';
import '../data/app_repository.dart';
import '../models/app_category.dart';
import '../utils/constants.dart';
import '../widgets/category_chip.dart';
import 'catalog_screen.dart';

/// Screen displaying all application categories
class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  late Future<List<AppCategory>> _categoriesFuture;

  @override
  void initState() {
    super.initState();
    _categoriesFuture = AppRepository.getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConstants.categories),
      ),
      body: FutureBuilder<List<AppCategory>>(
        future: _categoriesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 64,
                    color: AppConstants.secondaryTextColor,
                  ),
                  SizedBox(height: AppConstants.paddingM),
                  Text(
                    'Erreur lors du chargement des catégories',
                    style: TextStyle(
                      fontSize: 18,
                      color: AppConstants.secondaryTextColor,
                    ),
                  ),
                  SizedBox(height: AppConstants.paddingM),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _categoriesFuture = AppRepository.getCategories();
                      });
                    },
                    child: Text('Réessayer'),
                  ),
                ],
              ),
            );
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.category,
                    size: 64,
                    color: AppConstants.secondaryTextColor,
                  ),
                  SizedBox(height: AppConstants.paddingM),
                  Text(
                    'Aucune catégorie disponible',
                    style: TextStyle(
                      fontSize: 18,
                      color: AppConstants.secondaryTextColor,
                    ),
                  ),
                ],
              ),
            );
          }

          final categories = snapshot.data!;
          return GridView.builder(
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

              return CategoryChip(
                category: category,
                showCount: true,
                appCount: 0, // App count will be handled by the API response
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
          );
        },
      ),
    );
  }
}
