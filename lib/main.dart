import 'package:flutter/material.dart';
import 'package:flutter_data/flutter_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fudiee/routes/router.dart';
import 'package:fudiee/themes/theme.dart';

import 'package:fudiee/main.data.dart';
import 'package:fudiee/widgets/progress_indicator.widget.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.delayed(const Duration(seconds: 1));

  await SentryFlutter.init(
    (options) {
      options.dsn =
          'https://6f210b0b54c7ce73fd8beb9b47fe1baf@o4508295598309376.ingest.us.sentry.io/4508997581668352';
      // Set tracesSampleRate to 1.0 to capture 100% of transactions for tracing.
      // We recommend adjusting this value in production.
      options.tracesSampleRate = 1.0;
      // The sampling rate for profiling is relative to tracesSampleRate
      // Setting to 1.0 will profile 100% of sampled transactions:
      options.profilesSampleRate = 1.0;
    },
    appRunner: () => runApp(ProviderScope(
      overrides: [
        configureRepositoryLocalStorage(
          baseDirFn: () =>
              getApplicationDocumentsDirectory().then((dir) => dir.path),

          encryptionKey: null,

          // whether to clear all local storage during initialization

          clear: LocalStorageClearStrategy.always,
        )
      ],
      child: SentryWidget(
        child: const MyApp(),
      ),
    )),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final routerConfig = ref.watch(appRouterProvider);
    final repoInitializer = ref.watch(repositoryInitializerProvider);
    final app = ScreenUtilInit(
      designSize: Size(393, 851),
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
    return repoInitializer.when(
        loading: () => MaterialApp(
              home: Scaffold(
                body: ProgressIndicatorWidget(),
              ),
            ),
        error: (error, _) => MaterialApp(home: Text(error.toString())),
        data: (_) {
          return app;
        });
  }
}
