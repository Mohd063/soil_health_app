import 'dart:math';

class BluetoothService {
  // In a real implementation, this would connect to an actual Bluetooth device
  // For this assignment, we'll mock the data

  Future<Map<String, double>> getSoilReadings() async {
    // Simulate Bluetooth connection delay
    await Future.delayed(const Duration(seconds: 2));
    
    // Generate random values for temperature and moisture
    Random random = Random();
    double temperature = 15.0 + random.nextDouble() * 25.0; // Between 15-40°C
    double moisture = random.nextDouble() * 100.0; // Between 0-100%
    
    return {
      'temperature': double.parse(temperature.toStringAsFixed(1)),
      'moisture': double.parse(moisture.toStringAsFixed(1)),
    };
  }

  // For a real implementation, you would add:
  // - Bluetooth device scanning
  // - Connection handling
  // - Data parsing from the actual device
}