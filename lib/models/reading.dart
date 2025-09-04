import 'package:cloud_firestore/cloud_firestore.dart';

class Reading {
  final String id;
  final double temperature;
  final double moisture;
  final DateTime timestamp;

  Reading({
    required this.id,
    required this.temperature,
    required this.moisture,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'temperature': temperature,
      'moisture': moisture,
      'timestamp': timestamp,
    };
  }

  static Reading fromMap(String id, Map<String, dynamic> map) {
    return Reading(
      id: id,
      temperature: map['temperature'].toDouble(),
      moisture: map['moisture'].toDouble(),
      timestamp: (map['timestamp'] as Timestamp).toDate(),
    );
  }
}