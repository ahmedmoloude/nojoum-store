import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import '../models/mauritanian_app.dart';
import '../models/app_category.dart';
import '../utils/constants.dart';

/// Multi-step app publishing screen for developers
class PublishAppScreen extends StatefulWidget {
  const PublishAppScreen({super.key});

  @override
  State<PublishAppScreen> createState() => _PublishAppScreenState();
}

class _PublishAppScreenState extends State<PublishAppScreen> {
  final PageController _pageController = PageController();
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  int _currentStep = 0;
  final int _totalSteps = 5;

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
                _buildContactLegalStep(),
              ],
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
      child: FormBuilder(
        key: _formKey,
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
          ],
        ),
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

  Widget _buildContactLegalStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppConstants.paddingM),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Contact et informations légales',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: AppConstants.paddingL),
          
          FormBuilderTextField(
            name: 'developerName',
            decoration: const InputDecoration(
              labelText: 'Nom du développeur *',
            ),
          ),
          const SizedBox(height: AppConstants.paddingM),
          
          FormBuilderTextField(
            name: 'companyName',
            decoration: const InputDecoration(
              labelText: 'Nom de l\'entreprise',
              hintText: 'Optionnel si développeur individuel',
            ),
          ),
          const SizedBox(height: AppConstants.paddingM),
          
          FormBuilderTextField(
            name: 'developerEmail',
            decoration: const InputDecoration(
              labelText: 'Email de contact *',
            ),
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: AppConstants.paddingM),
          
          FormBuilderTextField(
            name: 'developerPhone',
            decoration: const InputDecoration(
              labelText: 'Téléphone *',
              hintText: '+222 XX XX XX XX',
            ),
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: AppConstants.paddingM),
          
          FormBuilderTextField(
            name: 'developerWebsite',
            decoration: const InputDecoration(
              labelText: 'Site web',
              hintText: 'https://monsite.mr',
            ),
            keyboardType: TextInputType.url,
          ),
          const SizedBox(height: AppConstants.paddingL),
          
          FormBuilderCheckbox(
            name: 'acceptTerms',
            title: const Text('J\'accepte les conditions d\'utilisation'),
            validator: (value) {
              if (value != true) {
                return 'Vous devez accepter les conditions';
              }
              return null;
            },
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
              onPressed: _currentStep < _totalSteps - 1 ? _nextStep : _submitForm,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppConstants.teal,
              ),
              child: Text(
                _currentStep < _totalSteps - 1 ? 'Suivant' : 'Publier l\'application',
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _nextStep() {
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
    // Add validation logic for each step
    return true;
  }

  void _submitForm() {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      final formData = _formKey.currentState!.value;
      
      // Show success dialog
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Application soumise !'),
          content: const Text(
            'Votre application a été soumise avec succès. '
            'Notre équipe va l\'examiner et vous contactera sous 48h.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  String _getStepTitle(int step) {
    switch (step) {
      case 0: return 'Informations de base';
      case 1: return 'Détails techniques';
      case 2: return 'Tarification et licence';
      case 3: return 'Détails commerciaux';
      case 4: return 'Contact et informations légales';
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
