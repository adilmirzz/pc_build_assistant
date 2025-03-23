import 'package:flutter/material.dart';
import 'summary.dart';

class PcPartsPicker extends StatefulWidget {
  final Map<String, dynamic>? previousBuild;

  const PcPartsPicker([this.previousBuild, Key? key]) : super(key: key);

  @override
  _PcPartsPickerState createState() => _PcPartsPickerState();
}

class _PcPartsPickerState extends State<PcPartsPicker> {
  final Map<String, Map<String, dynamic>> selectedComponents = {};
  int budget = 2500;
  int remainingBudget = 2500;

  @override
  void initState() {
    super.initState();
    if (widget.previousBuild != null) {
      setState(() {
        selectedComponents.addAll(Map<String, Map<String, dynamic>>.from(widget.previousBuild!));
        _calculateRemainingBudget();
      });
    }
  }

  void _calculateRemainingBudget() {
    int totalCost = selectedComponents.values.fold(0, (sum, item) => sum + (item['price'] as int));
    setState(() {
      remainingBudget = budget - totalCost;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("PC Parts Picker")),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: selectedComponents.keys.map((type) {
                return ListTile(
                  title: Text(type),
                  subtitle: Text("${selectedComponents[type]!['name']} (\$${selectedComponents[type]!['price']})"),
                );
              }).toList(),
            ),
          ),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => SummaryPage(selectedComponents)));
            },
            icon: const Icon(Icons.check_circle),
            label: const Text("Confirm Selection"),
          ),
        ],
      ),
    );
  }
}
