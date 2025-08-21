import 'package:flutter/material.dart';
import '../data/static_data.dart';
import '../models/mauritanian_app.dart';
import '../utils/constants.dart';
import '../widgets/app_card.dart';
import 'app_detail_screen.dart';

/// Screen for searching applications
class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<MauritanianApp> _searchResults = [];
  bool _isSearching = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _performSearch(String query) {
    setState(() {
      _isSearching = true;
    });

    // Simulate search delay
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) {
        setState(() {
          if (query.isEmpty) {
            _searchResults = [];
          } else {
            _searchResults = StaticData.searchApps(query);
          }
          _isSearching = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: 'Rechercher des applications...',
            border: InputBorder.none,
            hintStyle: TextStyle(color: AppConstants.whiteTextColor),
          ),
          style: const TextStyle(color: AppConstants.whiteTextColor),
          onChanged: _performSearch,
        ),
        actions: [
          if (_searchController.text.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                _searchController.clear();
                _performSearch('');
              },
            ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isSearching) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (_searchController.text.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search,
              size: 64,
              color: AppConstants.secondaryTextColor,
            ),
            SizedBox(height: AppConstants.paddingM),
            Text(
              'Recherchez des applications mauritaniennes',
              style: TextStyle(
                fontSize: 18,
                color: AppConstants.secondaryTextColor,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: AppConstants.paddingS),
            Text(
              'Tapez le nom d\'une application, développeur ou catégorie',
              style: TextStyle(
                fontSize: 14,
                color: AppConstants.hintTextColor,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    if (_searchResults.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.search_off,
              size: 64,
              color: AppConstants.secondaryTextColor,
            ),
            const SizedBox(height: AppConstants.paddingM),
            const Text(
              AppConstants.noResults,
              style: TextStyle(
                fontSize: 18,
                color: AppConstants.secondaryTextColor,
              ),
            ),
            const SizedBox(height: AppConstants.paddingS),
            Text(
              'Aucune application trouvée pour "${_searchController.text}"',
              style: const TextStyle(
                fontSize: 14,
                color: AppConstants.hintTextColor,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppConstants.paddingM),
            const Text(
              AppConstants.tryDifferentSearch,
              style: TextStyle(
                fontSize: 14,
                color: AppConstants.hintTextColor,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(AppConstants.paddingM),
      itemCount: _searchResults.length,
      itemBuilder: (context, index) {
        final app = _searchResults[index];
        return Container(
          margin: const EdgeInsets.only(bottom: AppConstants.paddingM),
          height: 120,
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
