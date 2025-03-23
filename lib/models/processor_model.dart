class ProcessorModel {
  final String baseClock;
  final String boostClock;
  final List<String> compatibleChipsets;
  final int cores;
  final String name;
  final int price;
  final String socket;
  final String tdp;

  ProcessorModel({
    required this.baseClock,
    required this.boostClock,
    required this.compatibleChipsets,
    required this.cores,
    required this.name,
    required this.price,
    required this.socket,
    required this.tdp,
  });

  factory ProcessorModel.fromFirestore(Map<String, dynamic> data) {
    return ProcessorModel(
      baseClock: data['base_clock'] ?? '',
      boostClock: data['boost_clock'] ?? '',
      compatibleChipsets: List<String>.from(data['compatible_chipsets'] ?? []),
      cores: data['cores'] ?? 0,
      name: data['name'] ?? '',
      price: data['price'] ?? 0,
      socket: data['socket'] ?? '',
      tdp: data['tdp'] ?? '',
    );
  }
}
