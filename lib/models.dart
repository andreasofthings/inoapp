import 'package:flutter/material.dart';
import 'theme.dart';

class MethodItem {
  final String title;
  final String duration; // e.g., "30M"
  final String groupSize;
  final String difficulty;
  final String phase;
  final IconData icon;
  final Color accentColor;
  final String objective;
  final List<String> materials;
  final List<MethodStep> steps;
  final List<String> proTips;
  final bool isFavorite;

  const MethodItem({
    required this.title,
    required this.duration,
    required this.groupSize,
    required this.difficulty,
    required this.phase,
    required this.icon,
    required this.accentColor,
    required this.objective,
    required this.materials,
    required this.steps,
    required this.proTips,
    this.isFavorite = false,
  });

  int get durationMinutes {
    final clean = duration.replaceAll(RegExp(r'[^0-9]'), '');
    return int.tryParse(clean) ?? 0;
  }
}

class MethodStep {
  final String title;
  final String description;
  final bool isCompleted;

  const MethodStep({
    required this.title,
    required this.description,
    this.isCompleted = false,
  });
}

class Workshop {
  final String title;
  final DateTime date;
  final List<MethodItem> agenda;

  Workshop({
    required this.title,
    required this.date,
    required this.agenda,
  });

  int get totalDurationMinutes {
    return agenda.fold(0, (sum, item) => sum + item.durationMinutes);
  }
}

// Global sample data
final List<MethodItem> sampleMethods = [
  const MethodItem(
    title: 'Empathy Maps',
    duration: '45-60m',
    groupSize: '3-8 Pax',
    difficulty: 'Easy',
    phase: 'Research Phase',
    icon: Icons.groups,
    accentColor: AppColors.primary,
    objective: 'To gain a deeper insight into your customers and users. An empathy map is a collaborative visualization used to articulate what we know about a particular type of user.',
    materials: [
      'Large whiteboard or wall space',
      'Sticky notes (at least 3 colors)',
      'Felt tip markers',
    ],
    steps: [
      MethodStep(title: 'Set the Persona', description: 'Define who the target user is and what their current situation is.'),
      MethodStep(title: 'The 4 Quadrants', description: 'Fill out Says, Thinks, Does, and Feels categories based on user research data.'),
      MethodStep(title: 'Identify Pains/Gains', description: 'Synthesize what the user\'s biggest frustrations and motivations are.'),
    ],
    proTips: [
      'Encourage participants to focus on observed behaviors rather than assumptions. If you hit a wall, ask: \'What is this person\'s biggest fear right now?\'',
    ],
  ),
  const MethodItem(
    title: 'Crazy 8s',
    duration: '8 min',
    groupSize: '2-12',
    difficulty: 'Medium',
    phase: 'Ideation',
    icon: Icons.lightbulb,
    accentColor: AppColors.primary,
    objective: 'Fast sketching exercise that challenges people to sketch eight distinct ideas in eight minutes.',
    materials: ['A4 Paper', 'Sharpie'],
    steps: [
      MethodStep(title: 'Fold Paper', description: 'Fold your A4 paper into 8 sections.'),
      MethodStep(title: 'Sketch', description: 'Sketch one idea in each section every 60 seconds.'),
    ],
    proTips: ['Focus on quantity over quality.'],
  ),
];

final sampleWorkshop = Workshop(
  title: 'Product Strategy Q3',
  date: DateTime(2023, 9, 24),
  agenda: [
    const MethodItem(
      title: 'Icebreaker',
      duration: '10 min',
      groupSize: 'Any',
      difficulty: 'Easy',
      phase: 'Warm-up',
      icon: Icons.celebration,
      accentColor: AppColors.accentOrange,
      objective: 'Warm up the team.',
      materials: [],
      steps: [],
      proTips: [],
    ),
    sampleMethods[0], // Empathy Mapping
    sampleMethods[1], // Crazy 8s
    const MethodItem(
      title: 'Dot Voting',
      duration: '15 min',
      groupSize: 'Any',
      difficulty: 'Easy',
      phase: 'Decision',
      icon: Icons.check_circle,
      accentColor: AppColors.primary,
      objective: 'Vote on ideas.',
      materials: ['Dot stickers'],
      steps: [],
      proTips: [],
    ),
  ],
);
