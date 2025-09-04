import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soil_health_app/providers/auth_provider.dart';
import 'package:soil_health_app/providers/reading_provider.dart';
import 'package:soil_health_app/screens/history_screen.dart';
import 'package:soil_health_app/widgets/reading_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final readingProvider = Provider.of<ReadingProvider>(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          "Soil Health Monitor",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            letterSpacing: 0.5,
          ),
        ),
        centerTitle: true,
        elevation: 4,
        backgroundColor: Colors.green[700],
        actions: [
          IconButton(
            tooltip: "History",
            icon: const Icon(Icons.history, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HistoryScreen()),
              );
            },
          ),
          IconButton(
            tooltip: "Logout",
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () {
              authProvider.signOut();
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: size.width < 600 ? 16.0 : size.width * 0.2,
          vertical: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Buttons Row
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: Colors.green[600],
                      foregroundColor: Colors.white,
                      elevation: 4,
                      shadowColor: Colors.black45,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    icon: const Icon(Icons.science, size: 22),
                    onPressed: readingProvider.isLoading
                        ? null
                        : () {
                            readingProvider.takeReading(authProvider.user!.uid);
                          },
                    label: const Text(
                      "Test",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: Colors.blue[600],
                      foregroundColor: Colors.white,
                      elevation: 4,
                      shadowColor: Colors.black45,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    icon: const Icon(Icons.bar_chart, size: 22),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HistoryScreen()),
                      );
                    },
                    label: const Text(
                      "Reports",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            // Latest Reading Card
            Expanded(
              child: Center(
                child: readingProvider.isLoading
                    ? const CircularProgressIndicator()
                    : readingProvider.latestReading != null
                        ? Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Card(
                              elevation: 6,
                              shadowColor: Colors.black26,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: ReadingCard(
                                  reading: readingProvider.latestReading!,
                                ),
                              ),
                            ),
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.eco,
                                  size: 60, color: Colors.greenAccent),
                              SizedBox(height: 12),
                              Text(
                                "No readings yet.\nPress 'Test' to take a reading.",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black54,
                                  height: 1.5,
                                ),
                              ),
                            ],
                          ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
