import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/mauritanian_app.dart';
import '../utils/constants.dart';
import '../l10n/app_localizations.dart';


/// Screen displaying detailed information about a Mauritanian application
class AppDetailScreen extends StatefulWidget {
  final MauritanianApp app;

  const AppDetailScreen({
    super.key,
    required this.app,
  });

  @override
  State<AppDetailScreen> createState() => _AppDetailScreenState();
}

class _AppDetailScreenState extends State<AppDetailScreen> {
  int _currentScreenshotIndex = 0;
  final PageController _screenshotController = PageController();

  @override
  void dispose() {
    _screenshotController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.app.name),
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
            // App header with enhanced info
            _buildAppHeader(context, l10n),

            const SizedBox(height: AppConstants.paddingL),

            // Screenshots carousel
            if (widget.app.screenshots.isNotEmpty) ...[
              _buildScreenshotsSection(context, l10n),
              const SizedBox(height: AppConstants.paddingL),
            ],

            // Action buttons
            _buildActionButtons(context, l10n),

            const SizedBox(height: AppConstants.paddingL),

            // Description
            _buildDescriptionSection(context, l10n),

            const SizedBox(height: AppConstants.paddingL),

            // Technical Details
            _buildTechnicalDetailsSection(context, l10n),

            const SizedBox(height: AppConstants.paddingL),

            // Business Information
            _buildBusinessInformationSection(context, l10n),

            const SizedBox(height: AppConstants.paddingL),

            // Support & Documentation
            _buildSupportSection(context, l10n),

            const SizedBox(height: AppConstants.paddingL),

            // App Info
            _buildAppInfoSection(context, l10n),

            const SizedBox(height: AppConstants.paddingL),

