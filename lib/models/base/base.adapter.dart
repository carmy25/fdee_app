import 'package:flutter_data/flutter_data.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

mixin JsonBaseAdapter<T extends DataModel<T>> on Adapter<T> {
  @override
  String get baseUrl => const String.fromEnvironment(
        'BE_HOST',
      );

  @override
  FutureOr<Map<String, String>> get defaultHeaders async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token != null) {
      return await super.defaultHeaders & {'Authorization': 'token $token'};
    }
    return super.defaultHeaders;
  }
}
