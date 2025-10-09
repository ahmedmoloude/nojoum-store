import 'package:flutter/material.dart';
import '../models/user_subscription.dart';
import '../services/subscription_service.dart';
import '../utils/constants.dart';
import '../screens/subscription_packages_screen.dart';

class SubscriptionStatusWidget extends StatefulWidget {
  final VoidCallback? onNavigateToPackages;

  const SubscriptionStatusWidget({
    super.key,
    this.onNavigateToPackages,
  });

  @override
  State<SubscriptionStatusWidget> createState() => _SubscriptionStatusWidgetState();
}

class _SubscriptionStatusWidgetState extends State<SubscriptionStatusWidget> {
  final SubscriptionService _subscriptionService = SubscriptionService();
  Map<String, dynamic>? _subscriptionStatus;
  bool _isLoading = true;
  String? _error;
  bool _isNavigating = false;

  @override
  void initState() {
    super.initState();
    _loadSubscriptionStatus();
  }

  Future<void> _loadSubscriptionStatus() async {
    try {
      setState(() {
        _isLoading = true;
        _error = null;
      });

      final status = await _subscriptionService.getSubscriptionStatus();
      
      setState(() {
        _subscriptionStatus = status;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(AppConstants.paddingL),
          child: Center(child: CircularProgressIndicator()),
        ),
      );
    }

    if (_error != null) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.paddingL),
          child: Column(
            children: [
              Icon(
                Icons.error_outline,
                color: Colors.red[400],
                size: 32,
              ),
              const SizedBox(height: AppConstants.paddingS),
              Text(
                'Erreur de chargement',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: AppConstants.paddingS),
              ElevatedButton(
                onPressed: _loadSubscriptionStatus,
                child: const Text('Réessayer'),
              ),
            ],
          ),
        ),
      );
    }

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.paddingL),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.card_membership,
                  color: AppConstants.primaryGold,
                  size: 24,
                ),
                const SizedBox(width: AppConstants.paddingS),
                Text(
                  'Statut d\'abonnement',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppConstants.primaryGold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppConstants.paddingM),
            _buildStatusContent(),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusContent() {
    final hasSubscription = _subscriptionStatus?['hasSubscription'] ?? false;
    final canPublish = _subscriptionStatus?['canPublish'] ?? false;
    final isFreeTrial = _subscriptionStatus?['isFreeTrial'] ?? false;
    final isGlobalFreeTrial = _subscriptionStatus?['isGlobalFreeTrial'] ?? false;
    final subscriptionStatusText = _subscriptionStatus?['subscriptionStatus'] ?? 'Aucun abonnement';
    final subscription = _subscriptionStatus?['subscription'] as UserSubscription?;
    final daysRemaining = _subscriptionStatus?['daysRemaining'];

    if (canPublish || isFreeTrial || isGlobalFreeTrial) {
      return _buildActiveStatusContent(
        hasSubscription: hasSubscription,
        canPublish: canPublish,
        isFreeTrial: isFreeTrial,
        isGlobalFreeTrial: isGlobalFreeTrial,
        subscriptionStatusText: subscriptionStatusText,
        subscription: subscription,
        daysRemaining: daysRemaining,
      );
    }

    // Only show "no subscription" if user truly cannot publish
    return _buildNoSubscriptionContent();
  }

  Widget _buildActiveStatusContent({
    required bool hasSubscription,
    required bool canPublish,
    required bool isFreeTrial,
    required bool isGlobalFreeTrial,
    required String subscriptionStatusText,
    required UserSubscription? subscription,
    required dynamic daysRemaining,
  }) {
    // Determine the appropriate status text and color
    String displayStatus;
    Color statusColor;

    if (isGlobalFreeTrial && canPublish) {
      displayStatus = 'Essai gratuit global actif';
      statusColor = AppConstants.primaryOrange;
    } else if (isFreeTrial && canPublish && !isGlobalFreeTrial) {
      displayStatus = 'Essai gratuit actif';
      statusColor = AppConstants.primaryOrange;
    } else if (canPublish && hasSubscription) {
      displayStatus = 'Abonnement actif';
      statusColor = AppConstants.mauritanianGreen;
    } else if ((isFreeTrial || isGlobalFreeTrial) && !canPublish) {
      displayStatus = 'Essai gratuit expiré';
      statusColor = Colors.red;
    } else {
      displayStatus = subscriptionStatusText;
      statusColor = canPublish ? AppConstants.mauritanianGreen : Colors.red;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Status indicator
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.paddingM,
            vertical: AppConstants.paddingS,
          ),
          decoration: BoxDecoration(
            color: statusColor,
            borderRadius: BorderRadius.circular(AppConstants.borderRadiusM),
          ),
          child: Text(
            displayStatus,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppConstants.whiteTextColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: AppConstants.paddingM),

        // Subscription details
        if (subscription != null || isFreeTrial || isGlobalFreeTrial) ...[
          _buildDetailRow(
            'Type:',
            isGlobalFreeTrial
                ? 'Essai gratuit global'
                : isFreeTrial
                    ? 'Essai gratuit'
                    : subscription?.package?.name ?? 'Abonnement payant',
          ),
          const SizedBox(height: AppConstants.paddingS),

          if (subscription != null && daysRemaining != null) ...[
            _buildDetailRow(
              'Temps restant:',
              subscription.timeRemainingText,
            ),
            const SizedBox(height: AppConstants.paddingS),
          ],

          if (subscription != null) ...[
            _buildDetailRow(
              'Expire le:',
              '${subscription.expiresAt.day}/${subscription.expiresAt.month}/${subscription.expiresAt.year}',
            ),
            const SizedBox(height: AppConstants.paddingS),
          ],

          _buildDetailRow(
            'Peut publier:',
            canPublish ? 'Oui' : 'Non',
          ),
        ],

        const SizedBox(height: AppConstants.paddingL),

        // Action buttons
        if ((isFreeTrial || isGlobalFreeTrial) && canPublish) ...[
          // Free trial is active - show upgrade option
          Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isNavigating ? null : () {
                    debugPrint('SubscriptionStatusWidget: Button pressed - "Passer à un abonnement payant"');
                    _navigateToPackages();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppConstants.primaryGold,
                    foregroundColor: AppConstants.whiteTextColor,
                  ),
                  child: _isNavigating
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : Text(isGlobalFreeTrial
                          ? 'Profitez de l\'essai gratuit global'
                          : 'Passer à un abonnement payant'),
                ),
              ),
              const SizedBox(height: AppConstants.paddingS),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: _loadSubscriptionStatus,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppConstants.primaryGold,
                    side: BorderSide(color: AppConstants.primaryGold),
                  ),
                  child: const Text('Actualiser le statut'),
                ),
              ),
            ],
          ),
        ] else if (!canPublish) ...[
          // Cannot publish - need subscription
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _isNavigating ? null : () {
                debugPrint('SubscriptionStatusWidget: Button pressed - "Choisir un abonnement"');
                _navigateToPackages();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppConstants.primaryOrange,
                foregroundColor: AppConstants.whiteTextColor,
              ),
              child: _isNavigating
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : Text(isFreeTrial ? 'Choisir un abonnement' : 'Renouveler l\'abonnement'),
            ),
          ),
        ] else ...[
          // Has active paid subscription
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: _isNavigating ? null : () {
                    debugPrint('SubscriptionStatusWidget: Button pressed - "Étendre"');
                    _navigateToPackages();
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppConstants.primaryGold,
                    side: BorderSide(color: AppConstants.primaryGold),
                  ),
                  child: _isNavigating
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(AppConstants.primaryGold),
                          ),
                        )
                      : const Text('Étendre'),
                ),
              ),
              const SizedBox(width: AppConstants.paddingM),
              Expanded(
                child: ElevatedButton(
                  onPressed: _loadSubscriptionStatus,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppConstants.mauritanianGreen,
                    foregroundColor: AppConstants.whiteTextColor,
                  ),
                  child: const Text('Actualiser'),
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }

  Widget _buildNoSubscriptionContent() {
    final isFreeTrial = _subscriptionStatus?['isFreeTrial'] ?? false;
    final isGlobalFreeTrial = _subscriptionStatus?['isGlobalFreeTrial'] ?? false;
    final canPublish = _subscriptionStatus?['canPublish'] ?? false;

    String statusText;
    String descriptionText;

    if ((isFreeTrial || isGlobalFreeTrial) && !canPublish) {
      statusText = 'Essai gratuit expiré';
      descriptionText = isGlobalFreeTrial
          ? 'La période d\'essai gratuit global est terminée. Choisissez un abonnement pour continuer à publier des applications.'
          : 'Votre période d\'essai gratuit est terminée. Choisissez un abonnement pour continuer à publier des applications.';
    } else {
      statusText = 'Abonnement requis';
      descriptionText = 'Vous devez avoir un abonnement actif pour publier des applications.';
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.paddingM,
            vertical: AppConstants.paddingS,
          ),
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(AppConstants.borderRadiusM),
          ),
          child: Text(
            statusText,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppConstants.whiteTextColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: AppConstants.paddingM),
        Text(
          descriptionText,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: AppConstants.secondaryTextColor,
          ),
        ),
        const SizedBox(height: AppConstants.paddingL),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _isNavigating ? null : () {
              debugPrint('SubscriptionStatusWidget: Button pressed - "Choisir un abonnement" (no subscription)');
              _navigateToPackages();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppConstants.primaryGold,
              foregroundColor: AppConstants.whiteTextColor,
            ),
            child: _isNavigating
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : const Text('Choisir un abonnement'),
          ),
        ),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }

  void _navigateToPackages() {
    // Check if widget is still mounted before navigation
    if (!mounted) {
      debugPrint('SubscriptionStatusWidget: Widget not mounted, cannot navigate');
      return;
    }

    // Prevent multiple rapid navigation attempts
    if (_isNavigating) {
      debugPrint('SubscriptionStatusWidget: Navigation already in progress, ignoring');
      return;
    }

    // Add debug logging to track navigation attempts
    debugPrint('SubscriptionStatusWidget: Attempting navigation to packages');

    setState(() {
      _isNavigating = true;
    });

    // Use callback if provided, otherwise use built-in navigation
    if (widget.onNavigateToPackages != null) {
      debugPrint('SubscriptionStatusWidget: Using provided callback for navigation');
      try {
        widget.onNavigateToPackages!();
        if (mounted) {
          setState(() {
            _isNavigating = false;
          });
        }
      } catch (e) {
        debugPrint('SubscriptionStatusWidget: Callback navigation error: $e');
        if (mounted) {
          setState(() {
            _isNavigating = false;
          });
        }
      }
    } else {
      // Try immediate navigation first, then fallback to post-frame callback
      _performNavigation();
    }
  }

  void _performNavigation() {
    if (!mounted) {
      debugPrint('SubscriptionStatusWidget: Widget unmounted before navigation');
      return;
    }

    try {
      // Try direct navigation first
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const SubscriptionPackagesScreen(),
        ),
      ).then((result) {
        debugPrint('SubscriptionStatusWidget: Direct navigation completed with result: $result');
        if (mounted) {
          setState(() {
            _isNavigating = false;
          });
        }
      }).catchError((error) {
        debugPrint('SubscriptionStatusWidget: Direct navigation error: $error');
        // Try with root navigator as fallback
        _performRootNavigation();
      });
    } catch (e) {
      debugPrint('SubscriptionStatusWidget: Direct navigation exception: $e');
      // Try with root navigator as fallback
      _performRootNavigation();
    }
  }

  void _performRootNavigation() {
    if (!mounted) {
      debugPrint('SubscriptionStatusWidget: Widget unmounted before root navigation');
      return;
    }

    try {
      // Use root navigator to bypass IndexedStack issues
      Navigator.of(context, rootNavigator: true).push(
        MaterialPageRoute(
          builder: (context) => const SubscriptionPackagesScreen(),
        ),
      ).then((result) {
        debugPrint('SubscriptionStatusWidget: Root navigation completed with result: $result');
        if (mounted) {
          setState(() {
            _isNavigating = false;
          });
        }
      }).catchError((error) {
        debugPrint('SubscriptionStatusWidget: Root navigation error: $error');
        if (mounted) {
          setState(() {
            _isNavigating = false;
          });
          _showNavigationError('Erreur de navigation: $error');
        }
      });
    } catch (e) {
      debugPrint('SubscriptionStatusWidget: Root navigation exception: $e');
      if (mounted) {
        setState(() {
          _isNavigating = false;
        });
        _showNavigationError('Impossible de naviguer vers les abonnements');
      }
    }
  }

  void _showNavigationError(String message) {
    if (!mounted) return;

    try {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
        ),
      );
    } catch (e) {
      debugPrint('SubscriptionStatusWidget: Error showing snackbar: $e');
    }
  }
}
