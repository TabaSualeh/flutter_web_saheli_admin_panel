import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:saheli_admin_panel/constants/sharePref_constants.dart';
import 'package:saheli_admin_panel/screens/auth/login.dart';
import 'package:saheli_admin_panel/utils/app_model.dart';

import '../../../constants/app_assets.dart';
import '../../../controllers/menu_app_controller.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final menuController = context.watch<MenuAppController>();

    final Size _size = MediaQuery.of(context).size;

    return Drawer(
      child: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  child: Image.asset(
                    AppAssets.logo,
                    width: _size.width * 0.037,
                    height: _size.height * 0.07,
                  ),
                ),
                DrawerListTile(
                  title: "Dashboard",
                  svgSrc: "assets/icons/menu_dashboard.svg",
                  selected: menuController.currentPage == MenuPage.dashboard,
                  onTap: () {
                    context.read<MenuAppController>().setPage(MenuPage.dashboard);
                  },
                ),
                DrawerListTile(
                  title: "AI Diagnosis",
                  svgSrc: "assets/icons/menu_task.svg",
                  selected: menuController.currentPage == MenuPage.aiDiagnosis,
                  onTap: () {
                    context.read<MenuAppController>().setPage(MenuPage.aiDiagnosis);
                  },
                ),
                DrawerListTile(
                  title: "Profile",
                  svgSrc: "assets/icons/menu_profile.svg",
                  selected: menuController.currentPage == MenuPage.profile,
                  onTap: () {
                    print("ON TAP PROFILE");
                    context.read<MenuAppController>().setPage(MenuPage.profile);
                  },
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: DrawerListTile(
              title: "Log out",
              icon: Icons.logout,
              iconColor: Colors.red,
              textColor: Colors.red,
              onTap: () {
                AppModel.instance.clearDataFromPref([
                  SharePrefConstants.adminId,
                  SharePrefConstants.adminToken,
                ]);

                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => LoginScreen()),
                  (_) => false,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    super.key,
    required this.title,
    this.svgSrc,
    this.icon,
    this.onTap,
    this.textColor,
    this.iconColor,
    this.selected = false,
    this.iconSize = 16,
  }) : assert(
          svgSrc != null || icon != null,
          'Either svgSrc or icon must be provided',
        );
  final String title;
  final String? svgSrc;
  final IconData? icon;
  final VoidCallback? onTap;
  final Color? textColor;
  final Color? iconColor;
  final bool selected;

  final double iconSize;

  @override
  Widget build(BuildContext context) {
    final Color activeColor = Theme.of(context).colorScheme.primary;

    final Color resolvedTextColor = textColor ?? Colors.white54;
    final Color resolvedIconColor = iconColor ?? Colors.white54;

    return Container(
      decoration: BoxDecoration(
        color: selected ? activeColor.withOpacity(0.12) : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        onTap: onTap,
        horizontalTitleGap: 0.0,
        leading: _buildIcon(resolvedIconColor),
        title: Text(
          title,
          style: TextStyle(color: resolvedTextColor, fontWeight: selected ? FontWeight.w600 : FontWeight.normal),
        ),
      ),
    );
  }

  Widget _buildIcon(Color color) {
    if (svgSrc != null) {
      return SvgPicture.asset(
        svgSrc!,
        height: iconSize,
        colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
      );
    }

    return Icon(
      icon,
      size: iconSize,
      color: color,
    );
  }
}
