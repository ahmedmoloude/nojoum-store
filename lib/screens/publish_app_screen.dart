import 'dart:developer';

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import '../services/api_service.dart';

import 'package:flutter_form_builder/flutter_form_builder.dart';
import '../models/mauritanian_app.dart';
import '../models/app_category.dart';
import '../services/auth_service.dart';
import '../services/app_service.dart';
import '../services/category_service.dart';
import '../utils/constants.dart';
import 'auth/login_screen.dart';
import 'subscription_packages_screen.dart';
import '../l10n/app_localizations.dart';

/// Multi-step app publishing screen for developers
class PublishAppScreen extends StatefulWidget {
  const PublishAppScreen({super.key});

  @override
  State<PublishAppScreen> createState() => _PublishAppScreenState();
}

class _PublishAppScreenState extends State<PublishAppScreen> {
  final PageController _pageController = PageController();
  final ImagePicker _imagePicker = ImagePicker();
  String? _uploadedIconUrl;
  bool _isUploadingIcon = false;
  List<String> _uploadedScreenshotUrls = [];
  bool _isUploadingScreenshots = false;

  // Categories from API
  List<AppCategory> _categories = [];
  bool _isLoadingCategories = true;

  Future<void> _pickAndUploadIcon(FormFieldState<String> field) async {
    try {
      final XFile? picked = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1024,
        imageQuality: 85,
      );
      if (picked == null) return;

      setState(() => _isUploadingIcon = true);

      final file = File(picked.path);
      final resp = await ApiService.uploadFile(file, fields: {'folder': 'app-icons'});
      final url = (resp['data'] ?? {})['url']?.toString();
      if (url == null || url.isEmpty) {
        throw Exception('Upload failed');
      }

      setState(() {
        _uploadedIconUrl = 'https://noujoumstore.com' + url;
      });
      field.didChange(url);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.iconUploadedSuccess)),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.uploadFailed(e.toString())), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) setState(() => _isUploadingIcon = false);
    }
  }

  Future<void> _pickAndUploadScreenshots(FormFieldState<List<String>> field) async {
    try {
      final List<XFile> picked = await _imagePicker.pickMultiImage(
        maxWidth: 1024,
        imageQuality: 85,
      );
      if (picked.isEmpty) return;

      // Limit to 10 screenshots total
      if (_uploadedScreenshotUrls.length + picked.length > 10) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.maxScreenshotsLimit),
            backgroundColor: Colors.orange,
          ),
        );
        return;
      }

      setState(() => _isUploadingScreenshots = true);

      List<String> newUrls = [];
      for (final pickedFile in picked) {
        final file = File(pickedFile.path);
        final resp = await ApiService.uploadFile(file, fields: {'folder': 'app-screenshots'});
        final url = (resp['data'] ?? {})['url']?.toString();
        if (url != null && url.isNotEmpty) {
          newUrls.add( 'https://noujoumstore.com' + url);
        }
      }

      setState(() {
        _uploadedScreenshotUrls.addAll(newUrls);
      });
      field.didChange(_uploadedScreenshotUrls);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.screenshotsUploadedCount(newUrls.length))),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.uploadFailedGeneric(e.toString())), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) setState(() => _isUploadingScreenshots = false);
    }
  }

  void _removeScreenshot(int index, FormFieldState<List<String>> field) {
    setState(() {
      _uploadedScreenshotUrls.removeAt(index);
    });
    field.didChange(_uploadedScreenshotUrls);
  }

  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  int _currentStep = 0;
  final int _totalSteps = 4;

  @override
  void initState() {
    super.initState();
    _checkAuthentication();
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    try {
      final categories = await CategoryService.getCategories();
      if (mounted) {
        setState(() {
          _categories = categories;
          _isLoadingCategories = false;
        });
      }
    } catch (e) {
      log('Error loading categories: $e');
      if (mounted) {
        setState(() {
          _isLoadingCategories = false;
          // Fallback to static categories if API fails
          _categories = AppCategories.all;
        });
      }
    }
  }

  void _checkAuthentication() {
    if (!AuthService.staticIsLoggedIn) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showLoginRequired();
      });
    }
  }

  void _showLoginRequired() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.loginRequiredTitle),
        content: Text(
          AppLocalizations.of(context)!.loginRequiredContent,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop(); // Go back to previous screen
            },
            child: Text(AppLocalizations.of(context)!.cancel),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.of(context).pop();
              final result = await Navigator.push<bool>(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
              if (result != true) {
                Navigator.of(context).pop(); // Go back if login failed
              }
            },
            child: Text(AppLocalizations.of(context)!.loginButton),
          ),
        ],
      ),
    );
  }

  void _showSubscriptionRequiredDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(
              Icons.card_membership,
              color: AppConstants.primaryGold,
            ),
            const SizedBox(width: 8),
            Text(AppLocalizations.of(context)!.subscriptionRequiredTitle),
          ],
        ),
        content: Text(
          AppLocalizations.of(context)!.subscriptionRequiredContent,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop(); // Go back to previous screen
            },
            child: Text(AppLocalizations.of(context)!.cancel),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.of(context).pop();
              // Navigate to subscription packages
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SubscriptionPackagesScreen()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppConstants.primaryGold,
              foregroundColor: AppConstants.whiteTextColor,
            ),
            child: Text(AppLocalizations.of(context)!.viewSubscriptions),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.publishAppTitle),
        backgroundColor: AppConstants.teal,
        foregroundColor: AppConstants.whiteTextColor,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Progress indicator
          _buildProgressIndicator(theme),

          // Form content
          Expanded(
            child: FormBuilder(
              key: _formKey,
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() => _currentStep = index);
                },
                children: [
                  _buildBasicInfoStep(),
                  _buildTechnicalDetailsStep(),
                  _buildPricingStep(),
                  _buildBusinessDetailsStep(),
                ],
              ),
            ),
          ),

          // Navigation buttons
          _buildNavigationButtons(),
        ],
      ),
    );
  }

  Widget _buildProgressIndicator(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.paddingM),
      decoration: BoxDecoration(
        color: AppConstants.teal,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: List.generate(_totalSteps, (index) {
              final isActive = index <= _currentStep;
              final isCompleted = index < _currentStep;

              return Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: AppConstants.paddingXS),
                  height: 4,
                  decoration: BoxDecoration(
                    color: isActive
                        ? AppConstants.whiteTextColor
                        : AppConstants.whiteTextColor.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: AppConstants.paddingM),
          Text(
            AppLocalizations.of(context)!.stepProgress(_currentStep + 1, _totalSteps),
            style: theme.textTheme.titleMedium?.copyWith(
              color: AppConstants.whiteTextColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: AppConstants.paddingS),
          Text(
            _getStepTitle(_currentStep),
            style: theme.textTheme.bodyMedium?.copyWith(
              color: AppConstants.whiteTextColor.withOpacity(0.9),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBasicInfoStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppConstants.paddingM),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
            Text(
              AppLocalizations.of(context)!.stepBasicInfo,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: AppConstants.paddingL),

            FormBuilderTextField(
              name: 'appName',
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.appNameLabel,
                hintText: AppLocalizations.of(context)!.appNameHint,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return AppLocalizations.of(context)!.appNameRequired;
                }
                return null;
              },
            ),
            const SizedBox(height: AppConstants.paddingM),

            FormBuilderTextField(
              name: 'tagline',
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.taglineLabel,
                hintText: AppLocalizations.of(context)!.taglineHint,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return AppLocalizations.of(context)!.taglineRequired;
                }
                return null;
              },
            ),
            const SizedBox(height: AppConstants.paddingM),

            FormBuilderTextField(
              name: 'description',
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.shortDescriptionLabel,
                hintText: AppLocalizations.of(context)!.shortDescriptionHint,
              ),
              maxLines: 3,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return AppLocalizations.of(context)!.shortDescriptionRequired;
                }
                return null;
              },
            ),
            const SizedBox(height: AppConstants.paddingM),

            _isLoadingCategories
                ? const Center(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: CircularProgressIndicator(),
                    ),
                  )
                : FormBuilderDropdown<String>(
                    name: 'category',
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!.mainCategoryLabel,
                    ),
                    items: _categories
                        .map((category) => DropdownMenuItem(
                              value: category.id,
                              child: Text(category.name),
                            ))
                        .toList(),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppLocalizations.of(context)!.selectCategoryValidation;
                      }
                      return null;
                    },
                  ),
            const SizedBox(height: AppConstants.paddingM),

            FormBuilderDropdown<String>(
              name: 'targetAudience',
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.targetAudienceLabel,
              ),
              items: [
                DropdownMenuItem(value: 'Individual', child: Text(AppLocalizations.of(context)!.individuals)),
                DropdownMenuItem(value: 'Small Business', child: Text(AppLocalizations.of(context)!.smallBusiness)),
                DropdownMenuItem(value: 'Enterprise', child: Text(AppLocalizations.of(context)!.enterprise)),
                DropdownMenuItem(value: 'Government', child: Text(AppLocalizations.of(context)!.government)),
              ],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return AppLocalizations.of(context)!.selectTargetAudienceValidation;
                }
                return null;
              },
            ),
            const SizedBox(height: AppConstants.paddingM),

            FormBuilderField<String>(
              name: 'iconUrl',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return AppLocalizations.of(context)!.uploadIconValidation;
                }
                return null;
              },
              builder: (field) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.appIconLabel,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Container(
                          width: 72,
                          height: 72,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(AppConstants.borderRadiusS),
                            color: AppConstants.primaryGreen.withOpacity(0.1),
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: _uploadedIconUrl != null
                              ? Image.network(_uploadedIconUrl!, fit: BoxFit.cover)
                              : const Icon(Icons.apps, color: AppConstants.primaryGreen),
                        ),
                        const SizedBox(width: AppConstants.paddingM),
                        ElevatedButton.icon(
                          onPressed: _isUploadingIcon ? null : () => _pickAndUploadIcon(field),
                          icon: _isUploadingIcon
                              ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2, valueColor: AlwaysStoppedAnimation<Color>(Colors.white)))
                              : const Icon(Icons.upload_file),
                          label: Text(_uploadedIconUrl == null ? AppLocalizations.of(context)!.uploadIcon : AppLocalizations.of(context)!.replace),
                          style: ElevatedButton.styleFrom(backgroundColor: AppConstants.teal),
                        ),
                      ],
                    ),
                    if (field.hasError)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(field.errorText!, style: const TextStyle(color: Colors.red)),
                      ),
                  ],
                );
              },
            ),
            const SizedBox(height: AppConstants.paddingM),

            FormBuilderField<List<String>>(
              name: 'screenshots',
              validator: (value) {
                if (_uploadedScreenshotUrls.isEmpty) {
                  return AppLocalizations.of(context)!.screenshotsRequired;
                }
                return null;
              },
              builder: (field) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.screenshotsLabel,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 8),

                    // Upload button
                    ElevatedButton.icon(
                      onPressed: _isUploadingScreenshots ? null : () => _pickAndUploadScreenshots(field),
                      icon: _isUploadingScreenshots
                          ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2, valueColor: AlwaysStoppedAnimation<Color>(Colors.white)))
                          : const Icon(Icons.add_photo_alternate),
                      label: Text(_uploadedScreenshotUrls.isEmpty ? AppLocalizations.of(context)!.addScreenshots : AppLocalizations.of(context)!.addMoreScreenshots),
                      style: ElevatedButton.styleFrom(backgroundColor: AppConstants.teal),
                    ),

                    const SizedBox(height: 12),

                    // Display uploaded screenshots
                    if (_uploadedScreenshotUrls.isNotEmpty) ...[
                      Text(
                        AppLocalizations.of(context)!.screenshotsUploadedStatus(_uploadedScreenshotUrls.length),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.green),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        height: 100,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _uploadedScreenshotUrls.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.only(right: 8),
                              child: Stack(
                                children: [
                                  Container(
                                    width: 80,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(AppConstants.borderRadiusS),
                                      border: Border.all(color: Colors.grey.shade300),
                                    ),
                                    clipBehavior: Clip.antiAlias,
                                    child: Image.network(
                                      _uploadedScreenshotUrls[index],
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) => Container(
                                        color: Colors.grey.shade200,
                                        child: const Icon(Icons.image, color: Colors.grey),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 4,
                                    right: 4,
                                    child: GestureDetector(
                                      onTap: () => _removeScreenshot(index, field),
                                      child: Container(
                                        width: 20,
                                        height: 20,
                                        decoration: const BoxDecoration(
                                          color: Colors.red,
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(
                                          Icons.close,
                                          size: 14,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],

                    if (field.hasError)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(field.errorText!, style: const TextStyle(color: Colors.red)),
                      ),
                  ],
                );
              },
            ),
            const SizedBox(height: AppConstants.paddingM),

            FormBuilderTextField(
              name: 'subcategory',
              decoration: const InputDecoration(
                labelText: 'Sous-catégorie *',
                hintText: 'Ex: CRM, Comptabilité, etc.',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'La sous-catégorie est requise';
                }
                return null;
              },
            ),
            const SizedBox(height: AppConstants.paddingM),

            FormBuilderTextField(
              name: 'tags',
              decoration: const InputDecoration(
                labelText: 'Tags *',
                hintText: 'Séparez les tags par des virgules (ex: gestion, client, vente)',
              ),
              maxLines: 2,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Au moins un tag est requis';
                }
                return null;
              },
            ),
          ],
      ),
    );
  }

  Widget _buildTechnicalDetailsStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppConstants.paddingM),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.stepTechnicalDetails,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: AppConstants.paddingL),

          FormBuilderDropdown<AppType>(
            name: 'appType',
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context)!.appTypeLabel,
            ),
            items: AppType.values
                .map((type) => DropdownMenuItem(
                      value: type,
                      child: Text(_getAppTypeLabel(type)),
                    ))
                .toList(),
          ),
          const SizedBox(height: AppConstants.paddingM),

          FormBuilderCheckboxGroup<Platform>(
            name: 'platforms',
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context)!.platformsLabel,
            ),
            options: Platform.values
                .map((platform) => FormBuilderFieldOption(
                      value: platform,
                      child: Text(_getPlatformLabel(platform)),
                    ))
                .toList(),
          ),
          const SizedBox(height: AppConstants.paddingM),

          FormBuilderTextField(
            name: 'currentVersion',
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context)!.versionLabel,
              hintText: AppLocalizations.of(context)!.versionHint,
            ),
            initialValue: '1.0.0',
          ),
          const SizedBox(height: AppConstants.paddingM),

          FormBuilderTextField(
            name: 'technicalRequirements',
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context)!.systemRequirementsLabel,
              hintText: AppLocalizations.of(context)!.systemRequirementsHint,
            ),
            maxLines: 2,
          ),
        ],
      ),
    );
  }

  Widget _buildPricingStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppConstants.paddingM),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.stepPricing,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: AppConstants.paddingL),

          FormBuilderDropdown<PricingModel>(
            name: 'pricingModel',
            decoration: const InputDecoration(
              labelText: 'Modèle de tarification *',
            ),
            items: PricingModel.values
                .map((model) => DropdownMenuItem(
                      value: model,
                      child: Text(_getPricingModelLabel(model)),
                    ))
                .toList(),
          ),
          const SizedBox(height: AppConstants.paddingM),

          FormBuilderTextField(
            name: 'pricing',
            decoration: const InputDecoration(
              labelText: 'Prix *',
              hintText: 'Ex: 500 MRU/mois, Gratuit, Sur devis',
            ),
          ),
          const SizedBox(height: AppConstants.paddingM),

          FormBuilderCheckbox(
            name: 'hasFreeTrial',
            title: const Text('Offre un essai gratuit'),
          ),
          const SizedBox(height: AppConstants.paddingM),

          FormBuilderTextField(
            name: 'trialDays',
            decoration: const InputDecoration(
              labelText: 'Durée de l\'essai (jours)',
              hintText: 'Ex: 14',
            ),
            keyboardType: TextInputType.number,
          ),
        ],
      ),
    );
  }

  Widget _buildBusinessDetailsStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppConstants.paddingM),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.stepBusinessDetails,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: AppConstants.paddingL),

          FormBuilderTextField(
            name: 'businessValue',
            decoration: const InputDecoration(
              labelText: 'Valeur commerciale *',
              hintText: 'Ex: Améliore la gestion client et augmente les ventes de 30%',
            ),
            maxLines: 2,
          ),
          const SizedBox(height: AppConstants.paddingM),

          FormBuilderTextField(
            name: 'keyFeatures',
            decoration: const InputDecoration(
              labelText: 'Fonctionnalités clés *',
              hintText: 'Séparez les fonctionnalités par des virgules',
            ),
            maxLines: 3,
          ),
          const SizedBox(height: AppConstants.paddingM),

          FormBuilderCheckboxGroup<String>(
            name: 'businessSectors',
            decoration: const InputDecoration(
              labelText: 'Secteurs d\'activité ciblés',
            ),
            options: const [
              FormBuilderFieldOption(value: 'Commerce', child: Text('Commerce')),
              FormBuilderFieldOption(value: 'Services', child: Text('Services')),
              FormBuilderFieldOption(value: 'Industrie', child: Text('Industrie')),
              FormBuilderFieldOption(value: 'Santé', child: Text('Santé')),
              FormBuilderFieldOption(value: 'Éducation', child: Text('Éducation')),
              FormBuilderFieldOption(value: 'Agriculture', child: Text('Agriculture')),
            ],
          ),
          const SizedBox(height: AppConstants.paddingM),

          FormBuilderCheckboxGroup<SupportType>(
            name: 'supportOptions',
            decoration: const InputDecoration(
              labelText: 'Options de support offertes',
            ),
            options: SupportType.values
                .map((type) => FormBuilderFieldOption(
                      value: type,
                      child: Text(_getSupportTypeLabel(type)),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }



  Widget _buildNavigationButtons() {
    return Container(
      padding: const EdgeInsets.all(AppConstants.paddingM),
      decoration: BoxDecoration(
        color: AppConstants.surfaceColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          if (_currentStep > 0)
            Expanded(
              child: OutlinedButton(
                onPressed: _previousStep,
                child: Text(AppLocalizations.of(context)!.previous),
              ),
            ),
          if (_currentStep > 0) const SizedBox(width: AppConstants.paddingM),
          Expanded(
            child: ElevatedButton(
              onPressed: _isSubmitting
                  ? null
                  : (_currentStep < _totalSteps - 1 ? _nextStep : _submitForm),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppConstants.teal,
              ),
              child: _isSubmitting
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : Text(
                      _currentStep < _totalSteps - 1 ? AppLocalizations.of(context)!.next : AppLocalizations.of(context)!.publishApplication,
                    ),
            ),
          ),
        ],
      ),
    );
  }

  void _nextStep() {
    log('next step ');
    if (_validateCurrentStep()) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
    
  }

  void _previousStep() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  bool _validateCurrentStep() {




    log('formket currentState ${_formKey.currentState}');
    if (_formKey.currentState == null) return false;



    log('current state ');
    // Save and validate the form first to populate values
    if (!_formKey.currentState!.saveAndValidate()) {
      return false;
    }

    // Get current form values (now they should be populated)
    final formData = _formKey.currentState!.value;
    log('Form data after saveAndValidate: $formData');

    switch (_currentStep) {
      case 0: // Basic Info
        return _validateBasicInfo(formData);
      case 1: // Technical Details
        return _validateTechnicalDetails(formData);
      case 2: // Pricing
        return _validatePricing(formData);
      case 3: // Business Details
        return _validateBusinessDetails(formData);
      default:
        return true;
    }
  }

  bool _validateBasicInfo(Map<String, dynamic> formData) {
    log('Validating basic info step formData: $formData');
    final appName = formData['appName']?.toString().trim();
    final tagline = formData['tagline']?.toString().trim();
    final description = formData['description']?.toString().trim();
    final category = formData['category'];
    final targetAudience = formData['targetAudience'];
    final iconUrl = formData['iconUrl']?.toString().trim();
    final subcategory = formData['subcategory']?.toString().trim();
    final tags = formData['tags']?.toString().trim();

    if (appName == null || appName.isEmpty) {
      _showValidationError(AppLocalizations.of(context)!.validationAppNameRequired);
      return false;
    }
    if (tagline == null || tagline.isEmpty) {
      _showValidationError(AppLocalizations.of(context)!.validationTaglineRequired);
      return false;
    }
    if (description == null || description.isEmpty) {
      _showValidationError(AppLocalizations.of(context)!.validationDescriptionRequired);
      return false;
    }
    if (category == null || category.toString().isEmpty) {
      _showValidationError(AppLocalizations.of(context)!.validationCategoryRequired);
      return false;
    }
    // Validate that the category ID is valid
    final categoryId = int.tryParse(category.toString());
    if (categoryId == null || categoryId <= 0) {
      _showValidationError(AppLocalizations.of(context)!.validationInvalidCategory);
      return false;
    }
    if (targetAudience == null || targetAudience.toString().isEmpty) {
      _showValidationError(AppLocalizations.of(context)!.validationTargetAudienceRequired);
      return false;
    }
    if (iconUrl == null || iconUrl.isEmpty) {
      _showValidationError(AppLocalizations.of(context)!.validationIconRequired);
      return false;
    }
    if (_uploadedScreenshotUrls.isEmpty) {
      _showValidationError(AppLocalizations.of(context)!.validationScreenshotsRequired);
      return false;
    }
    if (subcategory == null || subcategory.isEmpty) {
      _showValidationError(AppLocalizations.of(context)!.validationSubcategoryRequired);
      return false;
    }
    if (tags == null || tags.isEmpty) {
      _showValidationError(AppLocalizations.of(context)!.validationTagsRequired);
      return false;
    }
    return true;
  }


  bool _validateTechnicalDetails(Map<String, dynamic> formData) {

    log('formdata ${formData}');
    final appType = formData['appType'];
    final platforms = formData['platforms'] as List?;
    final version = formData['currentVersion']?.toString().trim();

    if (appType == null || appType.toString().isEmpty) {
      _showValidationError(AppLocalizations.of(context)!.validationAppTypeRequired);
      return false;
    }
    if (platforms == null || platforms.isEmpty) {
      _showValidationError(AppLocalizations.of(context)!.validationPlatformsRequired);
      return false;
    }
    if (version == null || version.isEmpty) {
      _showValidationError(AppLocalizations.of(context)!.validationVersionRequired);
      return false;
    }
    return true;
  }

  bool _validatePricing(Map<String, dynamic> formData) {
    final licenseType = formData['pricingModel'];
    final pricingModel = formData['pricingModel'];

    if (licenseType == null || licenseType.toString().isEmpty) {
      _showValidationError(AppLocalizations.of(context)!.validationLicenseTypeRequired);
      return false;
    }
    if (pricingModel == null || pricingModel.toString().isEmpty) {
      _showValidationError(AppLocalizations.of(context)!.validationPricingModelRequired);
      return false;
    }
    return true;
  }

  bool _validateBusinessDetails(Map<String, dynamic> formData) {
    final businessValue = formData['businessValue']?.toString().trim();
    final keyFeatures = formData['keyFeatures']?.toString().trim();

    if (businessValue == null || businessValue.isEmpty) {
      _showValidationError(AppLocalizations.of(context)!.validationBusinessValueRequired);
      return false;
    }
    if (keyFeatures == null || keyFeatures.isEmpty) {
      _showValidationError(AppLocalizations.of(context)!.validationKeyFeaturesRequired);
      return false;
    }
    return true;
  }

  void _showValidationError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }



  bool _isSubmitting = false;

  Future<void> _submitForm() async {
    if (!(_formKey.currentState?.saveAndValidate() ?? false)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.pleaseFixFormErrors),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() => _isSubmitting = true);

    try {
      final formData = _formKey.currentState!.value;
      log('error while submitting app data $formData');

      // Helper function to convert enum to string
      String enumToString(dynamic enumValue) {
        if (enumValue == null) return '';
        return enumValue.toString().split('.').last;
      }

      // Helper function to convert list of enums to list of strings
      List<String> enumListToStringList(List<dynamic>? enumList) {
        if (enumList == null) return [];
        return enumList.map((e) => enumToString(e)).toList();
      }

      // Helper function to parse key features
      List<String> parseKeyFeatures(dynamic keyFeatures) {
        if (keyFeatures == null) return [];
        if (keyFeatures is List) return keyFeatures.map((e) => e.toString()).toList();
        if (keyFeatures is String) {
          return keyFeatures.split(',').map((e) => e.trim()).where((e) => e.isNotEmpty).toList();
        }
        return [keyFeatures.toString()];
      }

      // Prepare app data for API (map form field names to API field names)
      final appTypeString = enumToString(formData['appType']);
      final pricingModelString = enumToString(formData['pricingModel']);

      // Helper function to parse tags
      List<String> parseTags(String? tags) {
        if (tags == null || tags.isEmpty) return [];
        return tags.split(',').map((e) => e.trim()).where((e) => e.isNotEmpty).toList();
      }

      final appData = {
        'app_name': formData['appName'] ?? '',
        'tagline': formData['tagline'] ?? '',
        'description': formData['description'] ?? '',
        'detailed_description': formData['detailedDescription'] ?? formData['description'],
        'category_id': int.tryParse(formData['category']?.toString() ?? '0') ?? 0,
        'subcategory': formData['subcategory'] ?? '',
        'tags': parseTags(formData['tags']),
        'app_type': appTypeString.isNotEmpty ? appTypeString : 'mobile',
        'supported_platforms': enumListToStringList(formData['platforms'] as List<dynamic>?),
        'current_version': formData['currentVersion'] ?? '1.0.0',
        'icon_url': formData['iconUrl'] ?? '',
        'screenshots': _uploadedScreenshotUrls,
        'demo_videos': formData['demoVideos'],
        'live_demo': formData['liveDemo'],
        'download_link': formData['downloadLink'],
        'license_type': pricingModelString.isNotEmpty ? pricingModelString : 'free',
        'pricing_model': pricingModelString.isNotEmpty ? pricingModelString : 'free',
        'pricing': formData['pricing']?.toString() ?? '0',
        'has_free_trial': formData['hasFreeTrial'] ?? false,
        'trial_days': int.tryParse(formData['trialDays']?.toString() ?? '0') ?? 0,
        'is_open_source': formData['isOpenSource'] ?? false,
        'target_audience': formData['targetAudience'] ?? '',
        'business_sectors': formData['businessSectors'] ?? [],
        'business_value': formData['businessValue'] ?? '',
        'key_features': parseKeyFeatures(formData['keyFeatures']),
        'technical_requirements': formData['technicalRequirements'],
        'has_documentation': formData['hasDocumentation'] ?? false,
        'documentation_url': formData['documentationUrl'],
        'support_options': enumListToStringList(formData['supportOptions'] as List<dynamic>?),
        'languages': formData['languages'] ?? ['Français'],
      };



      log('app data $appData');
      // Submit to API
      await AppService.createApp(appData);

      if (mounted) {
        // Show success dialog
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
            title: Text(AppLocalizations.of(context)!.appPublishedTitle),
            content: Text(
              AppLocalizations.of(context)!.appPublishedContent,
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close dialog
                  Navigator.of(context).pop(true); // Return to previous screen with success
                },
                child: Text(AppLocalizations.of(context)!.ok),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      log('error $e');

      if (mounted) {
        // Check if it's a subscription-related error
        final errorString = e.toString().toLowerCase();
        if (errorString.contains('subscription') ||
            errorString.contains('abonnement') ||
            errorString.contains('subscription_required')) {
          _showSubscriptionRequiredDialog();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(AppLocalizations.of(context)!.errorPublishing(e.toString())),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }

  String _getStepTitle(int step) {
    switch (step) {
      case 0: return AppLocalizations.of(context)!.stepBasicInfo;
      case 1: return AppLocalizations.of(context)!.stepTechnicalDetails;
      case 2: return AppLocalizations.of(context)!.stepPricing;
      case 3: return AppLocalizations.of(context)!.stepBusinessDetails;
      default: return '';
    }
  }

  String _getAppTypeLabel(AppType type) {
    switch (type) {
      case AppType.mobile: return AppLocalizations.of(context)!.appTypeMobile;
      case AppType.web: return AppLocalizations.of(context)!.appTypeWeb;
      case AppType.desktop: return AppLocalizations.of(context)!.appTypeDesktop;
      case AppType.saas: return AppLocalizations.of(context)!.appTypeSaas;
      case AppType.api: return AppLocalizations.of(context)!.appTypeApi;
      case AppType.plugin: return AppLocalizations.of(context)!.appTypePlugin;
      case AppType.template: return AppLocalizations.of(context)!.appTypeTemplate;
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

  String _getPricingModelLabel(PricingModel model) {
    switch (model) {
      case PricingModel.free: return AppLocalizations.of(context)!.pricingModelFree;
      case PricingModel.freemium: return AppLocalizations.of(context)!.pricingModelFreemium;
      case PricingModel.paid: return AppLocalizations.of(context)!.pricingModelPaid;
      case PricingModel.enterprise: return AppLocalizations.of(context)!.pricingModelEnterprise;
      case PricingModel.custom: return AppLocalizations.of(context)!.pricingModelCustom;
    }
  }

  String _getSupportTypeLabel(SupportType type) {
    switch (type) {
      case SupportType.email: return AppLocalizations.of(context)!.supportTypeEmail;
      case SupportType.phone: return AppLocalizations.of(context)!.supportTypePhone;
      case SupportType.chat: return AppLocalizations.of(context)!.supportTypeChat;
      case SupportType.training: return AppLocalizations.of(context)!.supportTypeTraining;
      case SupportType.documentation: return AppLocalizations.of(context)!.supportTypeDocumentation;
    }
  }
}
