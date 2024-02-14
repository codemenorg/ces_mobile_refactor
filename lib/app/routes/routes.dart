import 'package:api/api.dart';
import 'package:ces/counter/counter.dart';
import 'package:ces/home/home.dart';
import 'package:ces/markets/markets.dart';
import 'package:ces/profile/profile.dart';
import 'package:flutter/material.dart';

import '../../navigation/view/bottom_nav_bar.dart';

class Routes {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case NavigationScreen.route:
        return MaterialPageRoute(
          builder: (context) => const NavigationScreen(),
        );
      case CounterPage.route:
        return MaterialPageRoute(
          builder: (context) => const CounterPage(),
        );
      case HomePage.route:
        return MaterialPageRoute(
          builder: (context) => const HomePage(),
        );
      case ProfilePage.route:
        return MaterialPageRoute(
          builder: (context) => const ProfilePage(),
        );
      case MarketsPage.route:
        return MaterialPageRoute(
          builder: (context) => const MarketsPage(),
        );
      case MarketsTradePage.route:
        final marketsTrade = settings.arguments! as MarketTrades;
        return MaterialPageRoute(
          builder: (context) => MarketsTradePage(
            marketId: marketsTrade.marketId!,
          ),
        );
      default:
        return null;
    }
  }
}
