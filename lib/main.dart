import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';
import 'models/user_selection.dart';
import 'models/pc_part.dart';
import 'screens/selection_summary_screen.dart';


//this is my main.dart file


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print('Firebase initialized successfully');
  } catch (e) {
    print('Error initializing Firebase: $e');
  }

  runApp(
    ChangeNotifierProvider(
      create: (_) => UserSelection(),
      child: const MyApp(),
    ),
  );
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
                  IconButton(
                    icon: const Icon(Icons.checklist),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SelectionSummaryScreen()),
                      );
                    },
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
            print('Snapshot error: ${snapshot.error}');
            return Center(child: Text('❗ Error: ${snapshot.error}'));
          }

          try {
            final parts = snapshot.data?.docs.map((doc) => PCPart.fromFirestore(doc)).toList() ?? [];

            if (parts.isEmpty) {
              return Center(child: Text('🛑 No parts available in $selectedCategory'));
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
                   onTap: () {
                              final userSelection = Provider.of<UserSelection>(context, listen: false);
                              if (userSelection.isPartCompatible(selectedCategory, part)) {
                                userSelection.selectPart(selectedCategory, part);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('${part.name} selected for $selectedCategory')),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('${part.name} is not compatible with the selected parts.')),
                                );
                              }
                                showDetails(context, part);
                              },
                  ),
                );
              },
            );
          } catch (e) {
            print('❗ Error during data mapping: $e');
            return Center(child: Text('Error: $e'));
          }
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
