import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../models/subscription_package.dart';
import '../services/subscription_service.dart';
import '../utils/constants.dart';
import '../l10n/app_localizations.dart';

class PaymentScreen extends StatefulWidget {
  final SubscriptionPackage package;

  const PaymentScreen({
    super.key,
    required this.package,
  });

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final SubscriptionService _subscriptionService = SubscriptionService();
  final TextEditingController _notesController = TextEditingController();
  final ImagePicker _imagePicker = ImagePicker();
  
  File? _transactionImage;
  DateTime _paidAt = DateTime.now();
  bool _isLoading = false;
  Map<String, String> _paymentInfo = {};

  @override
  void initState() {
    super.initState();
    _loadPaymentInfo();
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _loadPaymentInfo() async {
    try {
      final paymentInfo = await _subscriptionService.getPaymentInfo();
      setState(() {
        _paymentInfo = paymentInfo;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.errorLoadingPaymentInfo(e.toString())),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _pickImage() async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 85,
      );

      if (image != null) {
        setState(() {
          _transactionImage = File(image.path);
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.errorSelectingImage(e.toString())),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _submitPayment() async {
    if (_transactionImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.pleaseSelectTransactionImage),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await _subscriptionService.createPayment(
        packageId: widget.package.id,
        transactionImage: _transactionImage!,
        paidAt: _paidAt,
        userNotes: _notesController.text.trim().isEmpty
            ? null
            : _notesController.text.trim(),
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.paymentSubmittedSuccess),
            backgroundColor: Colors.green,
          ),
        );

        // Navigate back to previous screens
        Navigator.of(context).popUntil((route) => route.isFirst);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.errorSubmitting(e.toString())),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.payment),
        backgroundColor: AppConstants.primaryGold,
        foregroundColor: AppConstants.whiteTextColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppConstants.paddingM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPackageSummary(),
            const SizedBox(height: AppConstants.paddingL),
            _buildPaymentInstructions(),
            const SizedBox(height: AppConstants.paddingL),
            _buildTransactionImageSection(),
            const SizedBox(height: AppConstants.paddingL),
            _buildPaymentDateSection(),
            const SizedBox(height: AppConstants.paddingL),
            _buildNotesSection(),
            const SizedBox(height: AppConstants.paddingXL),
            _buildSubmitButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildPackageSummary() {
    return Container(
      padding: const EdgeInsets.all(AppConstants.paddingL),
      decoration: BoxDecoration(
        color: AppConstants.primaryGold.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
        border: Border.all(color: AppConstants.primaryGold.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.subscriptionSummaryTitle,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppConstants.primaryGold,
            ),
          ),
          const SizedBox(height: AppConstants.paddingM),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppLocalizations.of(context)!.packageLabel,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                widget.package.name,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.paddingS),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppLocalizations.of(context)!.durationLabel,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                widget.package.durationText,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
          const SizedBox(height: AppConstants.paddingS),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppLocalizations.of(context)!.priceLabel,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                widget.package.formattedPrice,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppConstants.primaryGold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentInstructions() {
    return Container(
      padding: const EdgeInsets.all(AppConstants.paddingL),
      decoration: BoxDecoration(
        color: AppConstants.surfaceColor,
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
        border: Border.all(color: AppConstants.dividerColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.info_outline,
                color: AppConstants.primaryOrange,
                size: 24,
              ),
              const SizedBox(width: AppConstants.paddingS),
              Text(
                AppLocalizations.of(context)!.paymentInstructionsTitle,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppConstants.primaryOrange,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.paddingM),
          if (_paymentInfo['bankName']?.isNotEmpty == true) ...[
            _buildInfoRow(AppLocalizations.of(context)!.bankLabel, _paymentInfo['bankName']!),
            const SizedBox(height: AppConstants.paddingS),
          ],
          if (_paymentInfo['accountNumber']?.isNotEmpty == true) ...[
            _buildInfoRow(AppLocalizations.of(context)!.accountNumberLabel, _paymentInfo['accountNumber']!),
            const SizedBox(height: AppConstants.paddingS),
          ],
          if (_paymentInfo['phoneNumber']?.isNotEmpty == true) ...[
            _buildInfoRow(AppLocalizations.of(context)!.phoneLabel, _paymentInfo['phoneNumber']!),
            const SizedBox(height: AppConstants.paddingS),
          ],
          if (_paymentInfo['instructions']?.isNotEmpty == true) ...[
            const SizedBox(height: AppConstants.paddingS),
            Text(
              _paymentInfo['instructions']!,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppConstants.secondaryTextColor,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 120,
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }

  Widget _buildTransactionImageSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.transactionProofRequired,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppConstants.paddingS),
        Text(
          AppLocalizations.of(context)!.uploadReceiptHint,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: AppConstants.secondaryTextColor,
          ),
        ),
        const SizedBox(height: AppConstants.paddingM),
        GestureDetector(
          onTap: _pickImage,
          child: Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppConstants.backgroundColor,
              borderRadius: BorderRadius.circular(AppConstants.borderRadiusM),
              border: Border.all(
                color: _transactionImage != null 
                    ? AppConstants.mauritanianGreen 
                    : AppConstants.dividerColor,
                width: 2,
                style: BorderStyle.solid,
              ),
            ),
            child: _transactionImage != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(AppConstants.borderRadiusM),
                    child: Image.file(
                      _transactionImage!,
                      fit: BoxFit.cover,
                    ),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.cloud_upload_outlined,
                        size: 48,
                        color: AppConstants.secondaryTextColor,
                      ),
                      const SizedBox(height: AppConstants.paddingS),
                      Text(
                        AppLocalizations.of(context)!.tapToSelectImage,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppConstants.secondaryTextColor,
                        ),
                      ),
                      const SizedBox(height: AppConstants.paddingXS),
                      Text(
                        AppLocalizations.of(context)!.imageTypesHint,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppConstants.secondaryTextColor,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentDateSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.paymentDateRequired,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppConstants.paddingS),
        GestureDetector(
          onTap: () async {
            final date = await showDatePicker(
              context: context,
              initialDate: _paidAt,
              firstDate: DateTime.now().subtract(const Duration(days: 30)),
              lastDate: DateTime.now(),
            );
            if (date != null) {
              setState(() {
                _paidAt = date;
              });
            }
          },
          child: Container(
            padding: const EdgeInsets.all(AppConstants.paddingM),
            decoration: BoxDecoration(
              color: AppConstants.surfaceColor,
              borderRadius: BorderRadius.circular(AppConstants.borderRadiusM),
              border: Border.all(color: AppConstants.dividerColor),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  color: AppConstants.primaryGold,
                ),
                const SizedBox(width: AppConstants.paddingM),
                Text(
                  '${_paidAt.day}/${_paidAt.month}/${_paidAt.year}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNotesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.notesOptional,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppConstants.paddingS),
        TextField(
          controller: _notesController,
          maxLines: 3,
          decoration: InputDecoration(
            hintText: AppLocalizations.of(context)!.notesHint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppConstants.borderRadiusM),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppConstants.borderRadiusM),
              borderSide: BorderSide(color: AppConstants.primaryGold),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _isLoading ? null : _submitPayment,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppConstants.primaryGold,
          foregroundColor: AppConstants.whiteTextColor,
          padding: const EdgeInsets.symmetric(
            vertical: AppConstants.paddingL,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.borderRadiusM),
          ),
        ),
        child: _isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Text(
                AppLocalizations.of(context)!.submitPayment,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
      ),
    );
  }
}
