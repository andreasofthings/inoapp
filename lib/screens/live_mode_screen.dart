import 'package:flutter/material.dart';
import '../theme.dart';
import '../models.dart';

class LiveModeScreen extends StatefulWidget {
  final MethodItem currentMethod;

  const LiveModeScreen({super.key, required this.currentMethod});

  @override
  State<LiveModeScreen> createState() => _LiveModeScreenState();
}

class _LiveModeScreenState extends State<LiveModeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDarkAlt,
      body: Stack(
        children: [
          _buildBackgroundGlow(),
          SafeArea(
            child: Column(
              children: [
                _buildHeader(context),
                _buildTimerSection(),
                Expanded(child: _buildGuideSection()),
                _buildControls(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackgroundGlow() {
    return Positioned.fill(
      child: Opacity(
        opacity: 0.1,
        child: Stack(
          children: [
            Positioned(
              top: -50,
              left: -50,
              child: Container(
                width: 300,
                height: 300,
                decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
              ),
            ),
            Positioned(
              bottom: 100,
              right: -50,
              child: Container(
                width: 250,
                height: 250,
                decoration: const BoxDecoration(color: AppColors.accentPink, shape: BoxShape.circle),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.close, color: AppColors.textSlate400),
            onPressed: () => Navigator.pop(context),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.red.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.red.withOpacity(0.2)),
            ),
            child: Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                ),
                const SizedBox(width: 8),
                const Text("LIVE MODE", style: TextStyle(color: Colors.red, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1)),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.settings, color: AppColors.textSlate400),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildTimerSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: Column(
        children: [
          const Text(
            "24:59",
            style: TextStyle(
              color: Colors.white,
              fontSize: 84,
              fontWeight: FontWeight.w200,
              letterSpacing: -4,
              shadows: [Shadow(color: AppColors.primary, blurRadius: 20)],
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60),
            child: Column(
              children: [
                Text(widget.currentMethod.title, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: const LinearProgressIndicator(
                    value: 0.33,
                    backgroundColor: AppColors.borderSlate800,
                    valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                    minHeight: 6,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text("STAGE 2 OF 5", style: TextStyle(color: AppColors.textSlate500, fontSize: 10, fontWeight: FontWeight.bold)),
                    Text("10:00 / 30:00", style: TextStyle(color: AppColors.textSlate500, fontSize: 10, fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGuideSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.cardDark.withOpacity(0.5),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.borderSlate800),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: const [
                Icon(Icons.menu_book, color: AppColors.primary, size: 18),
                SizedBox(width: 8),
                Text("COACH'S QUICK GUIDE", style: TextStyle(color: AppColors.textSlate300, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1)),
              ],
            ),
            const SizedBox(height: 24),
            _buildGuideStep(
              "Step 1: Introduction (3 min)",
              "\"Now we're going to dive into the minds of our users. Use your sticky notes to capture what they say, do, think, and feel.\"",
              isItalic: true,
              showBorder: true,
            ),
            const SizedBox(height: 24),
            _buildGuideStep(
              "Step 2: Individual Brainstorm (7 min)",
              "",
              items: [
                "Ensure everyone has at least 5 sticky notes per quadrant.",
                "Look for contradictions between 'Say' and 'Do'.",
                "Ask participants to focus on emotional pain points.",
              ],
              activeItemIndex: 2,
            ),
            const SizedBox(height: 24),
            _buildGuideStep(
              "Step 3: Group Sharing (20 min)",
              "Moderator to facilitate one person at a time presenting their quadrant findings. Group into clusters.",
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGuideStep(String title, String content, {bool isItalic = false, bool showBorder = false, List<String>? items, int activeItemIndex = -1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title.toUpperCase(), style: const TextStyle(color: AppColors.primary, fontSize: 11, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        if (content.isNotEmpty)
          Container(
            padding: showBorder ? const EdgeInsets.only(left: 16) : null,
            decoration: showBorder ? const BoxDecoration(border: Border(left: BorderSide(color: AppColors.borderSlate700, width: 2))) : null,
            child: Text(
              content,
              style: TextStyle(
                color: isItalic ? Colors.white : AppColors.textSlate400,
                fontSize: 14,
                fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
                height: 1.5,
              ),
            ),
          ),
        if (items != null)
          ...items.asMap().entries.map((entry) {
            final idx = entry.key;
            final text = entry.value;
            final isDone = idx < activeItemIndex;
            return Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    isDone ? Icons.check_circle : Icons.radio_button_unchecked,
                    color: isDone ? AppColors.accentGreen : AppColors.textSlate600,
                    size: 16,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(text, style: TextStyle(color: isDone ? AppColors.textSlate300 : AppColors.textSlate400, fontSize: 13)),
                  ),
                ],
              ),
            );
          }).toList(),
      ],
    );
  }

  Widget _buildControls() {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 40),
      decoration: BoxDecoration(
        color: AppColors.backgroundDarkAlt.withOpacity(0.8),
        border: const Border(top: BorderSide(color: AppColors.borderSlate800)),
      ),
      child: Column(
        children: [
          _buildStageNavigator(),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildControlButton(Icons.replay, 48),
              _buildControlButton(Icons.pause, 64, isPrimary: true),
              _buildControlButton(Icons.skip_next, 48),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStageNavigator() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildStageItem("Intro", 32, isCompleted: true),
          _buildStageItem("Empathy", 48, isActive: true),
          _buildStageItem("Define", 32),
          _buildStageItem("Ideate", 32),
          _buildStageItem("Test", 32),
        ],
      ),
    );
  }

  Widget _buildStageItem(String label, double width, {bool isActive = false, bool isCompleted = false}) {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: Opacity(
        opacity: isActive ? 1.0 : 0.4,
        child: Column(
          children: [
            Container(
              width: width,
              height: isActive ? 6 : 4,
              decoration: BoxDecoration(
                color: isActive ? AppColors.primary : AppColors.textSlate600,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 4),
            Text(label.toUpperCase(), style: TextStyle(color: isActive ? AppColors.primary : Colors.white, fontSize: 8, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildControlButton(IconData icon, double size, {bool isPrimary = false}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: isPrimary ? Colors.white : AppColors.cardDark,
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: isPrimary ? AppColors.backgroundDarkAlt : Colors.white, size: size * 0.5),
    );
  }
}
