import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../utils/constants.dart';
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

  List<BottomNavigationBarItem> get _navItems => [
    const BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Accueil',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.category),
      label: 'Catégories',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.search),
      label: 'Recherche',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: 'Mon Compte',
    ),
  ];

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
        selectedItemColor: AppConstants.primaryBlue,
        unselectedItemColor: AppConstants.secondaryTextColor,
        items: _navItems,
      ),
    );
  }
}
