import 'package:flutter/material.dart';
import '../model/loadRecord.dart';
import '../services/loadCalculatorService.dart';
import '../widget/resultCard.dart';
import '../services/storageService.dart';
import 'HistoryScreen.dart';
import '../l10n/app_localizations.dart';
import '../main.dart'; // for ElectricalLoadApp.setLocale

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final _formKey = GlobalKey<FormState>();

  final _applianceController = TextEditingController();
  final _voltageController = TextEditingController();
  final _currentController = TextEditingController();
  final _hoursController = TextEditingController();
  final _rateController = TextEditingController();

  LoadRecord? _record;

  @override
  void dispose() {
    _applianceController.dispose();
    _voltageController.dispose();
    _currentController.dispose();
    _hoursController.dispose();
    _rateController.dispose();
    super.dispose();
  }

  // 🔹 CALCULATE
  Future<void> _calculateLoad() async {
    if (!_formKey.currentState!.validate()) return;

    final result = LoadCalculatorService.calculate(
      applianceName: _applianceController.text.trim(),
      voltage: double.parse(_voltageController.text),
      current: double.parse(_currentController.text),
      hoursPerDay: double.parse(_hoursController.text),
      ratePerKwh: double.parse(_rateController.text),
    );

    await StorageService.saveRecord(result);

    setState(() => _record = result);

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(AppLocalizations.of(context)!.saved),
      ),
    );
  }

  // 🔹 CLEAR
  void _clearForm() {
    _applianceController.clear();
    _voltageController.clear();
    _currentController.clear();
    _hoursController.clear();
    _rateController.clear();

    setState(() => _record = null);
  }

  // 🔹 VALIDATORS
  String? _validateText(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Required';
    }
    return null;
  }

  String? _validateNumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Required';
    }

    final number = double.tryParse(value);

    if (number == null) return 'Invalid number';
    if (number <= 0) return 'Must be > 0';

    return null;
  }

  // 🔹 MODERN FIELD
  Widget _modernField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    required String? Function(String?) validator,
    TextInputType keyboardType =
    const TextInputType.numberWithOptions(decimal: true),
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(14),
      ),
      child: TextFormField(
        controller: controller,
        validator: validator,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          icon: Icon(icon, color: const Color(0xFF6A5AE0)),
          border: InputBorder.none,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF6A5AE0), Color(0xFF8E7CFF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // 🔹 HEADER
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      loc.calculator,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Row(
                      children: [
                        // 🌍 LANGUAGE SWITCH
                        DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value:
                            Localizations.localeOf(context).languageCode,
                            dropdownColor: Colors.deepPurple,
                            icon: const Icon(Icons.language,
                                color: Colors.white),
                            items: const [
                              DropdownMenuItem(
                                  value: 'en', child: Text('EN')),
                              DropdownMenuItem(
                                  value: 'am', child: Text('AM')),
                            ],
                            onChanged: (value) {
                              if (value != null) {
                                ElectricalLoadApp.setLocale(
                                  context,
                                  Locale(value),
                                );
                              }
                            },
                          ),
                        ),

                        const SizedBox(width: 8),

                        // HISTORY
                        IconButton(
                          icon:
                          const Icon(Icons.history, color: Colors.white),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const HistoryScreen(),
                              ),
                            );
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),

              // 🔹 BODY
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                    BorderRadius.vertical(top: Radius.circular(30)),
                  ),
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          // TEXT FIELD
                          _modernField(
                            controller: _applianceController,
                            label: loc.applianceName,
                            hint: loc.applianceHint,
                            icon: Icons.home,
                            validator: _validateText,
                            keyboardType: TextInputType.text,
                          ),

                          _modernField(
                            controller: _voltageController,
                            label: loc.voltage,
                            hint: "230",
                            icon: Icons.bolt,
                            validator: _validateNumber,
                          ),

                          _modernField(
                            controller: _currentController,
                            label: loc.current,
                            hint: "0.5",
                            icon: Icons.electric_meter,
                            validator: _validateNumber,
                          ),

                          _modernField(
                            controller: _hoursController,
                            label: loc.hours,
                            hint: "8",
                            icon: Icons.access_time,
                            validator: _validateNumber,
                          ),

                          _modernField(
                            controller: _rateController,
                            label: loc.rate,
                            hint: "0.12",
                            icon: Icons.attach_money,
                            validator: _validateNumber,
                          ),

                          const SizedBox(height: 20),

                          // BUTTON
                          SizedBox(
                            width: double.infinity,
                            height: 55,
                            child: ElevatedButton(
                              onPressed: _calculateLoad,
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                const Color(0xFF6A5AE0),
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(16),
                                ),
                              ),
                              child: Text(loc.calculate),
                            ),
                          ),

                          const SizedBox(height: 10),

                          TextButton(
                            onPressed: _clearForm,
                            child: Text(loc.clear),
                          ),

                          if (_record != null)
                            ResultCard(record: _record!),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}