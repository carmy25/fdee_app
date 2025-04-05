import 'package:fudiee/models/receipt/active_receipt.model.dart';
import 'package:fudiee/models/receipt/receipt.model.dart';
import 'package:fudiee/widgets/progress_indicator.widget.dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fudiee/main.data.dart';
import 'package:fudiee/routes/router.dart';
import 'package:fudiee/screens/cart/cart.screen.dart';
import 'package:fudiee/themes/app_colors.dart';

class ReceiptsScreen extends ConsumerStatefulWidget {
  const ReceiptsScreen({super.key});
  static String routePath = '/receipts';
  static String name = 'ReceiptsScreen';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ReceiptsScreenState();
}

class _ReceiptsScreenState extends ConsumerState<ReceiptsScreen> {
  @override
  void initState() {
    super.initState();
    // Use post-frame callback to ensure the widget is mounted
    //WidgetsBinding.instance.addPostFrameCallback((_) {
    //  _initializeData();
    //});
  }

  // void _initializeData() {
  //   if (!mounted) return;
  //   try {
  //     setState(() {
  //       _receiptsFuture = _fetchReceipts();
  //     });
  //   } catch (e) {
  //     debugPrint('Error initializing receipts: $e');
  //   }
  // }

  Future<List<Receipt>> _fetchReceipts() async {
    try {
      return await ref.receipts.findAll(
        remote: true,
        syncLocal: true,
      );
    } catch (e) {
      debugPrint('Error fetching receipts: $e');
      rethrow;
    }
  }

  Future<void> _handleRefresh() async {
    try {
      _fetchReceipts();
    } catch (e) {
      debugPrint('Error refreshing receipts: $e');
    }
  }

  Map<String, List<Receipt>> _filterReceipts(List<Receipt> receipts) {
    final openReceipts =
        receipts.where((r) => r.status != 'CLOSED').toList().reversed.toList();
    final closedReceipts =
        receipts.where((r) => r.status == 'CLOSED').toList().reversed.toList();
    return {
      'open': openReceipts,
      'closed': closedReceipts,
    };
  }

  _getPaymentMethodText(Receipt receipt) {
    final paymentMethod = receipt.paymentMethod;
    if (paymentMethod == 'CARD') {
      return 'Картка';
    } else if (paymentMethod == 'CASH') {
      return 'Готівка';
    }
    return 'Переказ';
  }

  Widget buildReceiptList(List<Receipt> receipts) {
    final router = ref.read(appRouterProvider);
    return ListView.separated(
      shrinkWrap: true,
      physics: const AlwaysScrollableScrollPhysics(),
      reverse: false,
      itemCount: receipts.length,
      separatorBuilder: (context, index) => const Divider(height: 0),
      itemBuilder: (context, index) {
        final receipt = receipts[index];
        final paymentMethod = _getPaymentMethodText(receipt);
        return ListTile(
          leading: CircleAvatar(child: Text(receipt.id.toString())),
          title: Text(
              '${(receipt.placeName?.isEmpty ?? true) ? 'З собою' : receipt.placeName}. $paymentMethod: ${receipt.price}'),
          subtitle:
              Text(DateFormat('dd-MM-yy – kk:mm').format(receipt.createdAt)),
          trailing: Icon(receipt.status == 'CLOSED'
              ? Icons.check_circle
              : Icons.local_activity),
          onTap: () {
            final activeReceipt = ref.read(activeReceiptProvider.notifier);
            activeReceipt.setActive(receipt);
            router.push(CartScreen.routePath);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBgColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: scaffoldBgColor,
        elevation: 2,
        title: Center(
          child: Text(
            'Чеки',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        tooltip: 'Створити чек',
        child: const Icon(Icons.add),
        onPressed: () {
          final router = ref.read(appRouterProvider);
          final activeReceipt = ref.read(activeReceiptProvider.notifier);
          debugPrint('add receipt');
          final receipt = Receipt(
            paymentMethod: 'CARD',
            status: 'OPEN',
            price: 0,
            createdAt: DateTime.now(),
            productItems: [],
          );
          activeReceipt.setActive(receipt);
          router.push(CartScreen.routePath);
        },
      ),
      body: RefreshIndicator(
        onRefresh: _handleRefresh,
        child: FutureBuilder<List<Receipt>>(
          future: _fetchReceipts(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const ProgressIndicatorWidget();
            }

            if (snapshot.hasError) {
              return Center(child: Text('Помилка: ${snapshot.error}'));
            }

            if (!snapshot.hasData) {
              return const Center(child: Text('Немає даних'));
            }

            final receipts = _filterReceipts(snapshot.data!);

            return SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFE6EEF8),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withAlpha((0.2 * 255).toInt()),
                          spreadRadius: 2,
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    margin:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            'Активні',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.35,
                          child: buildReceiptList(receipts['open']!),
                        ),
                      ],
                    ),
                  ),
                  Divider(thickness: 1, color: Colors.grey[300]),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFDCE2DC),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withAlpha((0.2 * 255).toInt()),
                          spreadRadius: 2,
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    margin:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            'Закриті',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.35,
                          child: buildReceiptList(receipts['closed']!),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
