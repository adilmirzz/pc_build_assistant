import 'package:flutter/material.dart';
import '../main.dart';
import 'pc_part.dart';

class UserSelection with ChangeNotifier {
  final Map<String, PCPart?> selectedParts = {
    'case': null,
    'case_fan': null,
    'cpu_cooler': null,
    'gpu': null,
    'motherboards': null,
    'powersupply': null,
    'processors': null,
    'ram': null,
    'storage': null,
  };

  void selectPart(String category, PCPart part) {
    selectedParts[category] = part;
    notifyListeners();
  }

  bool isPartCompatible(String category, PCPart part) {
    final motherboard = selectedParts['motherboards'];
    final processor = selectedParts['processors'];

    if (category == 'gpu' && motherboard != null) {
      return motherboard.additionalFields['gpu_compatibility'] == part.type;
    }
    if (category == 'ram' && motherboard != null) {
      return motherboard.additionalFields['ram_type'] == part.type;
    }
    if (category == 'case' && motherboard != null) {
      return part.formFactor == motherboard.formFactor;
    }
    if (category == 'cpu_cooler' && processor != null) {
      return part.additionalFields['socket'] == processor.additionalFields['socket'];
    }
    if (category == 'case_fan' && part.additionalFields['fan_size'] != null) {
      final casePart = selectedParts['case'];
      return casePart != null && casePart.additionalFields['fan_support'].contains(part.additionalFields['fan_size']);
    }
    return true;
  }

  void clearSelection() {
    selectedParts.forEach((key, _) => selectedParts[key] = null);
    notifyListeners();
  }
} 
