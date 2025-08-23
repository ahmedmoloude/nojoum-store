import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../data/static_data.dart';
import '../models/app_category.dart';
import '../models/mauritanian_app.dart';
import '../utils/constants.dart';
import '../widgets/app_card.dart';
import '../widgets/category_chip.dart';
import '../widgets/ad_banner_widget.dart';
import 'app_detail_screen.dart';
import 'catalog_screen.dart';
import 'categories_screen.dart';
import 'search_screen.dart';
import 'publish_app_screen.dart';

/// New Marketplace Home Screen with dual-mode functionality
class MarketplaceHomeScreen extends StatefulWidget {
  const MarketplaceHomeScreen({super.key});

  @override
  State<MarketplaceHomeScreen> createState() => _MarketplaceHomeScreenState();
}

class _MarketplaceHomeScreenState extends State<MarketplaceHomeScreen> {
  bool _isBrowseMode = true; // true = Browse Apps, false = Publish Mode
  int _currentCarouselIndex = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final featuredApps = StaticData.featuredApps;
    final categories = AppCategories.all.take(6).toList();
    final stats = _getMarketplaceStats();

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Modern App Bar with dual-mode toggle
          SliverAppBar(
            expandedHeight: 180,
            floating: false,
            pinned: true,
            backgroundColor: AppConstants.primaryBlue,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                AppConstants.appName,
                style: TextStyle(
                  color: AppConstants.whiteTextColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [AppConstants.primaryBlue, AppConstants.royalBlue],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 40),
                    Icon(
                      Icons.storefront,
                      size: AppConstants.iconSizeXL,
                      color: AppConstants.whiteTextColor,
                    ),
                    SizedBox(height: AppConstants.paddingS),
                    Text(
                      AppConstants.appTagline,
                      style: TextStyle(
                        color: AppConstants.whiteTextColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SearchScreen()),
                ),
              ),
              IconButton(
                icon: Icon(Icons.person_outline),
                onPressed: () {
                  // TODO: Navigate to user profile/dashboard
                },
              ),
            ],
          ),

          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Mode Toggle Section
                _buildModeToggle(theme),
                
                // Hero Banner with CTA
                _buildHeroBanner(theme),
                
                // Ad Carousel Placeholder
                _buildAdCarousel(),
                
                // Quick Stats
                _buildQuickStats(stats, theme),
                
                // Featured Apps Section
                if (featuredApps.isNotEmpty) ...[
                  _buildSectionHeader('Applications en vedette', 'Voir tout', theme, () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CatalogScreen(initialFilter: 'featured'),
                      ),
                    );
                  }),
                  _buildFeaturedAppsCarousel(featuredApps),
                ],
                
                // Categories Quick Access
                _buildSectionHeader('Catégories populaires', 'Voir tout', theme, () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CategoriesScreen()),
                  );
                }),
                _buildCategoriesGrid(categories),
                
                // Sponsored Apps Carousel Placeholder
                _buildSponsoredSection(theme),
                
                // Success Stories Section
                // _buildSuccessStories(theme),r
                
                // Newsletter Signup
                // _buildNewsletterSignup(theme),
                
                SizedBox(height: AppConstants.paddingXL),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModeToggle(ThemeData theme) {
    return Container(
      margin: EdgeInsets.all(AppConstants.paddingM),
      decoration: BoxDecoration(
        color: AppConstants.surfaceColor,
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _isBrowseMode = true),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: AppConstants.paddingM),
                decoration: BoxDecoration(
                  color: _isBrowseMode ? AppConstants.primaryBlue : Colors.transparent,
                  borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.apps,
                      color: _isBrowseMode ? AppConstants.whiteTextColor : AppConstants.primaryBlue,
                      size: AppConstants.iconSizeL,
                    ),
                    SizedBox(height: AppConstants.paddingS),
                    Text(
                      'Parcourir les Apps',
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: _isBrowseMode ? AppConstants.whiteTextColor : AppConstants.primaryBlue,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _isBrowseMode = false),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: AppConstants.paddingM),
                decoration: BoxDecoration(
                  color: !_isBrowseMode ? AppConstants.teal : Colors.transparent,
                  borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.publish,
                      color: !_isBrowseMode ? AppConstants.whiteTextColor : AppConstants.teal,
                      size: AppConstants.iconSizeL,
                    ),
                    SizedBox(height: AppConstants.paddingS),
                    Text(
                      'Publier mon App',
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: !_isBrowseMode ? AppConstants.whiteTextColor : AppConstants.teal,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroBanner(ThemeData theme) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: AppConstants.paddingM),
      padding: EdgeInsets.all(AppConstants.paddingL),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppConstants.teal, AppConstants.cyan],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _isBrowseMode 
              ? 'Découvrez les meilleures solutions digitales mauritaniennes'
              : 'Partagez votre innovation avec la Mauritanie',
            style: theme.textTheme.headlineSmall?.copyWith(
              color: AppConstants.whiteTextColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: AppConstants.paddingM),
          Text(
            _isBrowseMode
              ? 'Trouvez des applications et logiciels créés par des développeurs locaux pour répondre à vos besoins.'
              : 'Rejoignez notre marketplace et connectez-vous avec des clients potentiels à travers le pays.',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: AppConstants.whiteTextColor.withOpacity(0.9),
            ),
          ),
          SizedBox(height: AppConstants.paddingL),
          ElevatedButton(
            onPressed: () {
              if (_isBrowseMode) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CatalogScreen()),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PublishAppScreen()),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppConstants.whiteTextColor,
              foregroundColor: AppConstants.teal,
              padding: EdgeInsets.symmetric(
                horizontal: AppConstants.paddingL,
                vertical: AppConstants.paddingM,
              ),
            ),
            child: Text(
              _isBrowseMode ? 'Explorer maintenant' : 'Commencer à publier',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAdCarousel() {
    return Container(
      margin: EdgeInsets.all(AppConstants.paddingM),
      height: 120,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusM),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.ads_click, size: 32, color: Colors.grey[400]),
            SizedBox(height: 8),
            Text(
              'Espace publicitaire',
              style: TextStyle(color: Colors.grey[600], fontSize: 14),
            ),
            Text(
              'Bannières rotatives',
              style: TextStyle(color: Colors.grey[500], fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickStats(Map<String, String> stats, ThemeData theme) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: AppConstants.paddingM),
      child: Row(
        children: stats.entries.map((entry) {
          return Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: AppConstants.paddingS),
              padding: EdgeInsets.all(AppConstants.paddingM),
              decoration: BoxDecoration(
                color: AppConstants.surfaceColor,
                borderRadius: BorderRadius.circular(AppConstants.borderRadiusM),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    entry.value,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      color: AppConstants.primaryBlue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: AppConstants.paddingXS),
                  Text(
                    entry.key,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: AppConstants.secondaryTextColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildSectionHeader(String title, String actionText, ThemeData theme, VoidCallback onTap) {
    return Padding(
      padding: EdgeInsets.fromLTRB(AppConstants.paddingM, AppConstants.paddingL, AppConstants.paddingM, AppConstants.paddingM),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: theme.textTheme.headlineSmall),
          TextButton(
            onPressed: onTap,
            child: Text(actionText),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedAppsCarousel(List<MauritanianApp> featuredApps) {
    return CarouselSlider.builder(
      itemCount: featuredApps.length,
      itemBuilder: (context, index, realIndex) {
        final app = featuredApps[index];
        return Container(
          margin: EdgeInsets.symmetric(horizontal: AppConstants.paddingS),
          child: AppCard(
            app: app,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AppDetailScreen(app: app)),
            ),
            showFeaturedBadge: true,
          ),
        );
      },
      options: CarouselOptions(
        height: 280,
        autoPlay: true,
        enlargeCenterPage: true,
        onPageChanged: (index, reason) {
          setState(() => _currentCarouselIndex = index);
        },
      ),
    );
  }

  Widget _buildCategoriesGrid(List<AppCategory> categories) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: AppConstants.paddingM),
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CatalogScreen(initialCategory: category.id),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSponsoredSection(ThemeData theme) {
    return Column(
      children: [
        _buildSectionHeader('Applications sponsorisées', 'Voir tout', theme, () {}),
        Container(
          margin: EdgeInsets.symmetric(horizontal: AppConstants.paddingM),
          height: 100,
          decoration: BoxDecoration(
            color: Colors.orange[50],
            borderRadius: BorderRadius.circular(AppConstants.borderRadiusM),
            border: Border.all(color: Colors.orange[200]!),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.star, size: 32, color: Colors.orange[400]),
                SizedBox(height: 8),
                Text(
              'Applications sponsorisées',
                  style: TextStyle(color: Colors.orange[700], fontSize: 14),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSuccessStories(ThemeData theme) {
    final stories = [
      {
        'title': 'Hôpital local adopte MauriHealth',
        'description': 'Amélioration de 40% des soins patients',
        'icon': Icons.local_hospital,
      },
      {
        'title': 'PME augmente ses ventes de 60%',
        'description': 'Grâce à Sahara Inventory',
        'icon': Icons.trending_up,
      },
    ];

    return Column(
      children: [
        _buildSectionHeader('Histoires de succès', '', theme, () {}),
        Container(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: AppConstants.paddingM),
            itemCount: stories.length,
            itemBuilder: (context, index) {
              final story = stories[index];
              return Container(
                width: 280,
                margin: EdgeInsets.only(right: AppConstants.paddingM),
                padding: EdgeInsets.all(AppConstants.paddingM),
                decoration: BoxDecoration(
                  color: AppConstants.surfaceColor,
                  borderRadius: BorderRadius.circular(AppConstants.borderRadiusM),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(AppConstants.paddingM),
                      decoration: BoxDecoration(
                        color: AppConstants.successGreen.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(AppConstants.borderRadiusM),
                      ),
                      child: Icon(
                        story['icon'] as IconData,
                        color: AppConstants.successGreen,
                        size: AppConstants.iconSizeL,
                      ),
                    ),
                    SizedBox(width: AppConstants.paddingM),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            story['title'] as String,
                            style: theme.textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: AppConstants.paddingXS),
                          Text(
                            story['description'] as String,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: AppConstants.secondaryTextColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildNewsletterSignup(ThemeData theme) {
    return Container(
      margin: EdgeInsets.all(AppConstants.paddingM),
      padding: EdgeInsets.all(AppConstants.paddingL),
      decoration: BoxDecoration(
        color: AppConstants.primaryBlue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
        border: Border.all(color: AppConstants.primaryBlue.withOpacity(0.2)),
      ),
      child: Column(
        children: [
          Icon(
            Icons.email_outlined,
            size: AppConstants.iconSizeL,
            color: AppConstants.primaryBlue,
          ),
          SizedBox(height: AppConstants.paddingM),
          Text(
            'Restez informé',
            style: theme.textTheme.headlineSmall?.copyWith(
              color: AppConstants.primaryBlue,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: AppConstants.paddingS),
          Text(
            'Recevez les dernières nouveautés du marketplace mauritanien',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: AppConstants.secondaryTextColor,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: AppConstants.paddingL),
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Votre email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppConstants.borderRadiusM),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: AppConstants.paddingM,
                      vertical: AppConstants.paddingM,
                    ),
                  ),
                ),
              ),
              SizedBox(width: AppConstants.paddingM),
              ElevatedButton(
                onPressed: () {
                  // TODO: Implement newsletter signup
                },
                child: Text('S\'inscrire'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Map<String, String> _getMarketplaceStats() {
    return {
      'Apps disponibles': '${StaticData.apps.length}+',
      'Développeurs actifs': '50+',
      'Clients satisfaits': '1000+',
    };
  }
}