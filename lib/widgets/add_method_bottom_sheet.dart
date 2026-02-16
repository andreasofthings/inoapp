import 'package:flutter/material.dart';
import '../theme.dart';

class AddMethodBottomSheet extends StatelessWidget {
  const AddMethodBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.92,
      decoration: const BoxDecoration(
        color: AppColors.backgroundDark,
        borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
      ),
      child: Column(
        children: [
          _buildHandle(),
          _buildHeader(context),
          _buildSearchBar(),
          _buildPhaseTabs(),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              children: [
                _buildSectionTitle("RECOMMENDED FOR IDEATION"),
                _buildMethodItem("Crazy 8's", "8 mins", "2-12", Icons.lightbulb, AppColors.primary),
                _buildMethodItem("Brainwriting", "20 mins", "3-8", Icons.psychology, AppColors.accentOrange),
                _buildMethodItem("SCAMPER", "45 mins", "4-10", Icons.grid_view, AppColors.accentPurple),
                const SizedBox(height: 32),
                _buildSectionTitle("COMMONLY USED"),
                _buildMethodItem("User Interviews", "60 mins", "1-on-1", Icons.chat_bubble, AppColors.accentTeal),
                _buildMethodItem("Ice Breaker: Two Truths", "15 mins", "Any", Icons.auto_fix_high, AppColors.accentRose),
              ],
            ),
          ),
          _buildFooterAction(),
        ],
      ),
    );
  }

  Widget _buildHandle() {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      width: 40,
      height: 6,
      decoration: BoxDecoration(
        color: AppColors.borderSlate800,
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("Add Method", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: const BoxDecoration(color: AppColors.cardDark, shape: BoxShape.circle),
              child: const Icon(Icons.close, color: AppColors.textSlate400, size: 20),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: TextField(
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: "Search methods (e.g. Brainstorming)",
          hintStyle: const TextStyle(color: AppColors.textSlate500, fontSize: 14),
          prefixIcon: const Icon(Icons.search, color: AppColors.textSlate500),
          filled: true,
          fillColor: AppColors.cardDark.withOpacity(0.5),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
          contentPadding: const EdgeInsets.symmetric(vertical: 12),
        ),
      ),
    );
  }

  Widget _buildPhaseTabs() {
    final phases = ["All", "Warm-ups", "Empathize", "Ideation", "Prototyping"];
    return SizedBox(
      height: 70,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        itemCount: phases.length,
        itemBuilder: (context, index) {
          final isFirst = index == 0;
          return Container(
            margin: const EdgeInsets.only(right: 12),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: isFirst ? AppColors.primary : AppColors.cardDark,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Text(
                phases[index],
                style: TextStyle(
                  color: isFirst ? Colors.white : AppColors.textSlate400,
                  fontSize: 13,
                  fontWeight: isFirst ? FontWeight.bold : FontWeight.w500,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 16),
      child: Text(
        title,
        style: const TextStyle(color: AppColors.textSlate500, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1),
      ),
    );
  }

  Widget _buildMethodItem(String title, String time, String size, IconData icon, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.cardDark.withOpacity(0.4),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.borderSlate800.withOpacity(0.5)),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.schedule, color: AppColors.textSlate500, size: 12),
                    const SizedBox(width: 4),
                    Text(time, style: const TextStyle(color: AppColors.textSlate500, fontSize: 11)),
                    const SizedBox(width: 12),
                    const Icon(Icons.groups, color: AppColors.textSlate500, size: 12),
                    const SizedBox(width: 4),
                    Text(size, style: const TextStyle(color: AppColors.textSlate500, fontSize: 11)),
                  ],
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              minimumSize: const Size(60, 32),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              elevation: 0,
            ),
            child: Row(
              children: const [
                Icon(Icons.add, size: 16),
                SizedBox(width: 2),
                Text("Add", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooterAction() {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 40),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: AppColors.backgroundDark,
          minimumSize: const Size(double.infinity, 56),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          elevation: 0,
        ),
        child: const Text("View Planner Agenda", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
