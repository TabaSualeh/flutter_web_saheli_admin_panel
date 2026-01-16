import 'package:flutter/material.dart';

import '../../../constants.dart';

class ProfileInfoBox extends StatelessWidget {
  final String name;
  final String email;
  final String contact;

  const ProfileInfoBox({
    super.key,
    required this.name,
    required this.email,
    required this.contact,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: double.infinity,
      padding: const EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text(
          //   "Profile Information",
          //   style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          // ),
          const SizedBox(height: defaultPadding),
          _infoRow("Name", name),
          _infoRow("Email", email),
          _infoRow("Contact", contact),
        ],
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(color: Colors.white70),
            ),
          ),
          Expanded(
            child: Text(
              value.isEmpty ? "-" : value,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
