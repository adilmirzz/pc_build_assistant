class CaseModel {
  final String brand;
  final String category;
  final String formFactor;
  final String name;
  final int price;
  final bool rgb;
  final String sidePanel;
  final String type;

  CaseModel({
    required this.brand,
    required this.category,
    required this.formFactor,
    required this.name,
    required this.price,
    required this.rgb,
    required this.sidePanel,
    required this.type,
  });

  factory CaseModel.fromFirestore(Map<String, dynamic> data) {
    return CaseModel(
      brand: data['brand'] ?? '',
      category: data['category'] ?? '',
      formFactor: data['form_factor'] ?? '',
      name: data['name'] ?? '',
      price: data['price'] ?? 0,
      rgb: data['rgb'] ?? false,
      sidePanel: data['side_panel'] ?? '',
      type: data['type'] ?? '',
    );
  }
}
