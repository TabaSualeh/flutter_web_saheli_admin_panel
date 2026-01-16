import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../models/user.dart';
import '../../../utils/app_model.dart';

class UsersTable extends StatelessWidget {
  final List<User> users;
  final bool isLoading;
  final int currentPage;
  final int totalPages;
  final VoidCallback onNext;
  final VoidCallback onPrevious;

  const UsersTable({
    super.key,
    required this.users,
    required this.isLoading,
    required this.currentPage,
    required this.totalPages,
    required this.onNext,
    required this.onPrevious,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Users", style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: defaultPadding),
          if (isLoading)
            const Center(child: CircularProgressIndicator())
          else if (users.isEmpty)
            const Center(child: Text("No users found"))
          else
            DataTable(
              // columnSpacing: defaultPadding,
              columns: const [
                DataColumn(label: Text("Name")),
                DataColumn(label: Text("Date of Joining")),
                DataColumn(label: Text("Last Menstrual Date")),
                DataColumn(label: Text("Period Duration")),
                DataColumn(label: Text("Pregnant")),
              ],
              rows: users.map(_buildRow).toList(),
            ),
          const SizedBox(height: defaultPadding),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Page $currentPage of $totalPages"),
              Row(
                children: [
                  IconButton(
                    onPressed: currentPage > 1 ? onPrevious : null,
                    icon: const Icon(Icons.chevron_left),
                  ),
                  IconButton(
                    onPressed: currentPage < totalPages ? onNext : null,
                    icon: const Icon(Icons.chevron_right),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  DataRow _buildRow(User user) {
    return DataRow(
      onLongPress: () {
        _onUserTap(user);
      },
      cells: [
        DataCell(
          Row(
            children: [
              const Icon(Icons.person, size: 20),
              const SizedBox(width: defaultPadding),
              Text(user.name ?? "-"),
            ],
          ),
        ),
        DataCell(
          Text(AppModel.instance.formatSmartDate(user.createdAt!)),
        ),
        DataCell(Text(AppModel.instance.formatSmartDateNullable(user.startDate))),
        DataCell(Text(user.periodDuration != null ? "${user.periodDuration!}" : "--")),
        DataCell(Text(user.isPregnant == true ? "Yes" : "No")),
      ],
    );
  }

  void _onUserTap(User user) {
    print("User Pressed");
    print("NAME ${user.name}");
    print(
      "LMD ${AppModel.instance.formatSmartDateNullable(user.startDate)}",
    );
  }
}
