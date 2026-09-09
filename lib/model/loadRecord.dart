class LoadRecord {
  final String id;
  final String applianceName;
  final double voltage;
  final double current;
  final double power;
  final double hoursPerDay;
  final double dailyEnergy;
  final double monthlyEnergy;
  final double monthlyCost;
  final DateTime createdAt;

  LoadRecord({
    required this.id,
    required this.applianceName,
    required this.voltage,
    required this.current,
    required this.power,
    required this.hoursPerDay,
    required this.dailyEnergy,
    required this.monthlyEnergy,
    required this.monthlyCost,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'applianceName': applianceName,
      'voltage': voltage,
      'current': current,
      'power': power,
      'hoursPerDay': hoursPerDay,
      'dailyEnergy': dailyEnergy,
      'monthlyEnergy': monthlyEnergy,
      'monthlyCost': monthlyCost,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory LoadRecord.fromJson(Map<String, dynamic> json) {
    return LoadRecord(
      id: json['id'] ?? DateTime.now().millisecondsSinceEpoch.toString(),
      applianceName: json['applianceName'],
      voltage: (json['voltage'] as num).toDouble(),
      current: (json['current'] as num).toDouble(),
      power: (json['power'] as num).toDouble(),
      hoursPerDay: (json['hoursPerDay'] as num).toDouble(),
      dailyEnergy: (json['dailyEnergy'] as num).toDouble(),
      monthlyEnergy: (json['monthlyEnergy'] as num).toDouble(),
      monthlyCost: (json['monthlyCost'] as num).toDouble(),
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}