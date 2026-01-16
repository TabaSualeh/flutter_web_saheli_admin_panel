import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../controllers/diagnosis/diagnosis_controller.dart';
import '../../../utils/chart.dart';

class AiDiagnosisChartsSection extends StatelessWidget {
  const AiDiagnosisChartsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DiagnosisController>(
      builder: (_, controller, __) {
        if (controller.isStatsLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        final stats = controller.statsData;

        if (stats == null || stats.diagnosisStats == null) {
          return const Text("No chart data available");
        }

        return Container(
          padding: const EdgeInsets.all(defaultPadding),
          decoration: BoxDecoration(
            color: secondaryColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Expanded(
                child: Chart(
                  data: stats.diagnosisStats!, // 👈 pass real data
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
