import 'package:flutter/material.dart';
import '../models/mauritanian_app.dart';
import '../utils/constants.dart';

/// Screen displaying detailed information about a Mauritanian application
class AppDetailScreen extends StatelessWidget {
  final MauritanianApp app;

  const AppDetailScreen({
    super.key,
    required this.app,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(app.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              // TODO: Implement share functionality
            },
          ),
          IconButton(
            icon: const Icon(Icons.favorite_border),
            onPressed: () {
              // TODO: Implement favorites functionality
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppConstants.paddingM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // App header
            Row(
              children: [
                Container(
                  width: AppConstants.appIconSizeXL,
                  height: AppConstants.appIconSizeXL,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppConstants.borderRadiusM),
                    color: AppConstants.primaryGreen.withOpacity(0.1),
                  ),
                  child: const Icon(
                    Icons.apps,
                    size: AppConstants.iconSizeXL,
                    color: AppConstants.primaryGreen,
                  ),
                ),
                const SizedBox(width: AppConstants.paddingM),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        app.name,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: AppConstants.paddingS),
                      Text(
                        app.developerName,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppConstants.secondaryTextColor,
                        ),
                      ),
                      const SizedBox(height: AppConstants.paddingS),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            size: AppConstants.iconSizeS,
                            color: AppConstants.primaryYellow,
                          ),
                          const SizedBox(width: AppConstants.paddingXS),
                          Text(
                            app.rating.toStringAsFixed(1),
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          const SizedBox(width: AppConstants.paddingM),
                          Icon(
                            Icons.download,
                            size: AppConstants.iconSizeS,
                            color: AppConstants.secondaryTextColor,
                          ),
                          const SizedBox(width: AppConstants.paddingXS),
                          Text(
                            '${app.downloadCount}+',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: AppConstants.paddingL),
            
            // Contact buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // TODO: Implement email contact
                    },
                    icon: const Icon(Icons.email),
                    label: const Text('Email'),
                  ),
                ),
                const SizedBox(width: AppConstants.paddingM),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      // TODO: Implement phone contact
                    },
                    icon: const Icon(Icons.phone),
                    label: const Text('Appeler'),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: AppConstants.paddingL),
            
            // Description
            Text(
              'Description',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: AppConstants.paddingM),
            Text(
              app.description,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            
            const SizedBox(height: AppConstants.paddingL),
            
            // App info
            Text(
              'Informations',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: AppConstants.paddingM),
            _buildInfoRow('Catégorie', app.category),
            _buildInfoRow('Public cible', app.targetAudience),
            _buildInfoRow('Type de développeur', app.developerType),
            _buildInfoRow('Date d\'ajout', app.dateAdded.toString().split(' ')[0]),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppConstants.paddingS),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: AppConstants.secondaryTextColor,
              ),
            ),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }
}
