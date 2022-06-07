import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RoutingService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<dynamic> navigateTo(String routeName, {dynamic arguments}) {
    return navigatorKey.currentState!
        .pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> navigateToAndDeletePrev(String routeName,
      {dynamic arguments}) {
    return navigatorKey.currentState!.pushNamedAndRemoveUntil(
        routeName, (Route<dynamic> route) => false,
        arguments: arguments);
  }

  void navigatePopUntil(String routeName, {dynamic arguments}) {
    return navigatorKey.currentState!.popUntil((route) {
      return route.settings.name == routeName;
    });
  }

  void goBack() {
    return navigatorKey.currentState!.pop();
  }

  void goBackPopStack(dynamic arguments) {
    return navigatorKey.currentState!.pop(arguments);
  }
}
