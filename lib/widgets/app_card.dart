import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/mauritanian_app.dart';
import '../utils/constants.dart';

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
        child: isCompact ? _buildCompactLayout(theme) : _buildFullLayout(theme),
      ),
    );
  }

  Widget _buildFullLayout(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // App icon and featured badge
        Stack(
          children: [
            Container(
              height: 120,
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
                child: _buildAppIcon(AppConstants.appIconSizeL),
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
                  child: const Text(
                    'Vedette',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: AppConstants.primaryTextColor,
                    ),
                  ),
                ),
              ),
          ],
        ),

        // App information
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(AppConstants.paddingM),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // App name
                Text(
                  app.name,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: AppConstants.paddingXS),

                // Developer name
                Text(
                  app.developerName,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: AppConstants.secondaryTextColor,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: AppConstants.paddingS),

                // Description
                Expanded(
                  child: Text(
                    app.description,
                    style: theme.textTheme.bodySmall,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: AppConstants.paddingS),

                // Rating and downloads
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
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Spacer(),
                    Icon(
                      Icons.download,
                      size: AppConstants.iconSizeS,
                      color: AppConstants.secondaryTextColor,
                    ),
                    const SizedBox(width: AppConstants.paddingXS),
                    Text(
                      _formatDownloadCount(app.downloadCount),
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: AppConstants.secondaryTextColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCompactLayout(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.all(AppConstants.paddingM),
      child: Row(
        children: [
          // App icon
          _buildAppIcon(AppConstants.appIconSizeM),
          const SizedBox(width: AppConstants.paddingM),

          // App information
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // App name and featured badge
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        app.name,
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
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
                          vertical: AppConstants.paddingXS,
                        ),
                        decoration: BoxDecoration(
                          color: AppConstants.primaryYellow,
                          borderRadius: BorderRadius.circular(AppConstants.borderRadiusM),
                        ),
                        child: const Text(
                          'Vedette',
                          style: TextStyle(
                            fontSize: 8,
                            fontWeight: FontWeight.bold,
                            color: AppConstants.primaryTextColor,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: AppConstants.paddingXS),

                // Developer name
                Text(
                  app.developerName,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: AppConstants.secondaryTextColor,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: AppConstants.paddingXS),

                // Rating and downloads
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
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: AppConstants.paddingM),
                    Icon(
                      Icons.download,
                      size: AppConstants.iconSizeS,
                      color: AppConstants.secondaryTextColor,
                    ),
                    const SizedBox(width: AppConstants.paddingXS),
                    Text(
                      _formatDownloadCount(app.downloadCount),
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: AppConstants.secondaryTextColor,
                      ),
                    ),
                  ],
                ),
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
          imageUrl: app.iconUrl,
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
