import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/app_localizations.dart';
import 'screen/calculatorScreen.dart';

void main() {
  runApp(const ElectricalLoadApp());
}

class ElectricalLoadApp extends StatefulWidget {
  const ElectricalLoadApp({super.key});

  // 🔥 THIS is what your CalculatorScreen is calling
  static void setLocale(BuildContext context, Locale newLocale) {
    final state =
    context.findAncestorStateOfType<_ElectricalLoadAppState>();
    state?.setLocale(newLocale);
  }

  @override
  State<ElectricalLoadApp> createState() => _ElectricalLoadAppState();
}

class _ElectricalLoadAppState extends State<ElectricalLoadApp> {
  Locale _locale = const Locale('en');

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: _locale, // 🔥 important

      debugShowCheckedModeBanner: false,
      title: 'Electrical Load Calculator',

      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      supportedLocales: const [
        Locale('en'),
        Locale('am'),
      ],

      theme: ThemeData(
        useMaterial3: true,
      ),

      home: const CalculatorScreen(),
    );
  }
}