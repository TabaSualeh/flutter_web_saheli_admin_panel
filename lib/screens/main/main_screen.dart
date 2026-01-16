import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/menu_app_controller.dart';
import '../../responsive.dart';
import '../ai_diagnosis/ai_diagnosis_screen.dart';
import '../dashboard/dashboard_screen.dart';
import '../profile/profile_screen.dart';
import 'components/side_menu.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MenuAppController>(
      builder: (context, menuController, _) {
        return Scaffold(
          key: menuController.scaffoldKey,
          drawer: const SideMenu(),
          body: SafeArea(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (Responsive.isDesktop(context))
                  const Expanded(
                    child: SideMenu(),
                  ),
                Expanded(
                  flex: 5,
                  child: _buildPage(menuController.currentPage),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildPage(MenuPage page) {
    switch (page) {
      case MenuPage.dashboard:
        return const DashboardScreen();
      case MenuPage.prompt:
        return const Center(child: Text("Prompt Screen"));
      case MenuPage.aiDiagnosis:
        return const AiDiagnosisScreen();
      case MenuPage.profile:
        return const ProfileScreen();
    }
  }
}
