import 'package:flutter/foundation.dart';
import 'package:soil_health_app/models/reading.dart';
import 'package:soil_health_app/services/bluetooth_service.dart';
import 'package:soil_health_app/services/firestore_service.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ReadingProvider with ChangeNotifier {
  final BluetoothService _bluetoothService = BluetoothService();
  final FirestoreService _firestoreService = FirestoreService();
  
  Reading? _latestReading;
  List<Reading> _readings = [];
  bool _isLoading = false;

  Reading? get latestReading => _latestReading;
  List<Reading> get readings => _readings;
  bool get isLoading => _isLoading;

  // Hive box for offline cache
  Box<dynamic> get _cacheBox => Hive.box('readingsBox');

  Future<void> fetchReadings(String userId) async {
    _isLoading = true;
    notifyListeners();
    
    try {
      // Try fetching from Firestore first
      var querySnapshot = await _firestoreService.getReadings(userId).first;
      _readings = querySnapshot;
      if (_readings.isNotEmpty) {
        _latestReading = _readings.first;
      }

      // Save to Hive for offline
      List<Map<String, dynamic>> cacheData =
          _readings.map((r) => r.toMap()).toList();
      await _cacheBox.put('readings_$userId', cacheData);
    } catch (e) {
      print("Error fetching readings from Firestore: $e");

      // If error (offline), load from Hive cache
      List<dynamic>? cached = _cacheBox.get('readings_$userId');
      if (cached != null) {
        _readings = cached
            .map((e) => Reading.fromMap(e['id'] ?? '', e))
            .toList();
        if (_readings.isNotEmpty) {
          _latestReading = _readings.first;
        }
      }
    }
    
    _isLoading = false;
    notifyListeners();
  }

  Future<void> takeReading(String userId) async {
    _isLoading = true;
    notifyListeners();
    
    try {
      Map<String, double> data = await _bluetoothService.getSoilReadings();
      
      Reading newReading = Reading(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        temperature: data['temperature']!,
        moisture: data['moisture']!,
        timestamp: DateTime.now(),
      );
      
      await _firestoreService.addReading(newReading, userId);
      
      _latestReading = newReading;
      _readings.insert(0, newReading);

      // Update Hive cache
      List<Map<String, dynamic>> cacheData =
          _readings.map((r) => r.toMap()).toList();
      await _cacheBox.put('readings_$userId', cacheData);

    } catch (e) {
      print("Error taking reading: $e");
    }
    
    _isLoading = false;
    notifyListeners();
  }

  Stream<List<Reading>> getReadings(String userId) {
    // Firestore stream with offline fallback
    return _firestoreService.getReadings(userId);
  }
}
