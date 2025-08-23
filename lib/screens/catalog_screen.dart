import 'package:flutter/material.dart';
import '../data/static_data.dart';
import '../models/mauritanian_app.dart';
import '../utils/constants.dart';
import '../widgets/app_card.dart';
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
  List<MauritanianApp> _apps = [];
  List<MauritanianApp> _filteredApps = [];
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
        _apps = StaticData.featuredApps;
      } else if (widget.initialCategory != null) {
        _apps = StaticData.getAppsByCategory(widget.initialCategory!);
      } else {
        _apps = StaticData.apps;
      }
      _filteredApps = List.from(_apps);
      _sortApps();
    });
  }

  void _sortApps() {
    setState(() {
      switch (_sortBy) {
        case 'name_asc':
          _filteredApps.sort((a, b) => a.name.compareTo(b.name));
          break;
        case 'name_desc':
          _filteredApps.sort((a, b) => b.name.compareTo(a.name));
          break;
        case 'rating_desc':
          _filteredApps.sort((a, b) => b.rating.compareTo(a.rating));
          break;
        case 'downloads_desc':
          _filteredApps.sort((a, b) => b.downloadCount.compareTo(a.downloadCount));
          break;
        case 'date_desc':
          _filteredApps.sort((a, b) => b.dateAdded.compareTo(a.dateAdded));
          break;
        case 'date_asc':
          _filteredApps.sort((a, b) => a.dateAdded.compareTo(b.dateAdded));
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_getScreenTitle()),
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
                _sortApps();
              });
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'name_asc',
                child: Text('Nom (A-Z)'),
              ),
              const PopupMenuItem(
                value: 'name_desc',
                child: Text('Nom (Z-A)'),
              ),
              const PopupMenuItem(
                value: 'rating_desc',
                child: Text('Mieux noté'),
              ),
              const PopupMenuItem(
                value: 'downloads_desc',
                child: Text('Plus téléchargé'),
              ),
              const PopupMenuItem(
                value: 'date_desc',
                child: Text('Plus récent'),
              ),
              const PopupMenuItem(
                value: 'date_asc',
                child: Text('Plus ancien'),
              ),
            ],
          ),
        ],
      ),
      body: _filteredApps.isEmpty
          ? const Center(
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
                    AppConstants.noResults,
                    style: TextStyle(
                      fontSize: 18,
                      color: AppConstants.secondaryTextColor,
                    ),
                  ),
                ],
              ),
            )
          : _isGridView
              ? _buildGridView()
              : _buildListView(),
    );
  }

  String _getScreenTitle() {
    if (widget.initialFilter == 'featured') {
      return AppConstants.featuredApps;
    } else if (widget.initialCategory != null) {
      return 'Catégorie: ${widget.initialCategory}';
    } else {
      return AppConstants.allApps;
    }
  }

  Widget _buildGridView() {
    return GridView.builder(
      padding: const EdgeInsets.all(AppConstants.paddingM),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Better for mobile screens
        childAspectRatio: 0.75, // Adjusted aspect ratio to give more height
        crossAxisSpacing: AppConstants.paddingM,
        mainAxisSpacing: AppConstants.paddingM,
      ),
      itemCount: _filteredApps.length,
      itemBuilder: (context, index) {
        final app = _filteredApps[index];
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

  Widget _buildListView() {
    return ListView.builder(
      padding: const EdgeInsets.all(AppConstants.paddingM),
      itemCount: _filteredApps.length,
      itemBuilder: (context, index) {
        final app = _filteredApps[index];
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