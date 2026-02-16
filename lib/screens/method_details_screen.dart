import 'package:flutter/material.dart';
import '../theme.dart';
import '../models.dart';
import '../widgets/add_method_bottom_sheet.dart';

class MethodDetailsScreen extends StatelessWidget {
  final MethodItem method;

  const MethodDetailsScreen({super.key, required this.method});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(context),
            _buildContent(),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomAction(context),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      height: 280,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [method.accentColor, method.accentColor.withOpacity(0.8)],
        ),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.2,
              child: Icon(method.icon, color: Colors.white, size: 200),
            ),
          ),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildRoundButton(Icons.chevron_left, () => Navigator.pop(context)),
                      _buildRoundButton(Icons.share, () {}),
                    ],
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          method.phase.toUpperCase(),
                          style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        method.title,
                        style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoundButton(IconData icon, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white),
      ),
    );
  }

  Widget _buildContent() {
    return Container(
      transform: Matrix4.translationValues(0, -24, 0),
      decoration: const BoxDecoration(
        color: AppColors.backgroundDark,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          _buildQuickInfoBar(),
          const SizedBox(height: 32),
          _buildAccordion("Objective", Icons.track_changes, method.objective, isOpen: true),
          const SizedBox(height: 16),
          _buildMaterialsSection(),
          const SizedBox(height: 16),
          _buildStepsSection(),
          const SizedBox(height: 16),
          _buildProTips(),
          const SizedBox(height: 80),
        ],
      ),
    );
  }

  Widget _buildQuickInfoBar() {
    return Row(
      children: [
        _buildInfoItem(Icons.schedule, "TIME", method.duration),
        const SizedBox(width: 12),
        _buildInfoItem(Icons.groups, "SIZE", method.groupSize),
        const SizedBox(width: 12),
        _buildInfoItem(Icons.trending_up, "LEVEL", method.difficulty),
      ],
    );
  }

  Widget _buildInfoItem(IconData icon, String label, String value) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.primary.withOpacity(0.05),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.primary.withOpacity(0.1)),
        ),
        child: Column(
          children: [
            Icon(icon, color: AppColors.primary, size: 20),
            const SizedBox(height: 4),
            Text(label, style: const TextStyle(color: AppColors.textSlate500, fontSize: 8, fontWeight: FontWeight.bold)),
            Text(value, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildAccordion(String title, IconData icon, String content, {bool isOpen = false}) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardDark.withOpacity(0.5),
        borderRadius: BorderRadius.circular(16),
      ),
      child: ExpansionTile(
        initiallyExpanded: isOpen,
        leading: Icon(icon, color: AppColors.primary),
        title: Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        trailing: const Icon(Icons.expand_more, color: AppColors.textSlate400),
        shape: const RoundedRectangleBorder(side: BorderSide.none),
        collapsedShape: const RoundedRectangleBorder(side: BorderSide.none),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Text(
              content,
              style: const TextStyle(color: AppColors.textSlate400, height: 1.5, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMaterialsSection() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardDark.withOpacity(0.5),
        borderRadius: BorderRadius.circular(16),
      ),
      child: ExpansionTile(
        leading: const Icon(Icons.architecture, color: AppColors.primary),
        title: const Text("Materials Needed", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        trailing: const Icon(Icons.expand_more, color: AppColors.textSlate400),
        shape: const RoundedRectangleBorder(side: BorderSide.none),
        collapsedShape: const RoundedRectangleBorder(side: BorderSide.none),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Column(
              children: method.materials.map((m) => Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.primary.withOpacity(0.3), width: 2),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Icon(Icons.check, color: AppColors.primary, size: 14),
                    ),
                    const SizedBox(width: 12),
                    Text(m, style: const TextStyle(color: AppColors.textSlate400, fontSize: 14)),
                  ],
                ),
              )).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepsSection() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardDark.withOpacity(0.5),
        borderRadius: BorderRadius.circular(16),
      ),
      child: ExpansionTile(
        leading: const Icon(Icons.format_list_numbered, color: AppColors.primary),
        title: const Text("Step-by-Step Guide", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        trailing: const Icon(Icons.expand_more, color: AppColors.textSlate400),
        shape: const RoundedRectangleBorder(side: BorderSide.none),
        collapsedShape: const RoundedRectangleBorder(side: BorderSide.none),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Column(
              children: method.steps.asMap().entries.map((entry) {
                final idx = entry.key;
                final step = entry.value;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        decoration: const BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            "${idx + 1}",
                            style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            style: const TextStyle(color: AppColors.textSlate400, fontSize: 14, height: 1.4),
                            children: [
                              TextSpan(
                                text: "${step.title}: ",
                                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                              TextSpan(text: step.description),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProTips() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.05),
        border: const Border(left: BorderSide(color: AppColors.primary, width: 4)),
        borderRadius: const BorderRadius.horizontal(right: Radius.circular(16)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.lightbulb, color: AppColors.primary, size: 20),
              SizedBox(width: 8),
              Text("COACH PRO-TIPS", style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 12)),
            ],
          ),
          const SizedBox(height: 12),
          ...method.proTips.map((tip) => Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              "\"$tip\"",
              style: const TextStyle(color: AppColors.textSlate400, fontStyle: FontStyle.italic, fontSize: 13),
            ),
          )).toList(),
        ],
      ),
    );
  }

  Widget _buildBottomAction(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
      decoration: BoxDecoration(
        color: AppColors.backgroundDark,
        border: const Border(top: BorderSide(color: AppColors.borderSlate800)),
      ),
      child: ElevatedButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) => const AddMethodBottomSheet(),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 56),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.calendar_today),
            SizedBox(width: 8),
            Text("Add to Planner", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
