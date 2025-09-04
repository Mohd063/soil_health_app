import 'package:flutter/material.dart';
import 'package:soil_health_app/models/reading.dart';
import 'package:intl/intl.dart';

class ReadingCard extends StatelessWidget {
  final Reading reading;

  const ReadingCard({super.key, required this.reading});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final dateFormatted = DateFormat('dd MMM yyyy').format(reading.timestamp);
    final timeFormatted = DateFormat('HH:mm:ss').format(reading.timestamp);

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: size.width < 600 ? 16 : 24,
          vertical: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Date & Time
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '📅 $dateFormatted',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  '⏰ $timeFormatted',
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Metrics
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildMetric(
                  'Temperature',
                  '${reading.temperature}°C',
                  icon: Icons.thermostat_outlined,
                  iconColor: Colors.red,
                ),
                _buildMetric(
                  'Moisture',
                  '${reading.moisture}%',
                  icon: Icons.water_drop_outlined,
                  iconColor: Colors.blue,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetric(String label, String value,
      {required IconData icon, required Color iconColor}) {
    return Column(
      children: [
        Icon(icon, color: iconColor, size: 28),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
