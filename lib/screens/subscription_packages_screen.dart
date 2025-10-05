import 'package:flutter/material.dart';
import '../models/subscription_package.dart';
import '../services/subscription_service.dart';
import '../utils/constants.dart';
import 'payment_screen.dart';

class SubscriptionPackagesScreen extends StatefulWidget {
  const SubscriptionPackagesScreen({super.key});

  @override
  State<SubscriptionPackagesScreen> createState() => _SubscriptionPackagesScreenState();
}

class _SubscriptionPackagesScreenState extends State<SubscriptionPackagesScreen> {
  final SubscriptionService _subscriptionService = SubscriptionService();
  List<SubscriptionPackage> _packages = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadPackages();
  }

  Future<void> _loadPackages() async {
    try {
      setState(() {
        _isLoading = true;
        _error = null;
      });

      final packages = await _subscriptionService.getPackages();
      
      setState(() {
        _packages = packages;
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choisir un abonnement'),
        backgroundColor: AppConstants.primaryGold,
        foregroundColor: AppConstants.whiteTextColor,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? _buildErrorWidget()
              : _buildPackagesList(),
    );
  }

  Widget _buildErrorWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 64,
            color: Colors.red[400],
          ),
          const SizedBox(height: AppConstants.paddingM),
          Text(
            'Erreur de chargement',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: AppConstants.paddingS),
          Text(
            _error!,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppConstants.secondaryTextColor,
            ),
          ),
          const SizedBox(height: AppConstants.paddingL),
          ElevatedButton(
            onPressed: _loadPackages,
            child: const Text('Réessayer'),
          ),
        ],
      ),
    );
  }

  Widget _buildPackagesList() {
    if (_packages.isEmpty) {
      return const Center(
        child: Text('Aucun package disponible'),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppConstants.paddingM),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Choisissez votre plan d\'abonnement',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppConstants.primaryTextColor,
            ),
          ),
          const SizedBox(height: AppConstants.paddingS),
          Text(
            'Sélectionnez le plan qui convient le mieux à vos besoins pour publier vos applications.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppConstants.secondaryTextColor,
            ),
          ),
          const SizedBox(height: AppConstants.paddingL),
          ..._packages.map((package) => _buildPackageCard(package)),
        ],
      ),
    );
  }

  Widget _buildPackageCard(SubscriptionPackage package) {
    final isPopular = package.badge?.toLowerCase().contains('populaire') ?? false;
    final isBestValue = package.badge?.toLowerCase().contains('valeur') ?? false;

    return Container(
      margin: const EdgeInsets.only(bottom: AppConstants.paddingM),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
        border: Border.all(
          color: isPopular 
              ? AppConstants.primaryGold 
              : AppConstants.dividerColor,
          width: isPopular ? 2 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(AppConstants.paddingL),
            decoration: BoxDecoration(
              color: AppConstants.surfaceColor,
              borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            package.name,
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppConstants.primaryTextColor,
                            ),
                          ),
                          if (package.description != null) ...[
                            const SizedBox(height: AppConstants.paddingXS),
                            Text(
                              package.description!,
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: AppConstants.secondaryTextColor,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        if (package.hasDiscount) ...[
                          Text(
                            package.formattedOriginalPrice!,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              decoration: TextDecoration.lineThrough,
                              color: AppConstants.secondaryTextColor,
                            ),
                          ),
                          const SizedBox(height: 2),
                        ],
                        Text(
                          package.formattedPrice,
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppConstants.primaryGold,
                          ),
                        ),
                        Text(
                          package.pricePerMonth,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppConstants.secondaryTextColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: AppConstants.paddingM),
                if (package.features != null && package.features!.isNotEmpty) ...[
                  ...package.features!.map((feature) => Padding(
                    padding: const EdgeInsets.only(bottom: AppConstants.paddingXS),
                    child: Row(
                      children: [
                        Icon(
                          Icons.check_circle,
                          size: 16,
                          color: AppConstants.mauritanianGreen,
                        ),
                        const SizedBox(width: AppConstants.paddingS),
                        Expanded(
                          child: Text(
                            feature,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                      ],
                    ),
                  )),
                  const SizedBox(height: AppConstants.paddingM),
                ],
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => _selectPackage(package),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isPopular 
                          ? AppConstants.primaryGold 
                          : AppConstants.primaryOrange,
                      foregroundColor: AppConstants.whiteTextColor,
                      padding: const EdgeInsets.symmetric(
                        vertical: AppConstants.paddingM,
                      ),
                    ),
                    child: Text(
                      'Choisir ce plan',
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (package.badge != null)
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.paddingM,
                  vertical: AppConstants.paddingS,
                ),
                decoration: BoxDecoration(
                  color: isPopular 
                      ? AppConstants.primaryGold 
                      : isBestValue 
                          ? AppConstants.mauritanianGreen 
                          : AppConstants.primaryOrange,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(AppConstants.borderRadiusL),
                    bottomLeft: Radius.circular(AppConstants.borderRadiusM),
                  ),
                ),
                child: Text(
                  package.badge!,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppConstants.whiteTextColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          if (package.hasDiscount)
            Positioned(
              top: AppConstants.paddingM,
              left: AppConstants.paddingM,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.paddingS,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: AppConstants.richRed,
                  borderRadius: BorderRadius.circular(AppConstants.borderRadiusS),
                ),
                child: Text(
                  '-${package.discountPercentage}%',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppConstants.whiteTextColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _selectPackage(SubscriptionPackage package) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaymentScreen(package: package),
      ),
    );
  }
}
