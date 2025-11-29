import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'providers/language_provider.dart';

import 'common_widgets/waiting_screen_widget.dart';
import 'constants/constant.dart';
import 'enums/app_enums.dart';
import 'extensions/constant_extensions.dart';
import 'firebase/firebase_util.dart';
import 'l10n/app_localizations.dart';
import 'navigation/router_configs.dart';
import 'providers/theme_provider.dart';
import 'providers/utils/provider_utility.dart';
import 'utilities/app_utils.dart';
import 'utilities/storage/shared_preference/shared_preferences_util.dart';

const appTitle = 'Smart ToDo';
//final appLinks = AppLinks();

void main() {
  setupApp();
}

Future<void> setupApp() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SharedPreferencesUtil.initialize();

  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });

  await FirebaseUtil.runAppWithFirebase(
    app: const ProviderScope(child: InitializerWidget()),
  );

  await AppUtils.instance.initializeAppUtils();
}

class InitializerWidget extends StatefulHookConsumerWidget {
  const InitializerWidget({Key? key}) : super(key: key);

  @override
  ConsumerState<InitializerWidget> createState() => _InitializerWidgetState();
}

class _InitializerWidgetState extends ConsumerState<InitializerWidget> {
  late final theme = ref.watch(themeProvider);
  late final auth = ref.watch(authenticationProvider);

  late final Future<void> init = _appInitialize();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    theme.initializeThemeMetaData();
    View.of(context).platformDispatcher.onPlatformBrightnessChanged = () {
      if (theme.appTheme == ThemeMode.system) {
        //theme.changeAppThemeRead(ThemeMode.system);
      }
    };
  }

  Future<void> _appInitialize() async {
    if (mounted) {
      Constant.instance.init(context);
    }

    await auth.initializeUser();

    if (mounted) {
      await AppUtils.instance.configApp(context: context);
    }
    //}

    final savedLanguageCode = SharedPreferencesUtil.instance.getLanguageCode();
    if (savedLanguageCode != null) {
      final savedLanguage = Language.values.firstWhere((element) => element.languageCode == savedLanguageCode);
      ref.read(languageProvider.notifier).update((_) => savedLanguage);
    }
  }

  @override
  Widget build(BuildContext context) {
    late final theme = ref.watch(themeProvider);

    return FutureBuilder<void>(
      future: init,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return MaterialApp(
            theme: theme.themeData,
            home: const WaitingScreenWidget(),
            debugShowCheckedModeBanner: false,
          );
        }

        return const MyApp();
      },
    );
  }
}

class MyApp extends HookConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    late final theme = ref.watch(themeProvider);
    final language = ref.watch(languageProvider);

    return SafeArea(
      child: MaterialApp.router(
        routerConfig: RouterConfigs.instance.routerConfig,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: Locale(language.languageCode),
        title: appTitle,
        theme: theme.themeData,
        /*theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: AppColor.themeColorGreen,
          brightness: Brightness.dark,
        ),*/
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
