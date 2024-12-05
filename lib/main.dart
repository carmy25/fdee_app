import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fudiee/bindings/bindings.dart';
import 'package:fudiee/routes/router.dart';
import 'package:fudiee/screens/splash/splash_screen.dart';
import 'package:fudiee/themes/theme.dart';
import 'package:get/get.dart';

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
    /* return MaterialApp(
      home: Scaffold(
        body: Center(
          child: ref.watch(repositoryInitializerProvider).when(
                error: (error, _) => Text(error.toString()),
                loading: () => const CircularProgressIndicator(),
                data: (_) => Text('Flutter Data is ready: ${ref.users}'),
              ),
        ),
      ),
    ); */

    return ScreenUtilInit(
      designSize: const Size(428, 926),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, _) {
        return GetMaterialApp(
          initialBinding: InitialBindings(),
          title: 'Fudiee',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.buildTheme(context),
          initialRoute: SplashScreen.routeName,
          getPages: AppRouter.routes,
        );
      },
    );
  }
}
