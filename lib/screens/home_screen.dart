import 'package:flutter/material.dart';
import '../data/static_data.dart';
import '../models/app_category.dart';
import '../models/mauritanian_app.dart';
import '../utils/constants.dart';
import '../widgets/app_card.dart';
import '../widgets/category_chip.dart';
import 'app_detail_screen.dart';
import 'catalog_screen.dart';
import 'categories_screen.dart';
import 'search_screen.dart';

/// Home screen displaying welcome message, featured apps, and categories
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _featuredPageController = PageController();
  int _currentFeaturedIndex = 0;

  @override
  void dispose() {
    _featuredPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final featuredApps = StaticData.featuredApps;
    final categories = AppCategories.all.take(6).toList(); // Show first 6 categories

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // App Bar with gradient background
          SliverAppBar(
            expandedHeight: 200,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text(
                AppConstants.appName,
                style: TextStyle(
                  color: AppConstants.whiteTextColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              background: Container(
                decoration: const BoxDecoration(
                  gradient: AppConstants.primaryGradient,
                ),
                child: const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 40), // Account for status bar
                      Icon(
                        Icons.store,
                        size: AppConstants.iconSizeXL,
                        color: AppConstants.whiteTextColor,
                      ),
                      SizedBox(height: AppConstants.paddingS),
                      Text(
                        AppConstants.appTagline,
                        style: TextStyle(
                          color: AppConstants.whiteTextColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SearchScreen(),
                    ),
                  );
                },
              ),
            ],
          ),

          // Main content
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Welcome section
                Padding(
                  padding: const EdgeInsets.all(AppConstants.paddingM),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppConstants.welcomeTitle,
                        style: theme.textTheme.headlineMedium,
                      ),
                      const SizedBox(height: AppConstants.paddingS),
                      Text(
                        AppConstants.welcomeSubtitle,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: AppConstants.secondaryTextColor,
                        ),
                      ),
                    ],
                  ),
                ),

                // Quick actions
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppConstants.paddingM,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const CatalogScreen(),
                              ),
                            );
                          },
                          icon: const Icon(Icons.apps),
                          label: const Text(AppConstants.allApps),
                        ),
                      ),
                      const SizedBox(width: AppConstants.paddingM),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const CategoriesScreen(),
                              ),
                            );
                          },
                          icon: const Icon(Icons.category),
                          label: const Text(AppConstants.categories),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: AppConstants.paddingL),

                // Featured apps section
                if (featuredApps.isNotEmpty) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppConstants.paddingM,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppConstants.featuredApps,
                          style: theme.textTheme.headlineSmall,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const CatalogScreen(
                                  initialFilter: 'featured',
                                ),
                              ),
                            );
                          },
                          child: const Text('Voir tout'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppConstants.paddingM),
                  _buildFeaturedAppsCarousel(featuredApps),
                  const SizedBox(height: AppConstants.paddingL),
                ],

                // Categories section
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppConstants.paddingM,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppConstants.categories,
                        style: theme.textTheme.headlineSmall,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CategoriesScreen(),
                            ),
                          );
                        },
                        child: const Text('Voir tout'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppConstants.paddingM),
                _buildCategoriesGrid(categories),

                const SizedBox(height: AppConstants.paddingL),

                // Recent apps section
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppConstants.paddingM,
                  ),
                  child: Text(
                    'Récemment ajoutées',
                    style: theme.textTheme.headlineSmall,
                  ),
                ),
                const SizedBox(height: AppConstants.paddingM),
                _buildRecentApps(),

                const SizedBox(height: AppConstants.paddingXL),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedAppsCarousel(List<MauritanianApp> featuredApps) {
    return SizedBox(
      height: 280,
      child: PageView.builder(
        controller: _featuredPageController,
        onPageChanged: (index) {
          setState(() {
            _currentFeaturedIndex = index;
          });
        },
        itemCount: featuredApps.length,
        itemBuilder: (context, index) {
          final app = featuredApps[index];
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.paddingM,
            ),
            child: AppCard(
              app: app,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AppDetailScreen(app: app),
                  ),
                );
              },
              showFeaturedBadge: true,
            ),
          );
        },
      ),
    );
  }

  Widget _buildCategoriesGrid(List<AppCategory> categories) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppConstants.paddingM),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1.0,
          crossAxisSpacing: AppConstants.paddingM,
          mainAxisSpacing: AppConstants.paddingM,
        ),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return CategoryChip(
            category: category,
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

  Widget _buildRecentApps() {
    final recentApps = StaticData.recentApps.take(3).toList();
    
    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: AppConstants.paddingM),
        itemCount: recentApps.length,
        itemBuilder: (context, index) {
          final app = recentApps[index];
          return Container(
            width: 280,
            margin: const EdgeInsets.only(right: AppConstants.paddingM),
            child: AppCard(
              app: app,
              isCompact: true,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AppDetailScreen(app: app),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
