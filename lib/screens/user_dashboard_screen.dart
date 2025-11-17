import 'package:flutter/material.dart';
import '../models/mauritanian_app.dart';
import '../models/user.dart';
import '../services/auth_service.dart';
import '../services/app_service.dart';
import '../utils/constants.dart';
import '../widgets/app_card.dart';
import '../widgets/subscription_status_widget.dart';
import '../widgets/language_switcher.dart';
import '../l10n/app_localizations.dart';
import 'app_detail_screen.dart';
import 'auth/login_screen.dart';
import 'publish_app_screen.dart';
import 'payment_history_screen.dart';
import 'subscription_packages_screen.dart';
import 'category_test_screen.dart';

class UserDashboardScreen extends StatefulWidget {
  const UserDashboardScreen({super.key});

  @override
  State<UserDashboardScreen> createState() => _UserDashboardScreenState();
}

class _UserDashboardScreenState extends State<UserDashboardScreen> {
  late Future<List<MauritanianApp>> _userAppsFuture;
  User? _currentUser;

  @override
  void initState() {
    super.initState();
    _currentUser = AuthService.staticCurrentUser;
    if (_currentUser != null) {
      _userAppsFuture = AppService.getUserApps();
    }

    // Listen to auth state changes
    AuthService.instance.addListener(_onAuthStateChanged);
  }

  @override
  void dispose() {
    AuthService.instance.removeListener(_onAuthStateChanged);
    super.dispose();
  }

  void _onAuthStateChanged() {
    setState(() {
      _currentUser = AuthService.instance.currentUser;
      if (_currentUser != null) {
        _userAppsFuture = AppService.getUserApps();
      }
    });
  }

  void _refreshUserApps() {
    if (_currentUser != null) {
      setState(() {
        _userAppsFuture = AppService.getUserApps();
      });
    }
  }

