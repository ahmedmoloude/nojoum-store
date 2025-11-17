import 'package:flutter/material.dart';
import '../services/language_service.dart';
import '../l10n/app_localizations.dart';
import '../utils/constants.dart';

class LanguageSwitcher extends StatelessWidget {
  final bool showTitle;
  final bool isCompact;
  
  const LanguageSwitcher({
    super.key,
    this.showTitle = true,
    this.isCompact = false,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final languageService = LanguageService.instance;
    
    if (isCompact) {
      return _buildCompactSwitcher(context, l10n, languageService);
    }
    
    return _buildFullSwitcher(context, l10n, languageService);
  }
  
  Widget _buildCompactSwitcher(BuildContext context, AppLocalizations l10n, LanguageService languageService) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.language),
      tooltip: l10n.language,
      onSelected: (String languageCode) {
        languageService.changeLanguage(languageCode);
      },
      itemBuilder: (BuildContext context) {
        return languageService.getAvailableLanguages().entries.map((entry) {
          final isSelected = entry.key == languageService.currentLanguageCode;
          return PopupMenuItem<String>(
            value: entry.key,
            child: Row(
              children: [
                if (isSelected) 
                  const Icon(Icons.check, color: AppConstants.primaryBlue, size: 20)
                else 
                  const SizedBox(width: 20),
                const SizedBox(width: 8),
                Text(
                  entry.value,
                  style: TextStyle(
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    color: isSelected ? AppConstants.primaryBlue : null,
                  ),
                ),
              ],
            ),
          );
        }).toList();
      },
    );
  }
  
  Widget _buildFullSwitcher(BuildContext context, AppLocalizations l10n, LanguageService languageService) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showTitle) ...[
          Text(
            l10n.language,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppConstants.paddingM),
        ],
        
        ...languageService.getAvailableLanguages().entries.map((entry) {
          final isSelected = entry.key == languageService.currentLanguageCode;
          
          return Card(
            margin: const EdgeInsets.only(bottom: AppConstants.paddingS),
            child: ListTile(
              leading: Icon(
                Icons.language,
                color: isSelected ? AppConstants.primaryBlue : AppConstants.secondaryTextColor,
              ),
              title: Text(
                entry.value,
                style: TextStyle(
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected ? AppConstants.primaryBlue : null,
                ),
              ),
              trailing: isSelected 
                ? const Icon(Icons.check, color: AppConstants.primaryBlue)
                : null,
              onTap: () {
                if (!isSelected) {
                  languageService.changeLanguage(entry.key);
                }
              },
            ),
          );
        }).toList(),
      ],
    );
  }
}

class LanguageSelectionScreen extends StatelessWidget {
  const LanguageSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.language),
        backgroundColor: AppConstants.primaryBlue,
        foregroundColor: Colors.white,
      ),
      body: const Padding(
        padding: EdgeInsets.all(AppConstants.paddingL),
        child: LanguageSwitcher(showTitle: false),
      ),
    );
  }
}

class LanguageBottomSheet extends StatelessWidget {
  const LanguageBottomSheet({super.key});

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => const LanguageBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return Container(
      padding: const EdgeInsets.all(AppConstants.paddingL),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.only(bottom: AppConstants.paddingL),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          
          Text(
            l10n.language,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          
          const SizedBox(height: AppConstants.paddingL),
          
          const LanguageSwitcher(showTitle: false),
          
          const SizedBox(height: AppConstants.paddingL),
        ],
      ),
    );
  }
}
