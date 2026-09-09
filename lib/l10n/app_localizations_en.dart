// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get history => 'Calculation History';

  @override
  String get recent => 'Your recent calculations';

  @override
  String get monthlyCost => 'Monthly Cost';

  @override
  String get voltage => 'Voltage';

  @override
  String get current => 'Current';

  @override
  String get power => 'Power';

  @override
  String get dailyEnergy => 'Daily Energy';

  @override
  String get monthlyEnergy => 'Monthly Energy';

  @override
  String get noHistory => 'No history yet';

  @override
  String get clearHistory => 'Clear History';

  @override
  String get sort => 'Sort';

  @override
  String get calculator => 'Calculator';

  @override
  String get applianceName => 'Appliance Name';

  @override
  String get applianceHint => 'Fan, Heater, Motor';

  @override
  String get hours => 'Hours per Day';

  @override
  String get rate => 'Rate per kWh';

  @override
  String get calculate => 'Calculate';

  @override
  String get clear => 'Clear All';

  @override
  String get saved => 'Calculation saved to history';
}
