import 'package:flutter/material.dart';
import '../models/app_category.dart';
import '../utils/constants.dart';

/// Reusable chip widget for displaying application categories
class CategoryChip extends StatelessWidget {
  final AppCategory category;
  final VoidCallback? onTap;
  final bool isSelected;
  final bool showCount;
  final int? appCount;

  const CategoryChip({
    super.key,
    required this.category,
    this.onTap,
    this.isSelected = false,
    this.showCount = false,
    this.appCount,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: isSelected ? AppConstants.elevationM : AppConstants.elevationS,
      color: isSelected ? category.color.withOpacity(0.1) : AppConstants.cardColor,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusM),
        child: Container(
          padding: const EdgeInsets.all(AppConstants.paddingS), // Reduced padding
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min, // Added to minimize space usage
            children: [
              // Category icon - made more compact
              Container(
                padding: const EdgeInsets.all(AppConstants.paddingXS), // Reduced padding
                decoration: BoxDecoration(
                  color: isSelected 
                      ? category.color 
                      : category.color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppConstants.borderRadiusM), // Reduced radius
                ),
                child: Icon(
                  category.icon,
                  size: AppConstants.iconSizeM, // Reduced icon size
                  color: isSelected 
                      ? AppConstants.whiteTextColor 
                      : category.color,
                ),
              ),
              const SizedBox(height: AppConstants.paddingXS), // Reduced spacing

              // Category name - FIXED OVERFLOW ISSUE
              Expanded(
                child: Center(
                  child: Text(
                    category.name,
                    style: theme.textTheme.labelSmall?.copyWith( // Smaller text
                      fontWeight: FontWeight.w600,
                      color: isSelected 
                          ? category.color 
                          : AppConstants.primaryTextColor,
                      fontSize: 11, // Explicit smaller font size
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),

              // App count (if enabled) - made more compact
              if (showCount && appCount != null) ...[
                const SizedBox(height: 1), // Minimal spacing
                Text(
                  '$appCount app${appCount! > 1 ? 's' : ''}',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: AppConstants.secondaryTextColor,
                    fontSize: 9, // Very small font for count
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// Horizontal scrollable category chips for filtering
class CategoryFilterChips extends StatelessWidget {
  final List<AppCategory> categories;
  final String? selectedCategoryId;
  final Function(String?) onCategorySelected;
  final bool showAllOption;

  const CategoryFilterChips({
    super.key,
    required this.categories,
    this.selectedCategoryId,
    required this.onCategorySelected,
    this.showAllOption = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      height: 50,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: AppConstants.paddingM),
        children: [
          // "All" option
          if (showAllOption)
            Padding(
              padding: const EdgeInsets.only(right: AppConstants.paddingS),
              child: FilterChip(
                label: const Text('Toutes'),
                selected: selectedCategoryId == null,
                onSelected: (selected) {
                  if (selected) {
                    onCategorySelected(null);
                  }
                },
                selectedColor: AppConstants.primaryGreen.withOpacity(0.2),
                checkmarkColor: AppConstants.primaryGreen,
                labelStyle: TextStyle(
                  color: selectedCategoryId == null 
                      ? AppConstants.primaryGreen 
                      : AppConstants.primaryTextColor,
                  fontWeight: selectedCategoryId == null 
                      ? FontWeight.w600 
                      : FontWeight.normal,
                ),
              ),
            ),

          // Category chips
          ...categories.map((category) {
            final isSelected = selectedCategoryId == category.id;
            return Padding(
              padding: const EdgeInsets.only(right: AppConstants.paddingS),
              child: FilterChip(
                label: Text(category.name),
                selected: isSelected,
                onSelected: (selected) {
                  onCategorySelected(selected ? category.id : null);
                },
                selectedColor: category.color.withOpacity(0.2),
                checkmarkColor: category.color,
                labelStyle: TextStyle(
                  color: isSelected ? category.color : AppConstants.primaryTextColor,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
                avatar: isSelected 
                    ? null 
                    : Icon(
                        category.icon,
                        size: AppConstants.iconSizeS,
                        color: category.color,
                      ),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}

/// Compact category chip for use in lists
class CompactCategoryChip extends StatelessWidget {
  final AppCategory category;
  final VoidCallback? onTap;

  const CompactCategoryChip({
    super.key,
    required this.category,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppConstants.paddingM,
          vertical: AppConstants.paddingS,
        ),
        decoration: BoxDecoration(
          color: category.color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
          border: Border.all(
            color: category.color.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              category.icon,
              size: AppConstants.iconSizeS,
              color: category.color,
            ),
            const SizedBox(width: AppConstants.paddingS),
            // FIXED: Added Flexible to prevent overflow in horizontal layout
            Flexible(
              child: Text(
                category.name,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: category.color,
                  fontWeight: FontWeight.w600,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}