import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../utils/constants.dart';
import '../l10n/app_localizations.dart';
import 'marketplace_home_screen.dart';
import 'user_dashboard_screen.dart';
import 'categories_screen.dart';
import 'search_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;
  
  @override
  void initState() {
    super.initState();
    // Initialize auth service
    AuthService.initialize();
  }

  List<Widget> get _screens => [
    const MarketplaceHomeScreen(),
    const CategoriesScreen(),
    const SearchScreen(),
    const UserDashboardScreen(),
  ];

  List<BottomNavigationBarItem> _getNavItems(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return [
      BottomNavigationBarItem(
        icon: const Icon(Icons.home),
        label: l10n.home,
      ),
      BottomNavigationBarItem(
        icon: const Icon(Icons.category),
        label: l10n.categories,
      ),
      BottomNavigationBarItem(
        icon: const Icon(Icons.search),
        label: l10n.search,
      ),
      BottomNavigationBarItem(
        icon: const Icon(Icons.person),
        label: l10n.profile,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppConstants.primaryGold,
        unselectedItemColor: AppConstants.secondaryTextColor,
        items: _getNavItems(context),
      ),
    );
  }
}
