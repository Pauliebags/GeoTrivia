// Main.dart page
import 'package:firebase_core/firebase_core.dart';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geotrivia/src/Create_Account/Create_Account_Screen.dart';
import 'package:geotrivia/src/Profile_Screen/Profile_Screen.dart';
import 'package:geotrivia/src/Questions/screens/main_menu.dart';
import 'package:geotrivia/src/landing_screen/landing_screen.dart';
import 'package:geotrivia/src/settings/theme_provider.dart';
import 'package:geotrivia/src/signin/sign_in_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';

import 'src/Forgot_Password/Forgot_Password_Screen.dart';
import 'src/app_lifecycle/app_lifecycle.dart';
import 'src/audio/audio_controller.dart';
import 'src/crashlytics/crashlytics.dart';
import 'src/games_services/games_services.dart';
import 'src/leaderboard/leaderboard_screen.dart';
import 'src/main_menu/main_menu_screen.dart';
import 'src/settings/persistence/local_storage_settings_persistence.dart';
import 'src/settings/persistence/settings_persistence.dart';
import 'src/settings/settings.dart';
import 'src/settings/settings_screen.dart';
import 'src/style/my_transition.dart';
import 'src/style/palette.dart';
import 'src/style/snack_bar.dart';

bool? result;

Future<void> main() async {
  Provider.debugCheckInvalidValueType = null;

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseCrashlytics? crashlytics;

  await guardWithCrashlytics(
    guardedMain,
    crashlytics: crashlytics,
  );
}

void guardedMain() {
  if (kReleaseMode) {
    Logger.root.level = Level.WARNING;
  }
  Logger.root.onRecord.listen((record) {
    debugPrint('${record.level.name}: ${record.time}: '
        '${record.loggerName}: '
        '${record.message}');
  });

  WidgetsFlutterBinding.ensureInitialized();

  _log.info('Going full screen');
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.edgeToEdge,
  );

  GamesServicesController? gamesServicesController;

  runApp(
    MyApp(
      settingsPersistence: LocalStorageSettingsPersistence(),
      gamesServicesController: gamesServicesController,
    ),
  );
}

Logger _log = Logger('main.dart');

class MyApp extends StatelessWidget {
  static final _router = GoRouter(
    initialLocation: '/landingscreen',
    errorBuilder: (context, state) => Scaffold(
      appBar: AppBar(),
    ),
    errorPageBuilder: (context, state) => MaterialPage<void>(
      key: state.pageKey,
      child: Scaffold(
        appBar: AppBar(),
      ),
    ),
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
          path: '/landingscreen', builder: (context, state) => LandingScreen()),
      GoRoute(
          path: '/error',
          builder: (context, state) => Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              )),
      GoRoute(
          path: '/ForgotPassword',
          builder: (context, state) => ForgotPasswordScreen()),
      GoRoute(
          path: '/CreateAccount',
          builder: (context, state) => CreateAccountScreen()),
      GoRoute(
          path: '/signin',
          builder: (context, state) => SignInScreen(),
          routes: [
            GoRoute(
                path: 'CreateAccount',
                builder: (context, state) => CreateAccountScreen()),
          ]),
      GoRoute(
          path: '/',
          builder: (context, state) =>
              const MainMenuScreen(key: Key('main menu')),
          routes: [
            GoRoute(
              path: 'play',
              pageBuilder: (context, state) => buildMyTransition(
                child: MainMenu(),
                color: context.watch<Palette>().backgroundLevelSelection,
              ),
            ),
            GoRoute(
              path: 'settings',
              builder: (context, state) =>
                  const SettingsScreen(key: Key('settings')),
            ),
            GoRoute(
                path: 'ProfileScreen',
                pageBuilder: (context, state) => buildMyTransition(
                      child: ProfileScreen(),
                      color: context.watch<Palette>().backgroundLevelSelection,
                    )),
            GoRoute(
              path: 'leaderBoard',
              builder: (context, state) => LeaderBoard(),
            ),
          ]),
    ],
  );

  final SettingsPersistence settingsPersistence;

  final GamesServicesController? gamesServicesController;

  const MyApp({
    required this.settingsPersistence,
    required this.gamesServicesController,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppLifecycleObserver(
      child: MultiProvider(
        providers: [
          Provider<GamesServicesController?>.value(
              value: gamesServicesController),
          Provider<SettingsController>(
            lazy: false,
            create: (context) => SettingsController(
              persistence: settingsPersistence,
            )..loadStateFromPersistence(),
          ),
          ProxyProvider2<SettingsController, ValueNotifier<AppLifecycleState>,
              AudioController>(
            // Ensures that the AudioController is created on startup,
            // and not "only when it's needed", as is default behavior.
            // This way, music starts immediately.
            lazy: false,
            create: (context) => AudioController()..initialize(),
            update: (context, settings, lifecycleNotifier, audio) {
              if (audio == null) throw ArgumentError.notNull();
              audio.attachSettings(settings);
              audio.attachLifecycleNotifier(lifecycleNotifier);
              return audio;
            },
            dispose: (context, audio) => audio.dispose(),
          ),
          ChangeNotifierProvider(create: (context) => ThemeProvider()),
          Provider(
            create: (context) => Palette(),
          ),
        ],
        child: Builder(builder: (context) {
          final palette = context.watch<Palette>();
          final themeProvider = Provider.of<ThemeProvider>(context);

          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'GeoTrivia',
            themeMode: themeProvider.themeMode,
            theme: MyThemes.lightTheme,
            darkTheme: MyThemes.darkTheme,
            routeInformationParser: _router.routeInformationParser,
            routerDelegate: _router.routerDelegate,
            scaffoldMessengerKey: scaffoldMessengerKey,
          );
        }),
      ),
    );
  }
}
