import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soil_health_app/models/reading.dart';
import 'package:soil_health_app/providers/auth_provider.dart';
import 'package:soil_health_app/providers/reading_provider.dart';
import 'package:soil_health_app/widgets/chart_widget.dart';
import 'package:soil_health_app/widgets/reading_card.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final readingProvider = Provider.of<ReadingProvider>(context);

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          "History",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: true,
        elevation: 4,
        backgroundColor: Colors.green[700],
      ),
      body: StreamBuilder<List<Reading>>(
        stream: readingProvider.getReadings(authProvider.user!.uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                "No readings yet",
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
            );
          }

          final readings = snapshot.data!;
          return Column(
            children: [
              //  Chart Section inside Card
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Card(
                  elevation: 5,
                  shadowColor: Colors.black26,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: ChartWidget(readings: readings),
                  ),
                ),
              ),

              //  Readings List Section
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  itemCount: readings.length,
                  itemBuilder: (context, index) {
                    final reading = readings[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: Card(
                        elevation: 3,
                        shadowColor: Colors.black12,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: ReadingCard(reading: reading),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
