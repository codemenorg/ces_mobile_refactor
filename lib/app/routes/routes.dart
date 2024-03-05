import 'package:api/api.dart';
import 'package:ces/counter/counter.dart';
import 'package:ces/home/home.dart';
import 'package:ces/markets/markets.dart';
import 'package:ces/navigation/view/bottom_nav_bar.dart';
import 'package:ces/profile/view/profile_page.dart';
import 'package:ces/trade/view/trade_page.dart';
import 'package:ces/wallet/view/wallet_page.dart';
import 'package:flutter/material.dart';

class Routes {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case NavigationScreen.route:
        return MaterialPageRoute(
          builder: (context) => const NavigationScreen(),
          settings: settings,
        );
      case WalletPage.route:
        return MaterialPageRoute(
          builder: (context) => const WalletPage(),
          settings: settings,
        );
      case TradePage.route:
        return MaterialPageRoute(
          builder: (context) => const TradePage(),
          settings: settings,
        );
      case CounterPage.route:
        return MaterialPageRoute(
          builder: (context) => const CounterPage(),
          settings: settings,
        );
      case HomePage.route:
        return MaterialPageRoute(
          builder: (context) => const HomePage(),
          settings: settings,
        );
      case ProfilePage.route:
        return MaterialPageRoute(
          builder: (context) => const ProfilePage(),
          settings: settings,
        );
      case MarketsPage.route:
        return MaterialPageRoute(
          builder: (context) => const MarketsPage(),
          settings: settings,
        );
      case MarketsTradePage.route:
        final marketsTrade = settings.arguments! as MarketTrades;
        return MaterialPageRoute(
          builder: (context) => MarketsTradePage(
            marketId: marketsTrade.marketId!,
          ),
          settings: settings,
        );
      default:
        return null;
    }
  }
}
