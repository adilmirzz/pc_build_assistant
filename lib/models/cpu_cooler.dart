class CpuCoolerModel {
  final String brand;
  final String category;
  final String fanSize;
  final String maxTdp;
  final String name;
  final int price;
  final String radiatorSize;
  final bool rgb;
  final List<String> socketCompatibility;
  final String type;

  CpuCoolerModel({
    required this.brand,
    required this.category,
    required this.fanSize,
    required this.maxTdp,
    required this.name,
    required this.price,
    required this.radiatorSize,
    required this.rgb,
    required this.socketCompatibility,
    required this.type,
  });

  factory CpuCoolerModel.fromFirestore(Map<String, dynamic> data) {
    return CpuCoolerModel(
      brand: data['brand'] ?? '',
      category: data['category'] ?? '',
      fanSize: data['fan_size'] ?? '',
      maxTdp: data['max_tdp'] ?? '',
      name: data['name'] ?? '',
      price: data['price'] ?? 0,
      radiatorSize: data['radiator_size'] ?? '',
      rgb: data['rgb'] ?? false,
      socketCompatibility: List<String>.from(data['socket_compatibility'] ?? []),
      type: data['type'] ?? '',
    );
  }
}
