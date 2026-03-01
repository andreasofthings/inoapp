import 'package:flutter/material.dart';
import 'theme.dart';
import 'models.dart';
import 'screens/toolkit_home_screen.dart';
import 'screens/method_details_screen.dart';
import 'screens/workshop_planner_screen.dart';
import 'screens/live_mode_screen.dart';
import 'screens/welcome.dart';
import 'services/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final authService = AuthService();
  final isLoggedIn = await authService.isLoggedIn();
  runApp(PodApp(isLoggedIn: isLoggedIn));
}

class PodApp extends StatelessWidget {
  final bool isLoggedIn;
  const PodApp({super.key, required this.isLoggedIn});

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
      home: isLoggedIn ? const ToolkitHomeScreen() : const WelcomeScreen(),
      routes: {
        '/login': (context) => const WelcomeScreen(),
        '/home': (context) => const ToolkitHomeScreen(),
      },
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
