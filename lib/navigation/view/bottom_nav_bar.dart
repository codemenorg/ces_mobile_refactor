import 'dart:io';

import 'package:app_ui/app_ui.dart';
import 'package:ces/counter/view/counter_page.dart';
import 'package:ces/home/home.dart';
import 'package:ces/markets/view/markets_page.dart';
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

  final bool _isFisrtBuild = true;
  //final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  final List<StatefulWidget> _screens = [
    const HomePage(),
    const MarketsPage(),
    const CounterPage(),
    const MarketsPage(),
    const CounterPage(),
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
          backgroundColor: AppColors.yellow,
          selectedItemColor: AppColors.black,
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shop),
              label: 'Markets',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.currency_exchange),
              label: 'Trade',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.wallet),
              label: 'Wallet',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
