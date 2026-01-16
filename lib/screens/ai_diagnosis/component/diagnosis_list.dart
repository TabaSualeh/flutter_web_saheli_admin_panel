import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../models/response/diagnosis.dart';

class DiagnosisList extends StatelessWidget {
  final bool isLoading;
  final List<DiagnosisItem> diagnoses;

  const DiagnosisList({
    super.key,
    required this.isLoading,
    required this.diagnoses,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (diagnoses.isEmpty) {
      return const Center(child: Text("No diagnosis found"));
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(), // To work inside SingleChildScrollView
      itemCount: diagnoses.length,
      itemBuilder: (context, index) {
        final item = diagnoses[index];
        return Card(
          color: secondaryColor,
          margin: const EdgeInsets.symmetric(vertical: 6),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: ListTile(
            title: Text(
              item.diagnosis ?? "-",
              style: const TextStyle(color: Colors.white),
            ),
            leading: const Icon(Icons.healing_rounded, color: Colors.white70),
          ),
        );
      },
    );
  }
}
