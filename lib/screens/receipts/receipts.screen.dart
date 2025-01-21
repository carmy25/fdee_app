import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fudiee/main.data.dart';
import 'package:fudiee/routes/router.dart';
import 'package:fudiee/screens/cart/cart.screen.dart';
import 'package:fudiee/themes/app_colors.dart';

class ReceiptsScreen extends ConsumerStatefulWidget {
  const ReceiptsScreen({super.key});
  static String routePath = '/receipts';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ReceiptsScreenState();
}

class _ReceiptsScreenState extends ConsumerState<ReceiptsScreen> {
  @override
  Widget build(BuildContext context) {
    final state = ref.receipts.watchAll();

    final receiptsBody = state.isLoading
        ? const Center(child: CircularProgressIndicator())
        : ListView.separated(
            itemCount: state.model.length,
            separatorBuilder: (context, index) => const Divider(height: 0),
            itemBuilder: (context, index) {
              final receipt = state.model[index];
              final paymentMethod = 'Готівка';
              return ListTile(
                leading: CircleAvatar(child: Text(receipt.id.toString())),
                title:
                    Text('${receipt.place}. $paymentMethod: ${receipt.price}'),
                subtitle: Text(receipt.createdAt.toString()),
                trailing: const Icon(Icons.close_rounded),
                onTap: () {},
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
            router.push(CartScreen.routePath);
          }),
      body: receiptsBody,
    );
  }
}