            // Contact buttons
            _buildContactButtons(context, l10n),
          ],
        ),
      ),
    );
  }

  Widget _buildAppHeader(BuildContext context, AppLocalizations l10n) {
    return Row(
      children: [
        Container(
          width: AppConstants.appIconSizeXL,
          height: AppConstants.appIconSizeXL,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppConstants.borderRadiusM),
            color: AppConstants.primaryGreen.withValues(alpha: 0.1),
          ),
          clipBehavior: Clip.antiAlias,
          child: CachedNetworkImage(
            imageUrl: widget.app.iconUrl.startsWith('http') ? widget.app.iconUrl : 'https://noujoumstore.com${widget.app.iconUrl}',
            fit: BoxFit.cover,
            placeholder: (context, url) => Container(
              color: AppConstants.primaryGreen.withValues(alpha: 0.1),
              child: const Icon(
                Icons.apps,
                size: AppConstants.iconSizeXL,
                color: AppConstants.primaryGreen,
              ),
            ),
            errorWidget: (context, url, error) => Container(
              color: AppConstants.primaryGreen.withValues(alpha: 0.1),
              child: const Icon(
                Icons.apps,
                size: AppConstants.iconSizeXL,
                color: AppConstants.primaryGreen,
              ),
            ),
          ),
        ),
        const SizedBox(width: AppConstants.paddingM),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.app.name,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                  if (widget.app.isVerified)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppConstants.primaryGreen,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        l10n.verified,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                ],
              ),
              if (widget.app.tagline.isNotEmpty) ...[
                const SizedBox(height: AppConstants.paddingXS),
                Text(
                  widget.app.tagline,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppConstants.secondaryTextColor,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
              const SizedBox(height: AppConstants.paddingS),
              Text(
                widget.app.developerName,
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
                    widget.app.rating.toStringAsFixed(1),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(width: AppConstants.paddingM),
                  Icon(
                    Icons.download,
                    size: AppConstants.iconSizeS,
                    color: AppConstants.secondaryTextColor,
                  ),
                  const SizedBox(width: AppConstants.paddingXS),
                ],
              ),
              const SizedBox(height: AppConstants.paddingS),
              Text(
                '${l10n.pricing}: ${widget.app.pricing}',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppConstants.primaryGreen,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildScreenshotsSection(BuildContext context, AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.screenshots,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: AppConstants.paddingM),
        SizedBox(
          height: 200,
          child: PageView.builder(
            controller: _screenshotController,
            onPageChanged: (index) {
              setState(() {
                _currentScreenshotIndex = index;
              });
            },
            itemCount: widget.app.screenshots.length,
            itemBuilder: (context, index) {
              final screenshot = widget.app.screenshots[index];
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppConstants.borderRadiusM),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                clipBehavior: Clip.antiAlias,
                child: CachedNetworkImage(
                  imageUrl: screenshot.startsWith('http') ? screenshot : 'https://noujoumstore.com$screenshot',
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    color: AppConstants.primaryGreen.withValues(alpha: 0.1),
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    color: AppConstants.primaryGreen.withValues(alpha: 0.1),
                    child: const Icon(
                      Icons.image_not_supported,
                      size: 48,
                      color: AppConstants.secondaryTextColor,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        if (widget.app.screenshots.length > 1) ...[
          const SizedBox(height: AppConstants.paddingM),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              widget.app.screenshots.length,
              (index) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentScreenshotIndex == index
                      ? AppConstants.primaryGreen
                      : AppConstants.primaryGreen.withValues(alpha: 0.3),
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context, AppLocalizations l10n) {
    return Row(
      children: [
        if (widget.app.downloadLink.isNotEmpty)
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () async {
                final uri = Uri.parse(widget.app.downloadLink);
                if (await canLaunchUrl(uri)) {
                  await launchUrl(uri, mode: LaunchMode.externalApplication);
                }
              },
              icon: const Icon(Icons.download),
              label: Text(l10n.downloadApp),
            ),
          ),
        if (widget.app.downloadLink.isNotEmpty && widget.app.liveDemo.isNotEmpty)
          const SizedBox(width: AppConstants.paddingM),
        if (widget.app.liveDemo.isNotEmpty)
          Expanded(
            child: OutlinedButton.icon(
              onPressed: () async {
                final uri = Uri.parse(widget.app.liveDemo);
                if (await canLaunchUrl(uri)) {
                  await launchUrl(uri, mode: LaunchMode.externalApplication);
                }
              },
              icon: const Icon(Icons.play_arrow),
              label: Text(l10n.tryDemo),
            ),
          ),
      ],
    );
  }

  Widget _buildDescriptionSection(BuildContext context, AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.description,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: AppConstants.paddingM),
        Text(
          widget.app.description,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        if (widget.app.detailedDescription.isNotEmpty) ...[
          const SizedBox(height: AppConstants.paddingM),
          Text(
            widget.app.detailedDescription,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ],
    );
  }

  Widget _buildTechnicalDetailsSection(BuildContext context, AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.technicalDetails,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: AppConstants.paddingM),
        _buildInfoRow(l10n.appType, _getAppTypeLabel(widget.app.appType, l10n)),
        _buildInfoRow(l10n.platforms, widget.app.supportedPlatforms.map((p) => _getPlatformLabel(p)).join(', ')),
        _buildInfoRow(l10n.currentVersion, widget.app.currentVersion),
        _buildInfoRow(l10n.lastUpdated, widget.app.lastUpdate.toString().split(' ')[0]),
        if (widget.app.technicalRequirements.isNotEmpty)
          _buildInfoRow(l10n.technicalRequirements, widget.app.technicalRequirements),
        _buildInfoRow(l10n.languages, widget.app.languages.join(', ')),
        if (widget.app.isOpenSource)
          _buildInfoRow(l10n.openSource, l10n.available),
      ],
    );
  }

  Widget _buildBusinessInformationSection(BuildContext context, AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.businessInformation,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: AppConstants.paddingM),
        _buildInfoRow(l10n.targetAudience, widget.app.targetAudience),
        if (widget.app.businessSectors.isNotEmpty)
          _buildInfoRow(l10n.businessSectors, widget.app.businessSectors.join(', ')),
        if (widget.app.businessValue.isNotEmpty)
          _buildInfoRow(l10n.businessValue, widget.app.businessValue),
        if (widget.app.keyFeatures.isNotEmpty) ...[
          const SizedBox(height: AppConstants.paddingS),
          Text(
            l10n.keyFeatures,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              color: AppConstants.secondaryTextColor,
            ),
          ),
          const SizedBox(height: AppConstants.paddingS),
          ...widget.app.keyFeatures.map((feature) => Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('• ', style: TextStyle(fontWeight: FontWeight.bold)),
                Expanded(child: Text(feature)),
              ],
            ),
          )),
        ],
        if (widget.app.hasFreeTrial) ...[
          const SizedBox(height: AppConstants.paddingS),
          _buildInfoRow(l10n.freeTrial, l10n.trialDays(widget.app.trialDays)),
        ],
      ],
    );
  }

  Widget _buildSupportSection(BuildContext context, AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.supportAndDocumentation,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: AppConstants.paddingM),
        if (widget.app.supportOptions.isNotEmpty)
          _buildInfoRow(l10n.supportOptions, widget.app.supportOptions.map((s) => _getSupportTypeLabel(s, l10n)).join(', ')),
        _buildInfoRow(l10n.documentation, widget.app.hasDocumentation ? l10n.available : l10n.notAvailable),
        if (widget.app.hasDocumentation && widget.app.documentationUrl.isNotEmpty) ...[
          const SizedBox(height: AppConstants.paddingM),
          ElevatedButton.icon(
            onPressed: () async {
              final uri = Uri.parse(widget.app.documentationUrl);
              if (await canLaunchUrl(uri)) {
                await launchUrl(uri, mode: LaunchMode.externalApplication);
              }
            },
            icon: const Icon(Icons.description),
            label: Text(l10n.viewDocumentation),
          ),
        ],
      ],
    );
  }

  Widget _buildAppInfoSection(BuildContext context, AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.appInfo,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: AppConstants.paddingM),
        _buildInfoRow(l10n.category, widget.app.category),
        if (widget.app.subcategory.isNotEmpty)
          _buildInfoRow(l10n.subcategory, widget.app.subcategory),
        if (widget.app.tags.isNotEmpty)
          _buildInfoRow(l10n.tags, widget.app.tags.join(', ')),
        _buildInfoRow(l10n.publishDate, widget.app.publishDate.toString().split(' ')[0]),
        _buildInfoRow(l10n.activeUsers, widget.app.activeUsers.toString()),
        if (widget.app.companyName.isNotEmpty)
          _buildInfoRow(l10n.companyName, widget.app.companyName),
        if (widget.app.developerWebsite.isNotEmpty)
          _buildInfoRow(l10n.website, widget.app.developerWebsite),
      ],
    );
  }

  Widget _buildContactButtons(BuildContext context, AppLocalizations l10n) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () async {
                  final messenger = ScaffoldMessenger.of(context);
                  final email = widget.app.contactEmail.trim();
                  if (email.isEmpty) {
                    messenger.showSnackBar(
                      SnackBar(content: Text(l10n.noEmailAvailable)),
                    );
                    return;
                  }
                  final uri = Uri(
                    scheme: 'mailto',
                    path: email,
                    queryParameters: {
                      'subject': l10n.contactEmailSubject(widget.app.name),
                    },
                  );
                  if (await canLaunchUrl(uri)) {
                    await launchUrl(uri, mode: LaunchMode.externalApplication);
                  } else {
                    messenger.showSnackBar(
                      SnackBar(content: Text(l10n.emailOpenError)),
                    );
                  }
                },
                icon: const Icon(Icons.email),
                label: Text(l10n.email),
              ),
            ),
            const SizedBox(width: AppConstants.paddingM),
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () async {
                  final messenger = ScaffoldMessenger.of(context);
                  final phone = widget.app.contactPhone.replaceAll(' ', '');
                  if (phone.isEmpty) {
                    messenger.showSnackBar(
                      SnackBar(content: Text(l10n.noPhoneAvailable)),
                    );
                    return;
                  }
                  final uri = Uri(
                    scheme: 'tel',
                    path: phone,
                  );
                  if (await canLaunchUrl(uri)) {
                    await launchUrl(uri, mode: LaunchMode.externalApplication);
                  } else {
                    messenger.showSnackBar(
                      SnackBar(content: Text(l10n.callOpenError)),
                    );
                  }
                },
                icon: const Icon(Icons.phone),
                label: Text(l10n.call),
              ),
            ),
          ],
        ),
        if (widget.app.developerWhatsApp.isNotEmpty) ...[
          const SizedBox(height: AppConstants.paddingM),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () async {
                final whatsapp = widget.app.developerWhatsApp.replaceAll(' ', '');
                final uri = Uri.parse('https://wa.me/$whatsapp');
                if (await canLaunchUrl(uri)) {
                  await launchUrl(uri, mode: LaunchMode.externalApplication);
                }
              },
              icon: const Icon(Icons.chat),
              label: Text(l10n.whatsapp),
            ),
          ),
        ],
      ],
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

  String _getAppTypeLabel(AppType type, AppLocalizations l10n) {
    switch (type) {
      case AppType.mobile: return l10n.appTypeMobile;
      case AppType.web: return l10n.appTypeWeb;
      case AppType.desktop: return l10n.appTypeDesktop;
      case AppType.saas: return l10n.appTypeSaas;
      case AppType.api: return l10n.appTypeApi;
      case AppType.plugin: return l10n.appTypePlugin;
      case AppType.template: return l10n.appTypeTemplate;
    }
  }

  String _getPlatformLabel(Platform platform) {
    switch (platform) {
      case Platform.iOS: return 'iOS';
      case Platform.android: return 'Android';
      case Platform.windows: return 'Windows';
      case Platform.macOS: return 'macOS';
      case Platform.linux: return 'Linux';
      case Platform.web: return 'Web';
      case Platform.api: return 'API';
    }
  }

  String _getSupportTypeLabel(SupportType type, AppLocalizations l10n) {
    switch (type) {
      case SupportType.email: return l10n.supportTypeEmail;
      case SupportType.phone: return l10n.supportTypePhone;
      case SupportType.chat: return l10n.supportTypeChat;
      case SupportType.training: return l10n.supportTypeTraining;
      case SupportType.documentation: return l10n.supportTypeDocumentation;
    }
  }
}
