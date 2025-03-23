class MotherboardModel {
  final String brand;
  final String category;
  final String chipset;
  final String formFactor;
  final int m2Slots;
  final String maxMemory;
  final int memorySlots;
  final String name;
  final int pciSlots;
  final int price;
  final String socket;

  MotherboardModel({
    required this.brand,
    required this.category,
    required this.chipset,
    required this.formFactor,
    required this.m2Slots,
    required this.maxMemory,
    required this.memorySlots,
    required this.name,
    required this.pciSlots,
    required this.price,
    required this.socket,
  });

  factory MotherboardModel.fromFirestore(Map<String, dynamic> data) {
    return MotherboardModel(
      brand: data['brand'] ?? '',
      category: data['category'] ?? '',
      chipset: data['chipset'] ?? '',
      formFactor: data['form_factor'] ?? '',
      m2Slots: data['m2_slots'] ?? 0,
      maxMemory: data['max_memory'] ?? '',
      memorySlots: data['memory_slots'] ?? 0,
      name: data['name'] ?? '',
      pciSlots: data['pci_slots'] ?? 0,
      price: data['price'] ?? 0,
      socket: data['socket'] ?? '',
    );
  }
}
