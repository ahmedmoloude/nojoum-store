import 'package:flutter/material.dart';
import '../models/payment_transaction.dart';
import '../services/subscription_service.dart';
import '../utils/constants.dart';
import '../l10n/app_localizations.dart';

class PaymentHistoryScreen extends StatefulWidget {
  const PaymentHistoryScreen({super.key});

  @override
  State<PaymentHistoryScreen> createState() => _PaymentHistoryScreenState();
}

class _PaymentHistoryScreenState extends State<PaymentHistoryScreen> {
  final SubscriptionService _subscriptionService = SubscriptionService();
  List<PaymentTransaction> _transactions = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadTransactions();
  }

  Future<void> _loadTransactions() async {
    try {
      setState(() {
        _isLoading = true;
        _error = null;
      });

      final transactions = await _subscriptionService.getTransactions();
      
      setState(() {
        _transactions = transactions;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.paymentHistory),
        backgroundColor: AppConstants.primaryGold,
        foregroundColor: AppConstants.whiteTextColor,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? _buildErrorWidget()
              : _buildTransactionsList(),
    );
  }

  Widget _buildErrorWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 64,
            color: Colors.red[400],
          ),
          const SizedBox(height: AppConstants.paddingM),
          Text(
            AppLocalizations.of(context)!.error,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: AppConstants.paddingS),
          Text(
            _error!,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppConstants.secondaryTextColor,
            ),
          ),
          const SizedBox(height: AppConstants.paddingL),
          ElevatedButton(
            onPressed: _loadTransactions,
            child: Text(AppLocalizations.of(context)!.retry),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionsList() {
    if (_transactions.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.receipt_long_outlined,
              size: 64,
              color: AppConstants.secondaryTextColor,
            ),
            const SizedBox(height: AppConstants.paddingM),
            Text(
              AppLocalizations.of(context)!.noTransactions,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: AppConstants.secondaryTextColor,
              ),
            ),
            const SizedBox(height: AppConstants.paddingS),
            Text(
              AppLocalizations.of(context)!.noPaymentsYet,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppConstants.secondaryTextColor,
              ),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _loadTransactions,
      child: ListView.builder(
        padding: const EdgeInsets.all(AppConstants.paddingM),
        itemCount: _transactions.length,
        itemBuilder: (context, index) {
          final transaction = _transactions[index];
          return _buildTransactionCard(transaction);
        },
      ),
    );
  }

  Widget _buildTransactionCard(PaymentTransaction transaction) {
    Color statusColor;
    IconData statusIcon;

    switch (transaction.status) {
      case TransactionStatus.pending:
        statusColor = AppConstants.primaryOrange;
        statusIcon = Icons.hourglass_empty;
        break;
      case TransactionStatus.approved:
        statusColor = AppConstants.mauritanianGreen;
        statusIcon = Icons.check_circle;
        break;
      case TransactionStatus.rejected:
        statusColor = AppConstants.richRed;
        statusIcon = Icons.cancel;
        break;
      case TransactionStatus.cancelled:
        statusColor = AppConstants.secondaryTextColor;
        statusIcon = Icons.block;
        break;
    }

    return Card(
      margin: const EdgeInsets.only(bottom: AppConstants.paddingM),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.paddingL),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        transaction.package?.name ?? AppLocalizations.of(context)!.unknownPackage,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: AppConstants.paddingXS),
                      Text(
                        '${AppLocalizations.of(context)!.reference}: ${transaction.transactionReference}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppConstants.secondaryTextColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppConstants.paddingM,
                    vertical: AppConstants.paddingS,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(AppConstants.borderRadiusM),
                    border: Border.all(color: statusColor.withValues(alpha: 0.3)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        statusIcon,
                        size: 16,
                        color: statusColor,
                      ),
                      const SizedBox(width: AppConstants.paddingXS),
                      Text(
                        transaction.statusLabel,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: statusColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppConstants.paddingM),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${AppLocalizations.of(context)!.amount}:',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  transaction.formattedAmount,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppConstants.primaryGold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppConstants.paddingS),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${AppLocalizations.of(context)!.submissionDate}:',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  '${transaction.createdAt.day}/${transaction.createdAt.month}/${transaction.createdAt.year}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
            if (transaction.paidAt != null) ...[
              const SizedBox(height: AppConstants.paddingS),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${AppLocalizations.of(context)!.paymentDate}:',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    '${transaction.paidAt!.day}/${transaction.paidAt!.month}/${transaction.paidAt!.year}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ],
            if (transaction.reviewedAt != null) ...[
              const SizedBox(height: AppConstants.paddingS),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${AppLocalizations.of(context)!.reviewDate}:',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    '${transaction.reviewedAt!.day}/${transaction.reviewedAt!.month}/${transaction.reviewedAt!.year}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ],
            if (transaction.userNotes?.isNotEmpty == true) ...[
              const SizedBox(height: AppConstants.paddingM),
              Text(
                '${AppLocalizations.of(context)!.yourNotes}:',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: AppConstants.paddingXS),
              Text(
                transaction.userNotes!,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppConstants.secondaryTextColor,
                ),
              ),
            ],
            if (transaction.adminNotes?.isNotEmpty == true) ...[
              const SizedBox(height: AppConstants.paddingM),
              Text(
                '${AppLocalizations.of(context)!.adminNotes}:',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: AppConstants.paddingXS),
              Container(
                padding: const EdgeInsets.all(AppConstants.paddingM),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(AppConstants.borderRadiusM),
                  border: Border.all(color: statusColor.withValues(alpha: 0.2)),
                ),
                child: Text(
                  transaction.adminNotes!,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: statusColor,
                  ),
                ),
              ),
            ],
            if (transaction.isPending) ...[
              const SizedBox(height: AppConstants.paddingM),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => _cancelTransaction(transaction),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppConstants.richRed,
                    side: BorderSide(color: AppConstants.richRed),
                  ),
                  child: Text(AppLocalizations.of(context)!.cancelTransaction),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Future<void> _cancelTransaction(PaymentTransaction transaction) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.confirmCancellation),
        content: Text(AppLocalizations.of(context)!.areYouSureCancelTransaction),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(AppLocalizations.of(context)!.no),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(
              foregroundColor: AppConstants.richRed,
            ),
            child: Text(AppLocalizations.of(context)!.yesCancel),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      try {
        await _subscriptionService.cancelTransaction(transaction.id);
        
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(AppLocalizations.of(context)!.transactionCancelledSuccess),
              backgroundColor: Colors.green,
            ),
          );
          _loadTransactions(); // Refresh the list
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(AppLocalizations.of(context)!.errorCancelling(e.toString())),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }
}
