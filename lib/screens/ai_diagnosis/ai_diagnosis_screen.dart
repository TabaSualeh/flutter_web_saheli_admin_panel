import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../constants/sharePref_constants.dart';
import '../../controllers/diagnosis/diagnosis_controller.dart';
import '../../utils/app_model.dart';
import '../../utils/header.dart';
import 'component/ai_diagnosis_chart_section.dart';
import 'component/diagnosis_list.dart';

class AiDiagnosisScreen extends StatefulWidget {
  const AiDiagnosisScreen({super.key});

  @override
  State<AiDiagnosisScreen> createState() => _AiDiagnosisScreenState();
}

class _AiDiagnosisScreenState extends State<AiDiagnosisScreen> {
  late final String token;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final controller = context.read<DiagnosisController>();

      token = AppModel.instance.getStringFromPref(
        SharePrefConstants.adminToken,
      );

      if (token.isEmpty) return;

      controller.loadAll(token);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Header(),
            const SizedBox(height: defaultPadding * 2),
            Text(
              "Stats",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: defaultPadding),
            const AiDiagnosisChartsSection(),
            const SizedBox(height: defaultPadding),
            Text(
              "Conditions",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: defaultPadding),
            Consumer<DiagnosisController>(
              builder: (_, controller, __) {
                return DiagnosisList(
                  diagnoses: controller.diagnoses,
                  isLoading: controller.isDiagnosisLoading,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
