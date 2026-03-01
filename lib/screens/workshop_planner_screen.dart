import 'package:flutter/material.dart';
import '../theme.dart';
import '../models.dart';

class WorkshopPlannerScreen extends StatefulWidget {
  final Workshop workshop;

  const WorkshopPlannerScreen({super.key, required this.workshop});

  @override
  State<WorkshopPlannerScreen> createState() => _WorkshopPlannerScreenState();
}

class _WorkshopPlannerScreenState extends State<WorkshopPlannerScreen> {
  late List<MethodItem> _agenda;
  late TextEditingController _titleController;

  @override
  void initState() {
    super.initState();
    _agenda = List.from(widget.workshop.agenda);
    _titleController = TextEditingController(text: widget.workshop.title);
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: Column(
        children: [
          _buildHeader(context),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildWorkshopInfo(),
                  _buildTimeline(),
                ],
              ),
            ),
          ),
          _buildFooter(),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 120),
        child: FloatingActionButton(
          onPressed: () {},
          backgroundColor: AppColors.primary,
          child: const Icon(Icons.add, color: Colors.white, size: 32),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 10, bottom: 10),
      decoration: const BoxDecoration(
        color: AppColors.backgroundDark,
        border: Border(bottom: BorderSide(color: AppColors.borderSlate800)),
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
            onPressed: () => Navigator.pop(context),
          ),
          const Expanded(
            child: Text(
              "Workshop Planner",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 48),
        ],
      ),
    );
  }

  Widget _buildWorkshopInfo() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Workshop Title", style: TextStyle(color: AppColors.textSlate500, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1)),
          const SizedBox(height: 8),
          TextField(
            controller: _titleController,
            style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.cardDark.withOpacity(0.5),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            ),
          ),
          const SizedBox(height: 24),
          const Text("Session Date", style: TextStyle(color: AppColors.textSlate500, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1)),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.primary.withOpacity(0.2)),
            ),
            child: Row(
              children: const [
                Icon(Icons.calendar_today, color: AppColors.primary, size: 18),
                SizedBox(width: 12),
                Text("Sept 24, 2023", style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
                Spacer(),
                Icon(Icons.expand_more, color: AppColors.primary, size: 18),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeline() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Session Agenda", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.cardDark,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text("${_agenda.length} Methods", style: const TextStyle(color: AppColors.textSlate500, fontSize: 10, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Stack(
            children: [
              Positioned(
                left: 11,
                top: 0,
                bottom: 0,
                child: Container(width: 2, color: AppColors.borderSlate800),
              ),
              ReorderableListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _agenda.length,
                onReorder: (oldIndex, newIndex) {
                  setState(() {
                    if (newIndex > oldIndex) newIndex -= 1;
                    final item = _agenda.removeAt(oldIndex);
                    _agenda.insert(newIndex, item);
                  });
                },
                itemBuilder: (context, index) {
                  final method = _agenda[index];
                  return Padding(
                    key: ValueKey(method.title + index.toString()),
                    padding: const EdgeInsets.only(bottom: 24.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                            border: Border.all(color: AppColors.backgroundDark, width: 4),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: AppColors.cardDark.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: AppColors.borderSlate800),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(method.title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                                      const SizedBox(height: 4),
                                      Row(
                                        children: [
                                          const Icon(Icons.schedule, color: AppColors.textSlate500, size: 14),
                                          const SizedBox(width: 4),
                                          Text(method.duration, style: const TextStyle(color: AppColors.textSlate500, fontSize: 12)),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const Icon(Icons.drag_indicator, color: AppColors.textSlate600),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    final totalDuration = _agenda.fold(0, (sum, item) {
       final clean = item.duration.replaceAll(RegExp(r'[^0-9]'), '');
       // Simple range handling: take the first number if it's a range like "45-60m"
       final firstPart = item.duration.split('-')[0].replaceAll(RegExp(r'[^0-9]'), '');
       return sum + (int.tryParse(firstPart) ?? 0);
    });
    final hours = totalDuration ~/ 60;
    final mins = totalDuration % 60;
    final durationStr = hours > 0 ? "${hours}h ${mins}m" : "${mins}m";

    return Container(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 40),
      decoration: const BoxDecoration(
        color: AppColors.backgroundDark,
        border: Border(top: BorderSide(color: AppColors.borderSlate800)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Total Duration", style: TextStyle(color: AppColors.textSlate500, fontSize: 14, fontWeight: FontWeight.w500)),
              Text(durationStr, style: const TextStyle(color: AppColors.primary, fontSize: 20, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 56),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              elevation: 0,
            ),
            child: const Text("Save Workshop", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