  Future<void> _logout() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) {
        final l10n = AppLocalizations.of(context)!;
        return AlertDialog(
          title: Text(l10n.logout),
          content: Text(l10n.logoutConfirmation),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(l10n.cancel),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(l10n.logout),
            ),
          ],
        );
      },
    );

    if (confirmed == true) {
      await AuthService.logout();
      if (mounted) {
        setState(() {
          _currentUser = null;
        });
      }
    }
  }

  Future<void> _showLoginScreen() async {
    final result = await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );

    if (result == true) {
      setState(() {
        _currentUser = AuthService.instance.currentUser;
        if (_currentUser != null) {
          _userAppsFuture = AppService.getUserApps();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    if (_currentUser == null) {
      return _buildNotLoggedInView(theme);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.myDashboard),
        backgroundColor: AppConstants.primaryGold,
        foregroundColor: AppConstants.whiteTextColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _refreshUserApps,
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'logout') {
                _logout();
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'logout',
                child: Row(
                  children: [
                    const Icon(Icons.logout),
                    const SizedBox(width: 8),
                    Text(l10n.logout),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
          Container(
            width: double.infinity,
            margin: const EdgeInsets.all(AppConstants.paddingM),
            padding: const EdgeInsets.all(AppConstants.paddingL),
            decoration: BoxDecoration(
              color: AppConstants.primaryGold.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppConstants.borderRadiusM),
              border: Border.all(color: AppConstants.primaryGold.withValues(alpha: 0.2)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: AppConstants.primaryGold,
                      child: Text(
                        _currentUser!.name.isNotEmpty ? _currentUser!.name[0].toUpperCase() : 'U',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: AppConstants.paddingM),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _currentUser!.name,
                            style: theme.textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            _currentUser!.email,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: AppConstants.secondaryTextColor,
                            ),
                          ),
                          if (_currentUser!.isVerified)
                            Row(
                              children: [
                                Icon(
                                  Icons.verified,
                                  size: 16,
                                  color: AppConstants.successGreen,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  l10n.verifiedAccount,
                                  style: const TextStyle(
                                    color: AppConstants.successGreen,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Subscription Status
          Container(
            margin: const EdgeInsets.symmetric(horizontal: AppConstants.paddingM),
            child: SubscriptionStatusWidget(
              onNavigateToPackages: () {
                debugPrint('UserDashboardScreen: Navigating to subscription packages');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SubscriptionPackagesScreen(),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: AppConstants.paddingM),

          // Language Settings
          Container(
            margin: const EdgeInsets.symmetric(horizontal: AppConstants.paddingM),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(AppConstants.paddingM),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.language, color: AppConstants.primaryBlue),
                        const SizedBox(width: AppConstants.paddingS),
                        Text(
                          AppLocalizations.of(context)!.language,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppConstants.paddingM),
                    const LanguageSwitcher(showTitle: false, isCompact: false),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: AppConstants.paddingM),

          // Quick Actions
          Container(
            margin: const EdgeInsets.symmetric(horizontal: AppConstants.paddingM),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const PublishAppScreen()),
                      );
                      if (result == true) {
                        _refreshUserApps();
                      }
                    },
                    icon: const Icon(Icons.add),
                    label: Text(l10n.publishApp),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppConstants.mauritanianGreen,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: AppConstants.paddingM),
                    ),
                  ),
                ),
                const SizedBox(width: AppConstants.paddingM),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const PaymentHistoryScreen()),
                      );
                    },
                    icon: const Icon(Icons.receipt_long),
                    label: Text(l10n.payments),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppConstants.primaryGold,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: AppConstants.paddingM),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: AppConstants.paddingM),

          // User Apps Section
          FutureBuilder<List<MauritanianApp>>(
              future: _userAppsFuture,
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
                        const SizedBox(height: AppConstants.paddingM),
                        Text(
                          l10n.errorLoadingYourApps,
                          style: const TextStyle(
                            fontSize: 16,
                            color: AppConstants.secondaryTextColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: AppConstants.paddingM),
                        ElevatedButton(
                          onPressed: _refreshUserApps,
                          child: Text(l10n.retry),
                        ),
                      ],
                    ),
                  );
                }

                final userApps = snapshot.data ?? [];

                if (userApps.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.apps,
                          size: 64,
                          color: AppConstants.secondaryTextColor,
                        ),
                        const SizedBox(height: AppConstants.paddingM),
                        Text(
                          l10n.noAppsPublished,
                          style: const TextStyle(
                            fontSize: 18,
                            color: AppConstants.secondaryTextColor,
                          ),
                        ),
                        const SizedBox(height: AppConstants.paddingS),
                        Text(
                          l10n.startByPublishingFirstApp,
                          style: const TextStyle(
                            color: AppConstants.secondaryTextColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: AppConstants.paddingL),
                        ElevatedButton.icon(
                          onPressed: () async {
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const PublishAppScreen()),
                            );
                            if (result == true) {
                              _refreshUserApps();
                            }
                          },
                          icon: const Icon(Icons.add),
                          label: Text(l10n.publishApp),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppConstants.teal,
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: AppConstants.paddingM),
                      child: Text(
                        l10n.myApps(userApps.length),
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: AppConstants.paddingM),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: AppConstants.paddingM),
                      itemCount: userApps.length,
                      itemBuilder: (context, index) {
                        final app = userApps[index];
                        return Container(
                          margin: const EdgeInsets.only(bottom: AppConstants.paddingM),
                          child: AppCard(
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
                          ),
                        );
                      },
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotLoggedInView(ThemeData theme) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.myAccount),
        backgroundColor: AppConstants.primaryBlue,
        foregroundColor: AppConstants.whiteTextColor,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.paddingL),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.person_outline,
                size: 80,
                color: AppConstants.secondaryTextColor,
              ),
              const SizedBox(height: AppConstants.paddingL),
              Text(
                l10n.loginToAccessDashboard,
                style: theme.textTheme.headlineSmall?.copyWith(
                  color: AppConstants.primaryTextColor,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppConstants.paddingM),
              Text(
                l10n.managePublishedApps,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: AppConstants.secondaryTextColor,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppConstants.paddingXL),
              ElevatedButton(
                onPressed: _showLoginScreen,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppConstants.primaryBlue,
                  foregroundColor: AppConstants.whiteTextColor,
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppConstants.paddingXL,
                    vertical: AppConstants.paddingM,
                  ),
                ),
                child: Text(
                  l10n.loginButton,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
