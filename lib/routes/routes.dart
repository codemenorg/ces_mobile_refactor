import 'package:ces/counter/counter.dart';
import 'package:flutter/material.dart';

class Routes {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case CounterPage.route:
        return MaterialPageRoute(
          builder: (context) => const CounterPage(),
        );
      default:
        return null;
    }
  }
}
