import 'package:flutter/material.dart';
import '../model/loadRecord.dart';
import '../services/storageService.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  late Future<List<LoadRecord>> _historyFuture;
  bool _sortNewestFirst = true;

  @override
  void initState() {
    super.initState();
    _historyFuture = StorageService.getRecords();
  }

  void _refresh() {
    setState(() {
      _historyFuture = StorageService.getRecords();
    });
  }

  Future<void> _clearHistory() async {
    await StorageService.clearHistory();
    _refresh();
  }

  Future<void> _deleteRecord(LoadRecord record) async {
    await StorageService.deleteRecord(record.id);
    _refresh();
  }

  Widget _emptyState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.history, size: 70, color: Colors.grey),
          SizedBox(height: 10),
          Text("No history yet",
              style: TextStyle(fontSize: 16, color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _list(List<LoadRecord> records) {
    records.sort((a, b) => _sortNewestFirst
        ? b.createdAt.compareTo(a.createdAt)
        : a.createdAt.compareTo(b.createdAt));

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: records.length,
      itemBuilder: (_, i) => HistoryCard(
        record: records[i],
        onDelete: () => _deleteRecord(records[i]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),

      // 🔥 MODERN HEADER
      appBar:  PreferredSize(
        preferredSize: const Size.fromHeight(120),
        child: AppBar(
          elevation: 0,
          flexibleSpace: Container(
            padding: const EdgeInsets.only(top: 50, left: 16, right: 16),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF6A5AE0), Color(0xFF8E7CFF)],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                SizedBox(height: 20),
                Text(
                  "Calculation History",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "Your recent calculations",
                  style: TextStyle(color: Colors.white70),
                )
              ],
            ),
          ),

          actions: [
            PopupMenuButton<String>(
              icon: const Icon(Icons.more_vert, color: Colors.white),
              onSelected: (value) {
                if (value == "sort") {
                  setState(() {
                    _sortNewestFirst = !_sortNewestFirst;
                  });
                } else if (value == "clear") {
                  _clearHistory();
                }
              },
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: "sort",
                  child: Text("Sort (toggle)"),
                ),
                const PopupMenuItem(
                  value: "clear",
                  child: Text("Clear history"),
                ),
              ],
            )
          ],
        ),
      ),

      body: FutureBuilder<List<LoadRecord>>(
        future: _historyFuture,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final records = snapshot.data!;
          if (records.isEmpty) return _emptyState();

          return _list(records);
        },
      ),
    );
  }
}
class HistoryCard extends StatefulWidget {
  final LoadRecord record;
  final VoidCallback onDelete;

  const HistoryCard({
    super.key,
    required this.record,
    required this.onDelete,
  });

  @override
  State<HistoryCard> createState() => _HistoryCardState();
}

class _HistoryCardState extends State<HistoryCard>
    with SingleTickerProviderStateMixin {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    final r = widget.record;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: expanded
              ? [Colors.white, Colors.grey.shade100]
              : [Colors.white, Colors.white],
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 15,
            offset: const Offset(0, 5),
            color: Colors.black.withOpacity(0.05),
          )
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.deepPurple.shade50,
                child: const Icon(Icons.devices, color: Colors.deepPurple),
              ),
              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(r.applianceName,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    Text(
                      "${r.createdAt.day}/${r.createdAt.month}/${r.createdAt.year}",
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),

              IconButton(
                icon: const Icon(Icons.delete_outline, color: Colors.red),
                onPressed: widget.onDelete,
              ),

              IconButton(
                icon: Icon(
                  expanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                ),
                onPressed: () {
                  setState(() => expanded = !expanded);
                },
              ),
            ],
          ),

          const SizedBox(height: 10),

          // 💰 COST CARD
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Monthly Cost"),
                Text(
                  "\$${r.monthlyCost.toStringAsFixed(2)}",
                  style: const TextStyle(
                      color: Colors.green, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),

          AnimatedCrossFade(
            duration: const Duration(milliseconds: 300),
            crossFadeState: expanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            firstChild: const SizedBox(),
            secondChild: Column(
              children: [
                _row("Voltage", "${r.voltage} V"),
                _row("Current", "${r.current} A"),
                _row("Power", "${r.power} W"),
                _row("Daily Energy", "${r.dailyEnergy} kWh"),
                _row("Monthly Energy", "${r.monthlyEnergy} kWh"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _row(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(top: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}