import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../controllers/dashboard/dashboard_controller.dart';
import '../../../responsive.dart';
import 'ongoing_cycles_card.dart';

class OngoingCyclesSection extends StatelessWidget {
  const OngoingCyclesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "On-going cycles",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: defaultPadding),
        Responsive(
          mobile: OngoingCyclesGridView(
            gridHeight: 0.35 * size.height,
            childAspectRatio: size.width < 650 ? 1.2 : 1,
          ),
          tablet: OngoingCyclesGridView(
            gridHeight: 0.35 * size.height,
            childAspectRatio: size.width < 1500 ? 0.89 : 0.7,
          ),
          desktop: OngoingCyclesGridView(
            gridHeight: 0.37 * size.height,
            childAspectRatio: size.width < 1400 ? 1 : 1.15,
          ),
        ),
      ],
    );
  }
}

class OngoingCyclesGridView extends StatelessWidget {
  const OngoingCyclesGridView({
    super.key,
    this.crossAxisCount = 1,
    this.childAspectRatio = 1,
    this.gridHeight = 260,
  });

  final int crossAxisCount;
  final double childAspectRatio;
  final double gridHeight;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: gridHeight,
      child: Consumer<DashboardController>(
        builder: (_, controller, __) {
          if (controller.isLoading && controller.cycles.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.cycles.isEmpty) {
            return const Center(
              child: Text(
                "No ongoing cycles",
                style: TextStyle(color: Colors.white70),
              ),
            );
          }

          return GridView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: controller.cycles.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              mainAxisSpacing: defaultPadding,
              crossAxisSpacing: defaultPadding,
              childAspectRatio: childAspectRatio,
            ),
            itemBuilder: (_, index) => OngoingCycleCard(cycle: controller.cycles[index]),
          );
        },
      ),
    );
  }
}
