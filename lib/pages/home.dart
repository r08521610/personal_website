import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:personal_website/i18n.dart';
import 'package:personal_website/widgets/name_card.dart';
import 'package:personal_website/widgets/toggle.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [],
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              NameCard(),
              Toggle<AdaptiveThemeMode>(
                items: AdaptiveThemeMode.values,
                initialIndex: AdaptiveThemeMode.values
                    .indexOf(AdaptiveTheme.of(context).mode),
                onChange: (_, mode) {
                  AdaptiveTheme.of(context).setThemeMode(mode);
                },
                builder: (AdaptiveThemeMode mode) {
                  switch (mode) {
                    case AdaptiveThemeMode.dark:
                      return Icon(Icons.nights_stay_outlined);
                    case AdaptiveThemeMode.light:
                      return Icon(Icons.wb_sunny_outlined);
                    default:
                      return Icon(Icons.auto_fix_high);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
