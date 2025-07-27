import 'dart:async';
import 'dart:io';
import 'package:adhdo_it_mob/config/router/app_route.dart';
import 'package:adhdo_it_mob/config/theme/theme.dart';
import 'package:adhdo_it_mob/core/push_notifications_manager.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:adhdo_it_mob/app/offline_indicator_widget.dart';
import 'package:adhdo_it_mob/config/router/router.dart';
import 'package:adhdo_it_mob/data/storage/local_storage.dart';
import 'package:adhdo_it_mob/l10n/app_localizations.dart';
import 'package:adhdo_it_mob/providers/user_providers.dart';

class App extends StatefulHookConsumerWidget {
  const App({super.key});

  @override
  ConsumerState<App> createState() => _AppState();

  // ignore: library_private_types_in_public_api
  static _AppState of(BuildContext context) =>
      context.findAncestorStateOfType<_AppState>()!;
  static AppTheme appTheme(BuildContext context) => of(context)._appTheme;
}

class _AppState extends ConsumerState<App> {
  AppTheme _appTheme = AppTheme.defaultTheme;

  late GoRouter _router;
  late final Locale _locale = LocalStorage().locale ?? const Locale('ru');
  Locale get locale => _locale;
  ConnectionStatus connectionStatus = ConnectionStatus.connected;
  late StreamSubscription subscription;
  bool isEnableFunction = false;

  @override
  void initState() {
    super.initState();
    listenInternetConnection();
    _router = buildRouter(
      context,
      LocalStorage().token != null ? Routes.home() : Routes.login(),
    );
    _appTheme = AppTheme.fromType(LocalStorage().themeType);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // PushNotificationsManager(_router, context).init();
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(userProvider, (prevState, nextState) {
      if (prevState?.authStatus.isAuth == true &&
          nextState.authStatus.isUnauth) {
        _router.go('');
      }
    });
    return ScaffoldMessenger(
      child: MaterialApp.router(
        title: 'ADHDo.it',
        debugShowCheckedModeBanner: false,
        locale: _locale,
        localizationsDelegates: Strings.localizationsDelegates,
        supportedLocales: Strings.supportedLocales,
        routerDelegate: _router.routerDelegate,
        routeInformationParser: _router.routeInformationParser,
        routeInformationProvider: _router.routeInformationProvider,
        theme: _appTheme.themeData,
        builder: (context, child) {
          final bottomSafeArea = MediaQuery.of(context).padding.bottom;
          final isDarkMode =
              MediaQuery.of(context).platformBrightness == Brightness.dark;
          return AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle(
              systemNavigationBarColor:
                  isDarkMode ? Colors.black : Colors.white,
              systemNavigationBarIconBrightness:
                  isDarkMode ? Brightness.light : Brightness.dark,
            ),
            child: Column(
              children: [
                Expanded(child: child!),
                if (Platform.isAndroid)
                  AnimatedCrossFade(
                    duration: const Duration(milliseconds: 300),
                    crossFadeState:
                        connectionStatus.isConnected
                            ? CrossFadeState.showFirst
                            : CrossFadeState.showSecond,
                    firstChild: const SizedBox.shrink(),
                    secondChild: Padding(
                      padding: EdgeInsets.only(bottom: bottomSafeArea),
                      child: ConnectionIndicator(
                        isBackOnline: connectionStatus.isBackOnline,
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  void listenInternetConnection() {
    subscription = Connectivity().onConnectivityChanged.listen((event) {
      final hasConnection = !event.contains(ConnectivityResult.none);
      if (hasConnection) {
        if (!isEnableFunction) return;
        setState(() => connectionStatus = ConnectionStatus.backOnline);
        Timer(const Duration(seconds: 2), () {
          if (!mounted) return;
          setState(() => connectionStatus = ConnectionStatus.connected);
        });
      } else {
        setState(() => connectionStatus = ConnectionStatus.disconnected);
        isEnableFunction = true;
      }
    });
  }
}

enum ConnectionStatus {
  connected,
  disconnected,
  backOnline;

  bool get isConnected => this == connected;
  bool get isDisconnected => this == disconnected;
  bool get isBackOnline => this == backOnline;
}
