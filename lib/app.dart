import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hivet/core/config/global_translations.dart';
import 'package:hivet/core/injection/service_locator.dart';
import 'package:hivet/core/routing/routing_service.dart';

import 'package:flutter/material.dart';
import 'package:hivet/core/routing/router.dart' as router;
import 'package:responsive_framework/responsive_framework.dart';

class App extends StatelessWidget {
  final String? language;
  final ThemeData? themeData;

  const App({Key? key, this.language, this.themeData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // LanguageBloc languageBloc = BlocProvider.of<LanguageBloc>(context);
    // SessionBloc sessionBloc = BlocProvider.of<SessionBloc>(context);

    // languageBloc.add(LanguageEvent.id);
    // StreamSubscription<ConnectivityResult> _connectivitySubscription =

    return MaterialApp(
      builder: (context, widget) => ResponsiveWrapper.builder(
          BouncingScrollWrapper.builder(context, widget!),
          maxWidth: 600,
          minWidth: 480,
          defaultScale: true,
          breakpoints: [
            ResponsiveBreakpoint.resize(350, name: MOBILE),
            ResponsiveBreakpoint.resize(500, name: TABLET),
            ResponsiveBreakpoint.resize(600, name: DESKTOP),
          ],
          background: Container(color: Color(0xFFF5F5F5))),
      debugShowCheckedModeBanner: false,
      locale: language != null ? Locale(language!, '') : allTranslations.locale,
      localizationsDelegates: [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: allTranslations.supportedLocales(),
      theme: themeData,
      onGenerateRoute: router.generateRoute,
      initialRoute: '/',
      navigatorKey: g<RoutingService>().navigatorKey,
    );

    // return HomeNavigationBuilder(
    //   builder: (context, tabItem) {
    //     if (tabItem == TabItem.album) {
    //       return AlbumPage(mode: 0);
    //     } else if (tabItem == TabItem.favourites) {
    //       return AlbumPage(mode: 1);
    //     } else {
    //       return AlbumPage(mode: 2);
    //     }
    //   },
    // );
  }
}
