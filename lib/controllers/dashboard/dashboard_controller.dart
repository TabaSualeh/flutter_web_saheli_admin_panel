import 'package:flutter/material.dart';
import 'package:saheli_admin_panel/models/response/user_response.dart';

import '../../api/dashboard_api.dart';
import '../../models/period_cycles.dart';
import '../../models/response/ongoing_cycle_response.dart';
import '../../models/user.dart';

class DashboardController extends ChangeNotifier {
  bool isLoading = false;
  bool isUserLoading = false;

  List<PeriodCycle> cycles = [];
  List<User> users = [];

  int currentPage = 1;
  int limit = 10;
  int totalPages = 0;
  int totalCount = 0;

  Future<void> loadOngoingCycles(String token) async {
    isLoading = true;
    notifyListeners();

    try {
      final response = await DashboardApi.getAllOngoingCycles(token: token);
      final parsed = OnGoingCycleResponse.fromJson(response);

      cycles = parsed.cycles;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadUsers(
    String token, {
    int page = 1,
  }) async {
    isUserLoading = true;
    notifyListeners();

    try {
      final response = await DashboardApi.getAllUsers(
        page: page,
        limit: limit,
        token: token,
      );

      final parsed = UserResponse.fromJson(response);

      users = parsed.data ?? [];
      currentPage = page;
      totalPages = parsed.totalPages ?? 0;
      totalCount = parsed.totalCount ?? 0;
    } finally {
      isUserLoading = false;
      notifyListeners();
    }
  }

  void nextPage(String token) {
    if (currentPage < totalPages) {
      loadUsers(token, page: currentPage + 1);
    }
  }

  void previousPage(String token) {
    if (currentPage > 1) {
      loadUsers(token, page: currentPage - 1);
    }
  }
}
