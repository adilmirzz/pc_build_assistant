class PowerSupplyModel {
  final String brand;
  final String category;
  final String efficiencyRating;
  final String formFactor;
  final String modular;
  final String name;
  final int price;
  final String wattage;

  PowerSupplyModel({
    required this.brand,
    required this.category,
    required this.efficiencyRating,
    required this.formFactor,
    required this.modular,
    required this.name,
    required this.price,
    required this.wattage,
  });

  factory PowerSupplyModel.fromFirestore(Map<String, dynamic> data) {
    return PowerSupplyModel(
      brand: data['brand'] ?? '',
      category: data['category'] ?? '',
      efficiencyRating: data['efficiency_rating'] ?? '',
      formFactor: data['form_factor'] ?? '',
      modular: data['modular'] ?? '',
      name: data['name'] ?? '',
      price: data['price'] ?? 0,
      wattage: data['wattage'] ?? '',
    );
  }
}
