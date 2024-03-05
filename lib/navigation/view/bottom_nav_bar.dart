import 'dart:io';

import 'package:app_ui/app_ui.dart';
import 'package:ces/home/home.dart';
import 'package:ces/markets/view/markets_page.dart';
import 'package:ces/profile/view/profile_page.dart';
import 'package:ces/trade/view/trade_page.dart';
import 'package:ces/wallet/view/wallet_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({
    super.key,
    this.pageNum,
  });
  final Widget? pageNum;
  static const route = '/';
  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  //Variable for navigation Index
  int _currentIndex = 0;

  //Variable for navigation Color Index
  // ignore: unused_field
  int _colorIndex = 0;

  bool _isFisrtBuild = true;

  final List<StatefulWidget> _screens = [
    const HomePage(),
    const MarketsPage(),
    const TradePage(),
    const WalletPage(),
    const ProfilePage(),
    const TradePage(),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Object? args;
    StatefulWidget? screenPage;
    if (_isFisrtBuild) {
      args = ModalRoute.of(context)!.settings.arguments;
    }
    if (args != null) {
      _colorIndex = 5;
      screenPage = args as StatefulWidget;
      var newColorindex = -1;

      for (var element in _screens) {
        newColorindex++;
        if (element.toString() == screenPage.toString()) {
          _colorIndex = newColorindex;
          _currentIndex = newColorindex;
          break;
        }
      }
    }

    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) async {
        await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(
              'Do you want to exit the app?',
              textAlign: TextAlign.center,
              style: UITextStyle.bodyText1.copyWith(color: AppColors.black),
            ),
            actions: [
              SizedBox(
                width: 100,
                child: ElevatedButton(
                  onPressed: () {
                    if (Platform.isAndroid) {
                      SystemNavigator.pop();
                    } else if (Platform.isIOS) {
                      exit(0);
                    }
                  },
                  child: const Text('Yes'),
                ),
              ),
              const SizedBox(
                height: AppSpacing.md,
              ), // Adding some space between the buttons
              SizedBox(
                width: 100,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: const Text('No'),
                ),
              ),
            ],
          ),
        );
      },
      child: Scaffold(
        extendBody: true,
        body: Center(
          child: (screenPage != null)
              ? screenPage
              : _screens.elementAt(_currentIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: AppColors.background,
          selectedItemColor: AppColors.yellow,
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _isFisrtBuild = false;
              _currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.home),
              label: 'Home',
              activeIcon: Container(
                padding: const EdgeInsets.all(3),
                decoration: const BoxDecoration(
                  color: AppColors.yellow,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: const Icon(
                  Icons.home,
                  color: AppColors.white,
                ),
              ),
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.shop),
              label: 'Markets',
              activeIcon: Container(
                padding: const EdgeInsets.all(3),
                decoration: const BoxDecoration(
                  color: AppColors.yellow,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: const Icon(
                  Icons.shop,
                  color: AppColors.white,
                ),
              ),
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.currency_exchange),
              label: 'Trade',
              activeIcon: Container(
                padding: const EdgeInsets.all(3),
                decoration: const BoxDecoration(
                  color: AppColors.yellow,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: const Icon(
                  Icons.currency_exchange,
                  color: AppColors.white,
                ),
              ),
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.wallet),
              label: 'Wallet',
              activeIcon: Container(
                padding: const EdgeInsets.all(3),
                decoration: const BoxDecoration(
                  color: AppColors.yellow,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: const Icon(
                  Icons.wallet,
                  color: AppColors.white,
                ),
              ),
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.person),
              label: 'Profile',
              activeIcon: Container(
                padding: const EdgeInsets.all(3),
                decoration: const BoxDecoration(
                  color: AppColors.yellow,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: const Icon(
                  Icons.person,
                  color: AppColors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
