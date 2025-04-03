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
      physics: ClampingScrollPhysics(),
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
    final state = ref.receipts.watchAll(syncLocal: true);

    if (state.isLoading) {
      return Scaffold(
        backgroundColor: scaffoldBgColor,
        appBar: AppBar(
          backgroundColor: scaffoldBgColor,
          automaticallyImplyLeading: false,
          elevation: 2,
          title: Center(
            child: Text(
              'Чеки',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
        ),
        body: ProgressIndicatorWidget(),
      );
    }

    final openReceipts =
        state.model.where((r) => r.status != 'CLOSED').toList();
    final closedReceipts =
        state.model.where((r) => r.status == 'CLOSED').toList();

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
          }),
      body: Column(
        children: [
          Expanded(
            flex: 7,
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFFE6EEF8), // Darker blue tint
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withAlpha((0.2 * 255).toInt()),
                    spreadRadius: 2,
                    blurRadius: 6,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
                  Expanded(child: buildReceiptList(openReceipts)),
                ],
              ),
            ),
          ),
          Divider(thickness: 1, color: Colors.grey[300]),
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFFDCE2DC), // Darker contrast for closed receipts
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withAlpha((0.2 * 255).toInt()),
                    spreadRadius: 2,
                    blurRadius: 6,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
                  Expanded(child: buildReceiptList(closedReceipts)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
