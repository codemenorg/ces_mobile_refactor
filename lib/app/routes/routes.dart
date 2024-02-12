import 'package:api/api.dart';
import 'package:ces/counter/counter.dart';
import 'package:ces/markets/markets.dart';
import 'package:flutter/material.dart';

class Routes {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case CounterPage.route:
        return MaterialPageRoute(
          builder: (context) => const CounterPage(),
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
