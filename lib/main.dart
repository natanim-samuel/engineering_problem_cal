import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/app_localizations.dart';
import 'screens/screen1.dart';


void main() {
  runApp(const ElectricalLoadApp());
}

class ElectricalLoadApp extends StatefulWidget {
  const ElectricalLoadApp({super.key});

  static void setLocale(BuildContext context, Locale locale) {
    final state =
    context.findAncestorStateOfType<_ElectricalLoadAppState>();
    state?.setLocale(locale);
  }

  @override
  State<ElectricalLoadApp> createState() => _ElectricalLoadAppState();
}

class _ElectricalLoadAppState extends State<ElectricalLoadApp> {
  Locale _locale = const Locale('en');

  void setLocale(Locale locale) {
    setState(() => _locale = locale);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Electrical Load Calculator',
      debugShowCheckedModeBanner: false,
      locale: _locale,

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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),

      home: const screen1(),
    );
  }
}