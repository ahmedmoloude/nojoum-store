import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/mauritanian_app.dart';
import '../utils/constants.dart';

import '../l10n/app_localizations.dart';

/// Reusable card widget for displaying Mauritanian applications
class AppCard extends StatelessWidget {
  final MauritanianApp app;
  final VoidCallback? onTap;
  final bool showFeaturedBadge;
  final bool isCompact;

  const AppCard({
    super.key,
    required this.app,
    this.onTap,
    this.showFeaturedBadge = false,
    this.isCompact = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: isCompact ? _buildCompactLayout(context, theme) : _buildFullLayout(context, theme),
      ),
    );
  }

  Widget _buildFullLayout(BuildContext context, ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // App icon and featured badge
        Stack(
          children: [
            Container(
              height: 100, // Reduced from 120 to fit better
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppConstants.primaryGreen.withOpacity(0.1),
                    AppConstants.primaryYellow.withOpacity(0.1),
                  ],
                ),
              ),
              child: Center(
                child: _buildAppIcon(AppConstants.appIconSizeM), // Reduced icon size
              ),
            ),
            if (showFeaturedBadge && app.isFeatured)
              Positioned(
                top: AppConstants.paddingS,
                right: AppConstants.paddingS,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppConstants.paddingS,
                    vertical: AppConstants.paddingXS,
                  ),
                  decoration: BoxDecoration(
                    color: AppConstants.primaryYellow,
                    borderRadius: BorderRadius.circular(AppConstants.borderRadiusM),
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.featured,
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: AppConstants.primaryTextColor,
                    ),
                  ),
                ),
              ),
          ],
        ),

        // App information - FIXED OVERFLOW
        Padding(
          padding: const EdgeInsets.all(AppConstants.paddingS), // Reduced padding
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // App name
              Text(
                app.name,
                style: theme.textTheme.titleSmall?.copyWith( // Smaller title
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 2), // Reduced spacing

              // Developer name
              Text(
                app.developerName,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: AppConstants.secondaryTextColor,
                  fontSize: 11,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4), // Reduced spacing

              // Description
              Text(

                // get only the first 100 characters of the description
                app.description.length > 20 ?  app.description.substring(0, 20) + '...' : app.description,
                style: theme.textTheme.bodySmall?.copyWith(
                  fontSize: 10,
                ),
                maxLines: 2, // Reduced max lines
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4), // Reduced spacing

            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCompactLayout(BuildContext context, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.all(AppConstants.paddingS), // Reduced padding
      child: Row(
        children: [
          // App icon
          _buildAppIcon(48), // Fixed size instead of constant
          const SizedBox(width: AppConstants.paddingM),

          // App information - FIXED OVERFLOW
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                // App name and featured badge
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        app.name,
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (showFeaturedBadge && app.isFeatured)
                      Container(
                        margin: const EdgeInsets.only(left: AppConstants.paddingS),
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppConstants.paddingS,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: AppConstants.primaryYellow,
                          borderRadius: BorderRadius.circular(AppConstants.borderRadiusM),
                        ),
                        child: Text(
                          AppLocalizations.of(context)!.featured,
                          style: const TextStyle(
                            fontSize: 8,
                            fontWeight: FontWeight.bold,
                            color: AppConstants.primaryTextColor,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 4),

                // Developer name
                Text(
                  app.developerName,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: AppConstants.secondaryTextColor,
                    fontSize: 12,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),

              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppIcon(double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusM),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusM),
        child: CachedNetworkImage(
          imageUrl: app.iconUrl.startsWith('http') ? app.iconUrl : 'https://noujoumstore.com' + app.iconUrl,
          fit: BoxFit.cover,
          placeholder: (context, url) => Container(
            color: AppConstants.primaryGreen.withOpacity(0.1),
            child: Icon(
              Icons.apps,
              size: size * 0.5,
              color: AppConstants.primaryGreen,
            ),
          ),
          errorWidget: (context, url, error) => Container(
            color: AppConstants.primaryGreen.withOpacity(0.1),
            child: Icon(
              Icons.apps,
              size: size * 0.5,
              color: AppConstants.primaryGreen,
            ),
          ),
        ),
      ),
    );
  }

  String _formatDownloadCount(int count) {
    if (count >= 1000000) {
      return '${(count / 1000000).toStringAsFixed(1)}M';
    } else if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}K';
    } else {
      return count.toString();
    }
  }
}