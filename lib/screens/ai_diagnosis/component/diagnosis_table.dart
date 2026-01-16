import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../models/response/diagnosis.dart';

class DiagnosisTable extends StatelessWidget {
  final bool isLoading;
  final List<DiagnosisItem> diagnoses;

  const DiagnosisTable({
    super.key,
    required this.isLoading,
    required this.diagnoses,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Diagnosis List",
            style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: defaultPadding),
          if (isLoading)
            const Center(child: CircularProgressIndicator())
          else if (diagnoses.isEmpty)
            const Center(child: Text("No diagnosis found"))
          else
            DataTable(
              columnSpacing: defaultPadding,
              columns: const [
                DataColumn(label: Text("Possible Conditions")),
              ],
              rows: diagnoses.map((item) {
                return DataRow(
                  cells: [
                    DataCell(Text(item.diagnosis ?? "-")),
                  ],
                );
              }).toList(),
            ),
        ],
      ),
    );
  }
}
