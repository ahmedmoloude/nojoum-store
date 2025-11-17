import 'package:flutter/material.dart';
import '../data/app_repository.dart';
import '../models/mauritanian_app.dart';
import '../utils/constants.dart';
import '../widgets/app_card.dart';
import 'app_detail_screen.dart';
import '../l10n/app_localizations.dart';

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

  void _performSearch(String query) async {
    setState(() {
      _isSearching = true;
    });

    try {
      if (query.isEmpty) {
        setState(() {
          _searchResults = [];
          _isSearching = false;
        });
        return;
      }

      // Add a small delay to avoid too many API calls while typing
      await Future.delayed(const Duration(milliseconds: 300));

      if (mounted) {
        final results = await AppRepository.getApps(search: query);
        if (mounted) {
          setState(() {
            _searchResults = results;
            _isSearching = false;
          });
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _searchResults = [];
          _isSearching = false;
        });
        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.errorSearching(e.toString())),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          autofocus: true,
          decoration: InputDecoration(
            hintText: AppLocalizations.of(context)!.searchMauritanianApps,
            border: InputBorder.none,
            hintStyle: const TextStyle(color: AppConstants.whiteTextColor),
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
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.search,
              size: 64,
              color: AppConstants.secondaryTextColor,
            ),
            const SizedBox(height: AppConstants.paddingM),
            Text(
              AppLocalizations.of(context)!.searchMauritanianApps,
              style: const TextStyle(
                fontSize: 18,
                color: AppConstants.secondaryTextColor,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppConstants.paddingS),
            Text(
              AppLocalizations.of(context)!.typeAppNameDeveloperCategory,
              style: const TextStyle(
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
            Text(
              AppLocalizations.of(context)!.noResults,
              style: const TextStyle(
                fontSize: 18,
                color: AppConstants.secondaryTextColor,
              ),
            ),
            const SizedBox(height: AppConstants.paddingS),
            Text(
              AppLocalizations.of(context)!.noResultsForQuery(_searchController.text),
              style: const TextStyle(
                fontSize: 14,
                color: AppConstants.hintTextColor,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppConstants.paddingM),
            Text(
              AppLocalizations.of(context)!.tryDifferentSearch,
              style: const TextStyle(
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
