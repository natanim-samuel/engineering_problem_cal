import 'package:flutter/material.dart';
import '../model/loadRecord.dart';

class ResultCard extends StatelessWidget {
  final LoadRecord record;

  const ResultCard({
    super.key,
    required this.record,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔹 TITLE
          Text(
            record.applianceName,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          // 🔹 DATA
          _resultRow('Voltage', '${record.voltage.toStringAsFixed(2)} V'),
          _resultRow('Current', '${record.current.toStringAsFixed(2)} A'),
          _resultRow('Power', '${record.power.toStringAsFixed(2)} W'),
          _resultRow(
            'Daily Energy',
            '${record.dailyEnergy.toStringAsFixed(3)} kWh',
          ),
          _resultRow(
            'Monthly Energy',
            '${record.monthlyEnergy.toStringAsFixed(3)} kWh',
          ),

          const SizedBox(height: 12),

          // 🔹 COST HIGHLIGHT
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.green.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Monthly Cost",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                Text(
                  "\$${record.monthlyCost.toStringAsFixed(2)}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 🔹 THIS IS _resultRow (YOU WERE ASKING ABOUT THIS)
  Widget _resultRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}