class GpuModel {
  final String baseClock;
  final String boostClock;
  final String brand;
  final String category;
  final String interface;
  final String memory;
  final String name;
  final List<String> ports;
  final int price;
  final String tdp;

  GpuModel({
    required this.baseClock,
    required this.boostClock,
    required this.brand,
    required this.category,
    required this.interface,
    required this.memory,
    required this.name,
    required this.ports,
    required this.price,
    required this.tdp,
  });

  factory GpuModel.fromFirestore(Map<String, dynamic> data) {
    return GpuModel(
      baseClock: data['base_clock'] ?? '',
      boostClock: data['boost_clock'] ?? '',
      brand: data['brand'] ?? '',
      category: data['category'] ?? '',
      interface: data['interface'] ?? '',
      memory: data['memory'] ?? '',
      name: data['name'] ?? '',
      ports: List<String>.from(data['ports'] ?? []),
      price: data['price'] ?? 0,
      tdp: data['tdp'] ?? '',
    );
  }
}
