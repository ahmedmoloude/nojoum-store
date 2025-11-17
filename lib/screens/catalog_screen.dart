import 'package:flutter/material.dart';
import '../data/app_repository.dart';
import '../models/mauritanian_app.dart';
import '../utils/constants.dart';
import '../widgets/app_card.dart';
import '../l10n/app_localizations.dart';
import 'app_detail_screen.dart';

/// Screen displaying all applications in a grid/list view
class CatalogScreen extends StatefulWidget {
  final String? initialCategory;
  final String? initialFilter;

  const CatalogScreen({
    super.key,
    this.initialCategory,
    this.initialFilter,
  });

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  late Future<List<MauritanianApp>> _appsFuture;
  bool _isGridView = true;
  String _sortBy = 'name_asc';

  @override
  void initState() {
    super.initState();
    _loadApps();
  }

  void _loadApps() {
    setState(() {
      if (widget.initialFilter == 'featured') {
        _appsFuture = AppRepository.getFeaturedApps();
      } else if (widget.initialCategory != null) {
        _appsFuture = AppRepository.getApps(category: widget.initialCategory);
      } else {
        _appsFuture = AppRepository.getApps();
      }
    });
  }

  List<MauritanianApp> _sortApps(List<MauritanianApp> apps) {
    final sortedApps = List<MauritanianApp>.from(apps);
    switch (_sortBy) {
      case 'name_asc':
        sortedApps.sort((a, b) => a.appName.compareTo(b.appName));
        break;
      case 'name_desc':
        sortedApps.sort((a, b) => b.appName.compareTo(a.appName));
        break;
      case 'rating_desc':
        sortedApps.sort((a, b) => b.rating.compareTo(a.rating));
        break;
      case 'date_desc':
        sortedApps.sort((a, b) => b.publishDate.compareTo(a.publishDate));
        break;
      case 'date_asc':
        sortedApps.sort((a, b) => a.publishDate.compareTo(b.publishDate));
        break;
    }
    return sortedApps;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_getScreenTitle(context)),
        actions: [
          IconButton(
            icon: Icon(_isGridView ? Icons.list : Icons.grid_view),
            onPressed: () {
              setState(() {
                _isGridView = !_isGridView;
              });
            },
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.sort),
            onSelected: (value) {
              setState(() {
                _sortBy = value;
                // Sorting will be handled in FutureBuilder
              });
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'name_asc',
                child: Text(AppLocalizations.of(context)!.sortNameAsc),
              ),
              PopupMenuItem(
                value: 'name_desc',
                child: Text(AppLocalizations.of(context)!.sortNameDesc),
              ),
              PopupMenuItem(
                value: 'rating_desc',
                child: Text(AppLocalizations.of(context)!.sortTopRated),
              ),
              PopupMenuItem(
                value: 'downloads_desc',
                child: Text(AppLocalizations.of(context)!.sortMostDownloaded),
              ),
              PopupMenuItem(
                value: 'date_desc',
                child: Text(AppLocalizations.of(context)!.sortNewest),
              ),
              PopupMenuItem(
                value: 'date_asc',
                child: Text(AppLocalizations.of(context)!.sortOldest),
              ),
            ],
          ),
        ],
      ),
      body: FutureBuilder<List<MauritanianApp>>(
        future: _appsFuture,
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
                    AppLocalizations.of(context)!.errorLoadingApps,
                    style: const TextStyle(
                      fontSize: 18,
                      color: AppConstants.secondaryTextColor,
                    ),
                  ),
                  SizedBox(height: AppConstants.paddingM),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _loadApps();
                      });
                    },
                    child: Text(AppLocalizations.of(context)!.retry),
                  ),
                ],
              ),
            );
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.apps,
                    size: 64,
                    color: AppConstants.secondaryTextColor,
                  ),
                  SizedBox(height: AppConstants.paddingM),
                  Text(
                    AppLocalizations.of(context)!.noResults,
                    style: const TextStyle(
                      fontSize: 18,
                      color: AppConstants.secondaryTextColor,
                    ),
                  ),
                ],
              ),
            );
          }

          final sortedApps = _sortApps(snapshot.data!);
          return _isGridView
              ? _buildGridView(sortedApps)
              : _buildListView(sortedApps);
        },
      ),
    );
  }

  String _getScreenTitle(BuildContext context) {
    if (widget.initialFilter == 'featured') {
      return AppLocalizations.of(context)!.featuredApps;
    } else if (widget.initialCategory != null) {
      return '${AppLocalizations.of(context)!.categoryLabel}: ${widget.initialCategory}';
    } else {
      return AppLocalizations.of(context)!.allApps;
    }
  }

  Widget _buildGridView(List<MauritanianApp> apps) {
    return GridView.builder(
      padding: const EdgeInsets.all(AppConstants.paddingM),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Better for mobile screens
        childAspectRatio: 0.75, // Adjusted aspect ratio to give more height
        crossAxisSpacing: AppConstants.paddingM,
        mainAxisSpacing: AppConstants.paddingM,
      ),
      itemCount: apps.length,
      itemBuilder: (context, index) {
        final app = apps[index];
        return AppCard(
          app: app,
          showFeaturedBadge: true,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AppDetailScreen(app: app),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildListView(List<MauritanianApp> apps) {
    return ListView.builder(
      padding: const EdgeInsets.all(AppConstants.paddingM),
      itemCount: apps.length,
      itemBuilder: (context, index) {
        final app = apps[index];
        return Container(
          margin: const EdgeInsets.only(bottom: AppConstants.paddingM),
          height: 100, // Reduced height to fit better
          child: AppCard(
            app: app,
            isCompact: true,
            showFeaturedBadge: true,
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
    );
  }
}