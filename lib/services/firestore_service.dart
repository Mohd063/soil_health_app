import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:soil_health_app/models/reading.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addReading(Reading reading, String userId) async {
    await _db
        .collection('users')
        .doc(userId)
        .collection('readings')
        .add(reading.toMap());
  }

 Stream<List<Reading>> getReadings(String userId) {
  return _db
      .collection('users')
      .doc(userId)
      .collection('readings')
      .orderBy('timestamp', descending: true)
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => Reading.fromMap(doc.id, doc.data()))
          .toList());
}

}