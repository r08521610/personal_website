import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:personal_website/constant/sizes.dart';
import 'package:personal_website/generated/l10n.dart';
import 'package:personal_website/pages/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final savedThemeMode = await AdaptiveTheme.getThemeMode();

  runApp(Sizes(child: MyApp(savedThemeMode: savedThemeMode)));
}

class MyApp extends StatefulWidget {
  final AdaptiveThemeMode? savedThemeMode;

  const MyApp({Key? key, this.savedThemeMode}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale? _defaultLocale;
  @override
  void initState() {
    super.initState();
    _checkDefaultLocale();
  }

  Future<void> _checkDefaultLocale() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final localeString = prefs.getStringList('locale');
    if (localeString != null && localeString.length > 0) {
      _defaultLocale = Locale(
          localeString.first, localeString.length > 1 ? localeString[1] : null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
        light: ThemeData.light(),
        dark: ThemeData.dark(),
        initial: widget.savedThemeMode ?? AdaptiveThemeMode.system,
        builder: (theme, darkTheme) {
          return MaterialApp(
            onGenerateTitle: (BuildContext context) => S.of(context).name,
            theme: theme,
            darkTheme: darkTheme,
            home: Home(),
            debugShowCheckedModeBanner: false,
            localizationsDelegates: [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            locale: _defaultLocale,
          );
        });
  }
}
