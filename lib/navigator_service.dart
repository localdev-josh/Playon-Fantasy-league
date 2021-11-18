import 'package:flutter/material.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey =
  new GlobalKey<NavigatorState>();
  Future<dynamic> navigateToNamed(String routeName) {
    return navigatorKey.currentState.pushNamed(routeName);
  }

  Future<dynamic> navigateTo(Route<dynamic> route) {
    return navigatorKey.currentState.push(route);
  }
}