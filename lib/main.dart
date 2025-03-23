import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PCPartsScreen(),
    );
  }
}

class PCPartsScreen extends StatefulWidget {
  const PCPartsScreen({super.key});

  @override
  _PCPartsScreenState createState() => _PCPartsScreenState();
}

class _PCPartsScreenState extends State<PCPartsScreen> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  String selectedCategory = 'case';
  List<String> categories = [
    'case', 'case_fan', 'cpu_cooler', 'gpu', 
    'motherboards', 'powersupply', 'processors', 
    'ram', 'storage'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PC Parts Picker'),
        actions: [
          DropdownButton<String>(
            value: selectedCategory,
            onChanged: (value) {
              setState(() {
                selectedCategory = value!;
              });
            },
            items: categories.map((category) {
              return DropdownMenuItem<String>(
                value: category,
                child: Text(category),
              );
            }).toList(),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestore.collection(selectedCategory).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final parts = snapshot.data?.docs.map((doc) => PCPart.fromFirestore(doc)).toList() ?? [];

          if (parts.isEmpty) {
            return const Center(child: Text('No parts available'));
          }

          return ListView.builder(
            itemCount: parts.length,
            itemBuilder: (context, index) {
              final part = parts[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ListTile(
                  title: Text(part.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text('${part.category} - ₹${part.price.toStringAsFixed(2)}'),
                  onTap: () => showDetails(context, part),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void showDetails(BuildContext context, PCPart part) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(part.name),
        content: SingleChildScrollView(
          child: ListBody(
            children: part.additionalFields.entries.map((e) => Text('${e.key}: ${e.value}')).toList(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
