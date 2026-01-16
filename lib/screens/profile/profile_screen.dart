import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saheli_admin_panel/constants/sharePref_constants.dart';

import '../../constants.dart';
import '../../controllers/dashboard/dashboard_controller.dart';
import '../../utils/app_model.dart';
import '../../utils/header.dart';
import 'component/profile_info_box.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
                final name = AppModel.instance.getStringFromPref(SharePrefConstants.adminName);
                final email = AppModel.instance.getStringFromPref(SharePrefConstants.adminEmail);
                final contact = AppModel.instance.getStringFromPref(SharePrefConstants.adminContact);

                return Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Column(
                        children: [
                          const SizedBox(height: defaultPadding),
                          ProfileInfoBox(
                            name: name,
                            email: email,
                            contact: contact,
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
