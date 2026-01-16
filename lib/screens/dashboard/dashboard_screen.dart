import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saheli_admin_panel/constants/sharePref_constants.dart';

import '../../constants.dart';
import '../../controllers/dashboard/dashboard_controller.dart';
import '../../utils/app_model.dart';
import '../../utils/header.dart';
import 'components/ongoing_cycles_section.dart';
import 'components/user_table.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late final String token;
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final controller = context.read<DashboardController>();

      token = AppModel.instance.getStringFromPref(SharePrefConstants.adminToken);
      if (token.isEmpty) return;

      controller.loadUsers(token);
      controller.loadOngoingCycles(token);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            const Header(),
            const SizedBox(height: defaultPadding),
            Consumer<DashboardController>(
              builder: (_, controller, __) {
                return Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Column(
                        children: [
                          OngoingCyclesSection(
                              // cycles: controller.cycles,
                              // isLoading: controller.isLoading,
                              ),
                          const SizedBox(height: defaultPadding),
                          UsersTable(
                            users: controller.users,
                            isLoading: controller.isUserLoading,
                            currentPage: controller.currentPage,
                            totalPages: controller.totalPages,
                            onNext: () {
                              controller.nextPage(token);
                            },
                            onPrevious: () {
                              controller.previousPage(token);
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
