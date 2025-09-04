import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soil_health_app/providers/auth_provider.dart';
import 'package:soil_health_app/providers/reading_provider.dart';
import 'package:soil_health_app/screens/auth_screen.dart';
import 'package:soil_health_app/screens/history_screen.dart';
import 'package:soil_health_app/screens/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Firebase
  await Firebase.initializeApp();
  
  // Initialize Hive for offline caching
  await Hive.initFlutter();
  await Hive.openBox('readingsBox'); // Box to store cached readings
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ReadingProvider()),
      ],
      child: MaterialApp(
        title: 'Soil Health Monitor',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.green,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Consumer<AuthProvider>(
          builder: (context, authProvider, _) {
            if (authProvider.user == null) {
              return const AuthScreen();
            } else {
              return const HomeScreen();
            }
          },
        ),
        routes: {
          '/home': (context) => const HomeScreen(),
          '/history': (context) => const HistoryScreen(),
        },
      ),
    );
  }
}
