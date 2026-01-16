import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../models/period_cycles.dart';
import '../../../utils/app_model.dart';

class OngoingCycleCard extends StatelessWidget {
  const OngoingCycleCard({
    super.key,
    required this.cycle,
  });

  final PeriodCycle cycle;

  @override
  Widget build(BuildContext context) {
    final user = cycle.user;

    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        spacing: defaultPadding,
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(defaultPadding * 0.7),
            decoration: BoxDecoration(
              color: primaryColor.withOpacity(0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              Icons.water_drop,
              color: Colors.red.withValues(alpha: 0.7),
            ),
          ),

          // User name
          Text(
            user?.name ?? "Unknown User",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          // Text(
          //   user?.email ?? "Not Defined",
          //   maxLines: 1,
          //   overflow: TextOverflow.ellipsis,
          //   style: Theme.of(context).textTheme.bodyMedium,
          // ),
          Text(
            "Start Date ${AppModel.instance.formatSmartDateNullable(cycle.startDate)}",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          Spacer(),
          // Cycle info
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Cycle: ${cycle.cycleLength ?? '-'} days",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white70),
                  ),
                  Text(
                    "Period Duration: ${cycle.periodDuration ?? '-'} days",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white70),
                  ),
                ],
              ),
              Text(
                cycle.isPredicted == true ? "PREDICTED" : "ACTIVE",
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: cycle.isPredicted == true ? Colors.orange : Colors.green,
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
