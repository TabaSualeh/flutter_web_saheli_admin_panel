import 'package:flutter/material.dart';

//
// class MenuAppController extends ChangeNotifier {
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//
//   GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;
//
//   void controlMenu() {
//     if (!_scaffoldKey.currentState!.isDrawerOpen) {
//       _scaffoldKey.currentState!.openDrawer();
//     }
//   }
// }
enum MenuPage {
  dashboard,
  prompt,
  aiDiagnosis,
  profile,
}

class MenuAppController extends ChangeNotifier {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  MenuPage _currentPage = MenuPage.dashboard;

  MenuPage get currentPage => _currentPage;

  void setPage(MenuPage page) {
    if (_currentPage == page) return;
    _currentPage = page;
    notifyListeners();
  }

  String get currentPageTitle {
    switch (_currentPage) {
      case MenuPage.dashboard:
        return "Dashboard";
      case MenuPage.prompt:
        return "Prompt";
      case MenuPage.aiDiagnosis:
        return "AI Diagnosis";
      case MenuPage.profile:
        return "Profile";
    }
  }

  void controlMenu() {
    if (scaffoldKey.currentState!.isDrawerOpen) {
      scaffoldKey.currentState!.closeDrawer();
    } else {
      scaffoldKey.currentState!.openDrawer();
    }
  }
}
