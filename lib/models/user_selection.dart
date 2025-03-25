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
    if (category == 'motherboards' && selectedParts['processors'] == null) {
      print("Please select a processor first.");
      return;
    }
    if (category == 'ram' && selectedParts['motherboards'] == null) {
      print("Please select a motherboard first.");
      return;
    }
    if (category == 'gpu' && selectedParts['motherboards'] == null) {
      print("Please select a motherboard before choosing a GPU.");
      return;
    }
    if (category == 'cpu_cooler' && selectedParts['processors'] == null) {
      print("Please select a processor before choosing a CPU cooler.");
      return;
    }
    if (category == 'case' && selectedParts['motherboards'] == null) {
      print("Please select a motherboard before choosing a case.");
      return;
    }
    if (category == 'case_fan' && selectedParts['case'] == null) {
      print("Please select a case before choosing case fans.");
      return;
    }
    if (category == 'powersupply' && selectedParts['processors'] == null) {
      print("Please select a processor before choosing a power supply.");
      return;
    }
    if (category == 'storage' && selectedParts['motherboards'] == null) {
      print("Please select a motherboard before choosing storage.");
      return;
    }

    selectedParts[category] = part;
    print("$category selected: ${part.name}");
    notifyListeners();
  }

  bool isPartCompatible(String category, PCPart part) {
    final motherboard = selectedParts['motherboards'];
    final processor = selectedParts['processors'];

    if (category == 'ram' && motherboard != null) {
      final motherboardChipset = motherboard.additionalFields['chipset'];
      final compatibleChipsets = List<String>.from(part.additionalFields['compatibleChipsets'] ?? []);
      print("Motherboard Chipset: $motherboardChipset, Compatible Chipsets: $compatibleChipsets");
      return compatibleChipsets.contains(motherboardChipset);
    }

    if (category == 'gpu' && motherboard != null) {
      return motherboard.additionalFields['gpu_compatibility'] == part.type;
    }

    if (category == 'case' && motherboard != null) {
      return part.formFactor == motherboard.formFactor;
    }

    if (category == 'cpu_cooler' && processor != null) {
      return part.additionalFields['socket'] == processor.additionalFields['socket'];
    }

    if (category == 'case_fan' && part.additionalFields['fan_size'] != null) {
      final casePart = selectedParts['case'];
      return casePart != null &&
             casePart.additionalFields['fan_support'].contains(part.additionalFields['fan_size']);
    }

    return true;
  }

  void clearSelection() {
    selectedParts.forEach((key, _) => selectedParts[key] = null);
    notifyListeners();
  }
}
