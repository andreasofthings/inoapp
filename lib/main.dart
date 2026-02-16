import 'package:flutter/material.dart';
import 'theme.dart';
import 'models.dart';
import 'screens/toolkit_home_screen.dart';
import 'screens/method_details_screen.dart';
import 'screens/workshop_planner_screen.dart';
import 'screens/live_mode_screen.dart';

void main() {
  runApp(const PodApp());
}

class PodApp extends StatelessWidget {
  const PodApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Method Toolkit',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.backgroundDark,
        fontFamily: 'Inter',
        useMaterial3: true,
      ),
      home: const ToolkitHomeScreen(),
      onGenerateRoute: (settings) {
        if (settings.name == '/details') {
          final method = settings.arguments as MethodItem;
          return MaterialPageRoute(builder: (context) => MethodDetailsScreen(method: method));
        }
        if (settings.name == '/planner') {
          final workshop = settings.arguments as Workshop;
          return MaterialPageRoute(builder: (context) => WorkshopPlannerScreen(workshop: workshop));
        }
        if (settings.name == '/live') {
          final method = settings.arguments as MethodItem;
          return MaterialPageRoute(builder: (context) => LiveModeScreen(currentMethod: method));
        }
        return null;
      },
    );
  }
}
