import 'package:app_ui/app_ui.dart';
import 'package:ces/app/routes/routes.dart';
import 'package:ces/l10n/l10n.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.light,
        theme: const AppTheme().themeData,
        darkTheme: const AppDarkTheme().themeData,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        onGenerateRoute: Routes.onGenerateRoute,
      ),
    );
  }
}
