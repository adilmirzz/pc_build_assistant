import 'package:cloud_firestore/cloud_firestore.dart';

class PCPart {
  final String name;
  final String category;
  final double price;
  final String brand;
  final String formFactor;
  final bool rgb;
  final String sidePanel;
  final String type;
  final Map<String, dynamic> additionalFields;

  PCPart({
    required this.name,
    required this.category,
    required this.price,
    required this.brand,
    required this.formFactor,
    required this.rgb,
    required this.sidePanel,
    required this.type,
    required this.additionalFields,
  });

  factory PCPart.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return PCPart(
      name: data['name'] ?? '',
      category: data['category'] ?? '',
      price: data['price']?.toDouble() ?? 0.0,
      brand: data['brand'] ?? '',
      formFactor: data['form_factor'] ?? '',
      rgb: data['rgb'] ?? false,
      sidePanel: data['side_panel'] ?? '',
      type: data['type'] ?? '',
      additionalFields: Map<String, dynamic>.from(data),
    );
  }
}