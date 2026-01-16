import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:saheli_admin_panel/controllers/diagnosis/diagnosis_controller.dart';
import 'package:saheli_admin_panel/screens/auth/login.dart';
import 'package:saheli_admin_panel/screens/main/main_screen.dart';
import 'package:saheli_admin_panel/utils/app_model.dart';

import 'constants.dart';
import 'constants/sharePref_constants.dart';
import 'controllers/auth/login_controller.dart';
import 'controllers/dashboard/dashboard_controller.dart';
import 'controllers/menu_app_controller.dart';
import 'environment/environment_class.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AppModel.instance.init();

  const String environment = String.fromEnvironment('ENVIRONMENT', defaultValue: Environment.DEV);
  // Constants.appInitial = true;

  Environment().initConfig(environment);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginController()),
        ChangeNotifierProvider(create: (_) => DiagnosisController()),
        ChangeNotifierProvider(create: (_) => DashboardController()),
        ChangeNotifierProvider(create: (_) => MenuAppController()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Saheli Admin',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: bgColor,
          textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme).apply(bodyColor: Colors.white),
          canvasColor: secondaryColor,
        ),
        home: AppModel.instance
                .getStringFromPref(
                  SharePrefConstants.adminToken,
                )
                .isNotEmpty
            ? const MainScreen()
            : LoginScreen(),
      ),
    );
  }
}
