class RamModel {
  final String brand;
  final String capacity;
  final int modules;
  final String name;
  final int price;
  final String speed;
  final String type;
  final String voltage;

  RamModel({
    required this.brand,
    required this.capacity,
    required this.modules,
    required this.name,
    required this.price,
    required this.speed,
    required this.type,
    required this.voltage,
  });

  factory RamModel.fromFirestore(Map<String, dynamic> data) {
    return RamModel(
      brand: data['brand'] ?? '',
      capacity: data['capacity'] ?? '',
      modules: data['modules'] ?? 0,
      name: data['name'] ?? '',
      price: data['price'] ?? 0,
      speed: data['speed'] ?? '',
      type: data['type'] ?? '',
      voltage: data['voltage'] ?? '',
    );
  }
}
