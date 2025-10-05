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
import '../utils/constants.dart';
import 'auth/login_screen.dart';

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
        _uploadedIconUrl = url;
      });
      field.didChange(url);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Icône téléchargée avec succès')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Échec du téléchargement: $e'), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) setState(() => _isUploadingIcon = false);
    }
  }

  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  int _currentStep = 0;
  final int _totalSteps = 4;

  @override
  void initState() {
    super.initState();
    _checkAuthentication();
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
        title: const Text('Connexion requise'),
        content: const Text(
          'Vous devez être connecté pour publier une application. '
          'Souhaitez-vous vous connecter maintenant ?',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop(); // Go back to previous screen
            },
            child: const Text('Annuler'),
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
            child: const Text('Se connecter'),
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
        title: const Text('Publier une application'),
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
            'Étape ${_currentStep + 1} sur $_totalSteps',
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
              'Informations de base',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: AppConstants.paddingL),

            FormBuilderTextField(
              name: 'appName',
              decoration: const InputDecoration(
                labelText: 'Nom de l\'application *',
                hintText: 'Ex: MauriCRM Pro',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Le nom de l\'application est requis';
                }
                return null;
              },
            ),
            const SizedBox(height: AppConstants.paddingM),

            FormBuilderTextField(
              name: 'tagline',
              decoration: const InputDecoration(
                labelText: 'Slogan *',
                hintText: 'Ex: Système de gestion client professionnel',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Le slogan est requis';
                }
                return null;
              },
            ),
            const SizedBox(height: AppConstants.paddingM),

            FormBuilderTextField(
              name: 'description',
              decoration: const InputDecoration(
                labelText: 'Description courte *',
                hintText: 'Décrivez brièvement votre application...',
              ),
              maxLines: 3,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'La description est requise';
                }
                return null;
              },
            ),
            const SizedBox(height: AppConstants.paddingM),

            FormBuilderDropdown<String>(
              name: 'category',
              decoration: const InputDecoration(
                labelText: 'Catégorie principale *',
              ),
              items: AppCategories.all
                  .map((category) => DropdownMenuItem(
                        value: category.id,
                        child: Text(category.name),
                      ))
                  .toList(),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez sélectionner une catégorie';
                }
                return null;
              },
            ),
            const SizedBox(height: AppConstants.paddingM),

            FormBuilderDropdown<String>(
              name: 'targetAudience',
              decoration: const InputDecoration(
                labelText: 'Public cible *',
              ),
              items: const [
                DropdownMenuItem(value: 'Individual', child: Text('Particuliers')),
                DropdownMenuItem(value: 'Small Business', child: Text('Petites entreprises')),
                DropdownMenuItem(value: 'Enterprise', child: Text('Grandes entreprises')),
                DropdownMenuItem(value: 'Government', child: Text('Gouvernement')),
              ],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez sélectionner le public cible';
                }
                return null;
              },
            ),
            const SizedBox(height: AppConstants.paddingM),

            FormBuilderField<String>(
              name: 'iconUrl',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez télécharger l\'icône de l\'application';
                }
                return null;
              },
              builder: (field) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Icône de l\'application *',
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
                          label: Text(_uploadedIconUrl == null ? 'Télécharger une icône' : 'Remplacer'),
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

            FormBuilderTextField(
              name: 'screenshots',
              decoration: const InputDecoration(
                labelText: 'URLs des captures d\'écran *',
                hintText: 'Séparez les URLs par des virgules',
              ),
              maxLines: 3,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Au moins une capture d\'écran est requise';
                }
                return null;
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
            'Détails techniques',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: AppConstants.paddingL),

          FormBuilderDropdown<AppType>(
            name: 'appType',
            decoration: const InputDecoration(
              labelText: 'Type d\'application *',
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
            decoration: const InputDecoration(
              labelText: 'Plateformes supportées *',
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
            decoration: const InputDecoration(
              labelText: 'Version actuelle',
              hintText: 'Ex: 1.0.0',
            ),
            initialValue: '1.0.0',
          ),
          const SizedBox(height: AppConstants.paddingM),

          FormBuilderTextField(
            name: 'technicalRequirements',
            decoration: const InputDecoration(
              labelText: 'Exigences techniques',
              hintText: 'Ex: Android 8.0+, 2GB RAM minimum',
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
            'Tarification et licence',
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
            'Détails commerciaux',
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
                child: const Text('Précédent'),
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
                      _currentStep < _totalSteps - 1 ? 'Suivant' : 'Publier l\'application',
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
    final screenshots = formData['screenshots']?.toString().trim();
    final subcategory = formData['subcategory']?.toString().trim();
    final tags = formData['tags']?.toString().trim();

    if (appName == null || appName.isEmpty) {
      _showValidationError('Veuillez saisir le nom de l\'application');
      return false;
    }
    if (tagline == null || tagline.isEmpty) {
      _showValidationError('Veuillez saisir le slogan de l\'application');
      return false;
    }
    if (description == null || description.isEmpty) {
      _showValidationError('Veuillez saisir la description de l\'application');
      return false;
    }
    if (category == null || category.toString().isEmpty) {
      _showValidationError('Veuillez sélectionner une catégorie');
      return false;
    }
    if (targetAudience == null || targetAudience.toString().isEmpty) {
      _showValidationError('Veuillez sélectionner le public cible');
      return false;
    }
    if (iconUrl == null || iconUrl.isEmpty) {
      _showValidationError('Veuillez saisir l\'URL de l\'icône');
      return false;
    }
    if (screenshots == null || screenshots.isEmpty) {
      _showValidationError('Veuillez ajouter au moins une capture d\'écran');
      return false;
    }
    if (subcategory == null || subcategory.isEmpty) {
      _showValidationError('Veuillez saisir la sous-catégorie');
      return false;
    }
    if (tags == null || tags.isEmpty) {
      _showValidationError('Veuillez ajouter au moins un tag');
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
      _showValidationError('Veuillez sélectionner le type d\'application');
      return false;
    }
    if (platforms == null || platforms.isEmpty) {
      _showValidationError('Veuillez sélectionner au moins une plateforme');
      return false;
    }
    if (version == null || version.isEmpty) {
      _showValidationError('Veuillez saisir la version de l\'application');
      return false;
    }
    return true;
  }

  bool _validatePricing(Map<String, dynamic> formData) {
    final licenseType = formData['pricingModel'];
    final pricingModel = formData['pricingModel'];

    if (licenseType == null || licenseType.toString().isEmpty) {
      _showValidationError('Veuillez sélectionner le type de licence');
      return false;
    }
    if (pricingModel == null || pricingModel.toString().isEmpty) {
      _showValidationError('Veuillez sélectionner le modèle de tarification');
      return false;
    }
    return true;
  }

  bool _validateBusinessDetails(Map<String, dynamic> formData) {
    final businessValue = formData['businessValue']?.toString().trim();
    final keyFeatures = formData['keyFeatures']?.toString().trim();

    if (businessValue == null || businessValue.isEmpty) {
      _showValidationError('Veuillez saisir la valeur commerciale');
      return false;
    }
    if (keyFeatures == null || keyFeatures.isEmpty) {
      _showValidationError('Veuillez ajouter au moins une fonctionnalité clé');
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

  // Helper method to convert category name to category ID
  int? _getCategoryId(String? categoryName) {
    if (categoryName == null) return null;

    // Map category names to IDs (you may need to adjust these based on your actual categories)
    final categoryMap = {
      'entertainment': 1,
      'productivity': 2,
      'education': 3,
      'business': 4,
      'health': 5,
      'finance': 6,
      'social': 7,
      'utilities': 8,
      'games': 9,
      'news': 10,
    };

    return categoryMap[categoryName.toLowerCase()];
  }

  bool _isSubmitting = false;

  Future<void> _submitForm() async {
    if (!(_formKey.currentState?.saveAndValidate() ?? false)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Veuillez corriger les erreurs dans le formulaire'),
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

      // Helper function to parse screenshots URLs
      List<String> parseScreenshots(String? screenshots) {
        if (screenshots == null || screenshots.isEmpty) return [];
        return screenshots.split(',').map((e) => e.trim()).where((e) => e.isNotEmpty).toList();
      }

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
        'category_id': _getCategoryId(formData['category']),
        'subcategory': formData['subcategory'] ?? '',
        'tags': parseTags(formData['tags']),
        'app_type': appTypeString.isNotEmpty ? appTypeString : 'mobile',
        'supported_platforms': enumListToStringList(formData['platforms'] as List<dynamic>?),
        'current_version': formData['currentVersion'] ?? '1.0.0',
        'icon_url': formData['iconUrl'] ?? '',
        'screenshots': parseScreenshots(formData['screenshots']),
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
            title: const Text('Application publiée !'),
            content: const Text(
              'Votre application a été publiée avec succès. '
              'Elle sera visible dans le marketplace après validation par notre équipe.',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close dialog
                  Navigator.of(context).pop(true); // Return to previous screen with success
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    } catch (e) {

      log('error $e');
            if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erreur lors de la publication: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }

  String _getStepTitle(int step) {
    switch (step) {
      case 0: return 'Informations de base';
      case 1: return 'Détails techniques';
      case 2: return 'Tarification et licence';
      case 3: return 'Détails commerciaux';
      default: return '';
    }
  }

  String _getAppTypeLabel(AppType type) {
    switch (type) {
      case AppType.mobile: return 'Application mobile';
      case AppType.web: return 'Application web';
      case AppType.desktop: return 'Application desktop';
      case AppType.saas: return 'SaaS / Cloud';
      case AppType.api: return 'API / Service';
      case AppType.plugin: return 'Plugin / Extension';
      case AppType.template: return 'Template / Modèle';
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
      case PricingModel.free: return 'Gratuit';
      case PricingModel.freemium: return 'Freemium';
      case PricingModel.paid: return 'Payant';
      case PricingModel.enterprise: return 'Enterprise';
      case PricingModel.custom: return 'Sur mesure';
    }
  }

  String _getSupportTypeLabel(SupportType type) {
    switch (type) {
      case SupportType.email: return 'Email';
      case SupportType.phone: return 'Téléphone';
      case SupportType.chat: return 'Chat en ligne';
      case SupportType.training: return 'Formation';
      case SupportType.documentation: return 'Documentation';
    }
  }
}
