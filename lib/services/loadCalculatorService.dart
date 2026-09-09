import '../model/loadRecord.dart';
class LoadCalculatorService {
  static LoadRecord calculate({
    required String applianceName,
    required double voltage,
    required double current,
    required double hoursPerDay,
    required double ratePerKwh,
  }) {
    final double power = voltage * current;
    final double dailyEnergy = (power * hoursPerDay) / 1000;
    final double monthlyEnergy = dailyEnergy * 30;
    final double monthlyCost = monthlyEnergy * ratePerKwh;
    return LoadRecord(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      applianceName: applianceName,
      voltage: voltage,
      current: current,
      power: power,
      hoursPerDay: hoursPerDay,
      dailyEnergy: dailyEnergy,
      monthlyEnergy: monthlyEnergy,
      monthlyCost: monthlyCost,
      createdAt: DateTime.now(),
    );
  }
}