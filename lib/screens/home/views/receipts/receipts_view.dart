import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fudiee/themes/app_colors.dart';

class ReceiptsView extends StatefulWidget {
  const ReceiptsView({
    super.key,
  });

  @override
  State<ReceiptsView> createState() => _ReceiptsViewState();
}

class _ReceiptsViewState extends State<ReceiptsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: scaffoldBgColor,
        title: Text(
          'Чеки',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: const CircleAvatar(child: Text('67')),
            title: const Text('Зал 1, Стіл 2. Готівка: 1035'),
            subtitle: const Text('11:45 22/08/2023'),
            trailing: const Icon(Icons.close_rounded),
            onTap: () {
              if (kDebugMode) {
                print('hello');
              }
            },
          ),
          const Divider(height: 0),
          const ListTile(
            leading: CircleAvatar(child: Text('67')),
            title: Text('№ 1254 - Готівка: 1035'),
            subtitle: Text('11:45 22/08/2023'),
            trailing: Icon(Icons.close_rounded),
          ),
          const Divider(height: 0),
          const ListTile(
            leading: CircleAvatar(child: Text('#2')),
            title: Text('Headline'),
            subtitle: Text(
                'Longer supporting text to demonstrate how the text wraps and how the leading and trailing widgets are centered vertically with the text.'),
            trailing: Icon(Icons.favorite_rounded),
          ),
          const Divider(height: 0),
          const ListTile(
            leading: CircleAvatar(child: Text('C')),
            title: Text('Headline'),
            subtitle: Text(
                "Longer supporting text to demonstrate how the text wraps and how setting 'ListTile.isThreeLine = true' aligns leading and trailing widgets to the top vertically with the text."),
            trailing: Icon(Icons.close_rounded),
            isThreeLine: true,
          ),
          const Divider(height: 0),
          const ListTile(
            leading: CircleAvatar(child: Text('A')),
            title: Text('Headline'),
            subtitle: Text('Supporting text'),
            trailing: Icon(Icons.favorite_rounded),
          ),
          const Divider(height: 0),
          const ListTile(
            leading: CircleAvatar(child: Text('B')),
            title: Text('Headline'),
            subtitle: Text(
                'Longer supporting text to demonstrate how the text wraps and how the leading and trailing widgets are centered vertically with the text.'),
            trailing: Icon(Icons.favorite_rounded),
          ),
          const Divider(height: 0),
          const ListTile(
            leading: CircleAvatar(child: Text('C')),
            title: Text('Headline'),
            subtitle: Text(
                "Longer supporting text to demonstrate how the text wraps and how setting 'ListTile.isThreeLine = true' aligns leading and trailing widgets to the top vertically with the text."),
            trailing: Icon(Icons.close_rounded),
            isThreeLine: true,
          ),
          const ListTile(
            leading: CircleAvatar(child: Text('A')),
            title: Text('Headline'),
            subtitle: Text('Supporting text'),
            trailing: Icon(Icons.close_rounded),
          ),
          const Divider(height: 0),
          const ListTile(
            leading: CircleAvatar(child: Text('B')),
            title: Text('Headline'),
            subtitle: Text(
                'Longer supporting text to demonstrate how the text wraps and how the leading and trailing widgets are centered vertically with the text.'),
            trailing: Icon(Icons.favorite_rounded),
          ),
          const Divider(height: 0),
          const ListTile(
            leading: CircleAvatar(child: Text('C')),
            title: Text('Headline'),
            subtitle: Text(
                "Longer supporting text to demonstrate how the text wraps and how setting 'ListTile.isThreeLine = true' aligns leading and trailing widgets to the top vertically with the text."),
            trailing: Icon(Icons.close_rounded),
            isThreeLine: true,
          ),
        ],
      ),
    );
  }
}
