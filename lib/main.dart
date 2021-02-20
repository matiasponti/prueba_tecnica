import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marvel_app/pages/detail_page.dart';
import 'package:marvel_app/pages/home_page.dart';
import 'package:marvel_app/pages/settings_page.dart';
import 'package:marvel_app/pages/support_page.dart';
import 'package:marvel_app/utils/app_localization.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            fontFamily: GoogleFonts.montserrat().fontFamily,
            primaryColor: Colors.redAccent),
        debugShowCheckedModeBanner: false,
        title: 'Marvel App',
        initialRoute: '/',
        supportedLocales: [
          Locale("en", "US"),
          Locale("es", "ES"),
        ],
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate

        ],
        localeResolutionCallback: (locale, supportedLocales) {
          for (var supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale.languageCode &&
                supportedLocale.countryCode == locale.countryCode) {
              return supportedLocale;
            }
          }
          return supportedLocales.first;
        },
        routes: {
          '/': (BuildContext context) => HomePage(),
          'settings': (BuildContext context) => SettingsPage(),
          'support': (BuildContext context) => SupportPage(),
          'creators': (BuildContext context) => DetailPage(),
        });
  }
}
