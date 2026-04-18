import 'package:flutter/material.dart';
import 'dashboard/dashboard_screen.dart';
import 'prediction/prediction_screen.dart'; 

void main() => runApp(const NocturaApp());

class NocturaApp extends StatelessWidget {
  const NocturaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Noctura',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, fontFamily: 'Inter'),
      home: const DashboardScreen(), 
      

      routes: {
        '/assessment': (context) => const AssessmentScreen(),
      },
    );
  }
}