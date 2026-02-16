import 'package:flutter/material.dart';
import 'theme.dart';
import 'models.dart';
import 'widgets/header_section.dart';
import 'widgets/category_chips.dart';
import 'widgets/method_card.dart';
import 'widgets/ai_assistant_card.dart';
import 'widgets/bottom_nav_bar.dart';

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
      ),
      home: const MethodLibraryScreen(),
    );
  }
}

class MethodLibraryScreen extends StatelessWidget {
  const MethodLibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<MethodItem> methods = [
      const MethodItem(
        title: 'Empathy Maps',
        duration: '30M',
        icon: Icons.groups,
        accentColor: AppColors.accentPink,
      ),
      const MethodItem(
        title: 'How Might We',
        duration: '15M',
        icon: Icons.question_answer,
        accentColor: AppColors.accentOrange,
        isFavorite: true,
      ),
      const MethodItem(
        title: 'Crazy 8s',
        duration: '8M',
        icon: Icons.lightbulb,
        accentColor: AppColors.primary,
      ),
      const MethodItem(
        title: 'Paper Prototype',
        duration: '60M',
        icon: Icons.auto_fix_high,
        accentColor: AppColors.accentGreen,
      ),
      const MethodItem(
        title: 'Usability Test',
        duration: '45M',
        icon: Icons.visibility,
        accentColor: AppColors.accentPurple,
      ),
      const MethodItem(
        title: 'Stakeholder Map',
        duration: '30M',
        icon: Icons.hub,
        accentColor: AppColors.accentPink,
      ),
      const MethodItem(
        title: 'Journey Map',
        duration: '90M',
        icon: Icons.route,
        accentColor: AppColors.accentOrange,
      ),
      const MethodItem(
        title: 'Dot Voting',
        duration: '10M',
        icon: Icons.radio_button_checked,
        accentColor: AppColors.primary,
        isFavorite: true,
      ),
    ];

    return Scaffold(
      body: Stack(
        children: [
          // Background decorative elements
          Positioned(
            top: -100,
            left: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            bottom: -100,
            right: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                color: AppColors.accentPurple.withOpacity(0.05),
                shape: BoxShape.circle,
              ),
            ),
          ),
          SafeArea(
            bottom: false,
            child: Column(
              children: [
                const HeaderSection(),
                const CategoryChips(),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 120),
                    children: [
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 0.9,
                        ),
                        itemCount: methods.length,
                        itemBuilder: (context, index) {
                          return MethodCard(item: methods[index]);
                        },
                      ),
                      const AiAssistantCard(),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: CustomBottomNavBar(),
          ),
        ],
      ),
    );
  }
}
