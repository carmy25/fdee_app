import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fudiee/routes/router.dart';
import 'package:fudiee/themes/theme.dart';

import 'package:flutter_data/flutter_data.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:fudiee/main.data.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(ProviderScope(overrides: [
    configureRepositoryLocalStorage(
      baseDirFn: () =>
          getApplicationDocumentsDirectory().then((dir) => dir.path),
      encryptionKey: null,
      // whether to clear all local storage during initialization
      clear: LocalStorageClearStrategy.never,
    )
  ], child: const MyApp()));
}

class MyApp extends HookConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final routerConfig = ref.watch(appRouterProvider);

    return ScreenUtilInit(
      designSize: const Size(428, 926),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, _) {
        return MaterialApp.router(
          title: 'FDee',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.buildTheme(context),
          routerConfig: routerConfig,
        );
      },
    );
  }
}
