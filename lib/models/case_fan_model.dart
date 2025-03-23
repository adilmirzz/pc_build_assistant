class CaseFanModel {
  final String airflow;
  final String brand;
  final String category;
  final String name;
  final int price;
  final bool rgb;
  final String rpm;
  final String size;

  CaseFanModel({
    required this.airflow,
    required this.brand,
    required this.category,
    required this.name,
    required this.price,
    required this.rgb,
    required this.rpm,
    required this.size,
  });

  factory CaseFanModel.fromFirestore(Map<String, dynamic> data) {
    return CaseFanModel(
      airflow: data['airflow'] ?? '',
      brand: data['brand'] ?? '',
      category: data['category'] ?? '',
      name: data['name'] ?? '',
      price: data['price'] ?? 0,
      rgb: data['rgb'] ?? false,
      rpm: data['rpm'] ?? '',
      size: data['size'] ?? '',
    );
  }
}
