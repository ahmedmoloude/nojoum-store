import 'package:flutter/material.dart';
import '../models/ad_banner.dart';
import '../utils/constants.dart';

/// Widget for displaying advertisement banners in the marketplace
class AdBannerWidget extends StatelessWidget {
  final AdBanner adBanner;
  final VoidCallback? onTap;

  const AdBannerWidget({
    super.key,
    required this.adBanner,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    if (!adBanner.isValid) {
      return const SizedBox.shrink();
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(AppConstants.paddingM),
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
          child: Stack(
            children: [
              // Ad Image
              Image.network(
                adBanner.imageUrl,
                width: double.infinity,
                height: _getAdHeight(),
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return _buildPlaceholderAd();
                },
              ),
              
              // Sponsored Label
              Positioned(
                top: AppConstants.paddingS,
                right: AppConstants.paddingS,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppConstants.paddingS,
                    vertical: AppConstants.paddingXS,
                  ),
                  decoration: BoxDecoration(
                    color: AppConstants.orange,
                    borderRadius: BorderRadius.circular(AppConstants.borderRadiusS),
                  ),
                  child: const Text(
                    'Sponsorisé',
                    style: TextStyle(
                      color: AppConstants.whiteTextColor,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              
              // Ad Content Overlay (for native ads)
              if (adBanner.adType == AdType.native)
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(AppConstants.paddingM),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.7),
                        ],
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          adBanner.title,
                          style: const TextStyle(
                            color: AppConstants.whiteTextColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        if (adBanner.description.isNotEmpty) ...[
                          const SizedBox(height: AppConstants.paddingXS),
                          Text(
                            adBanner.description,
                            style: const TextStyle(
                              color: AppConstants.whiteTextColor,
                              fontSize: 12,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlaceholderAd() {
    return Container(
      width: double.infinity,
      height: _getAdHeight(),
      color: Colors.grey[100],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.ads_click,
            size: 32,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 8),
          Text(
            'Espace publicitaire',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
            ),
          ),
          Text(
            adBanner.title,
            style: TextStyle(
              color: Colors.grey[500],
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  double _getAdHeight() {
    switch (adBanner.adType) {
      case AdType.banner:
        return 60;
      case AdType.carousel:
      case AdType.native:
        return 120;
      case AdType.video:
        return 180;
      default:
        return 100;
    }
  }
}

/// Placeholder ad banner for development
class PlaceholderAdBanner extends StatelessWidget {
  final String title;
  final String subtitle;
  final double height;
  final Color? backgroundColor;

  const PlaceholderAdBanner({
    super.key,
    required this.title,
    this.subtitle = '',
    this.height = 100,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(AppConstants.paddingM),
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.grey[100],
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusM),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.ads_click,
              size: 32,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (subtitle.isNotEmpty) ...[
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: 12,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
