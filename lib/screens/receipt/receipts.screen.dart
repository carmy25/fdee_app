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
  Widget build(BuildContext context) {
    final state = ref.receipts.watchAll(syncLocal: true);
    final router = ref.read(appRouterProvider);
    final receiptsBody = state.isLoading
        ? ProgressIndicatorWidget()
        : ListView.separated(
            reverse: false,
            itemCount: state.model.length,
            separatorBuilder: (context, index) => const Divider(height: 0),
            itemBuilder: (context, index) {
              final receipt = state.model[index];
              final paymentMethod =
                  receipt.paymentMethod == 'CARD' ? 'Картка' : 'Готівка';
              return ListTile(
                leading: CircleAvatar(child: Text(receipt.id.toString())),
                title: Text(
                    '${(receipt.placeName?.isEmpty ?? true) ? 'З собою' : receipt.placeName}. $paymentMethod: ${receipt.price}'),
                subtitle: Text(
                    DateFormat('dd-MM-yy – kk:mm').format(receipt.createdAt)),
                trailing: Icon(receipt.status == 'CLOSED'
                    ? Icons.check_circle
                    : Icons.local_activity),
                onTap: () {
                  final activeReceipt =
                      ref.read(activeReceiptProvider.notifier);
                  activeReceipt.setActive(receipt);
                  router.push(CartScreen.routePath);
                },
              );
            },
          );
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: scaffoldBgColor,
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
      body: receiptsBody,
    );
  }
}
