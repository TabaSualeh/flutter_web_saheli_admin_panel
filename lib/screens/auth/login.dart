import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saheli_admin_panel/constants/app_assets.dart';

import '../../../constants.dart';
import '../../controllers/auth/login_controller.dart';
import '../main/main_screen.dart';
import 'components/textField.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final emailController = TextEditingController();
  final otpController = TextEditingController();

  Future<void> _handleLogin(BuildContext context, LoginController controller) async {
    if (controller.isLoading) return;

    if (controller.showOtpField) {
      final success = await controller.verifyOtp(
        otpController.text.trim(),
      );

      if (success && context.mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const MainScreen()),
          (route) => false,
        );
        controller.showOtpField = false;
        controller.emailReadOnly = false;
      }
    } else {
      await controller.login(emailController.text.trim());

      if (controller.loginMessage != null && context.mounted) {
        showTopRightToast(context, controller.loginMessage!);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: bgColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: SizedBox(
            width: 400,
            child: Container(
              padding: const EdgeInsets.all(defaultPadding),
              decoration: BoxDecoration(
                color: secondaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Consumer<LoginController>(
                builder: (context, controller, _) {
                  if (controller.emailReadOnly) {
                    emailController.text = emailController.text; // keep text
                  }

                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Image.asset(
                          AppAssets.logo,
                          height: _size.height * 0.2,
                          width: _size.width * 0.101,
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(height: defaultPadding),
                      Center(
                        child: Text(
                          "Admin Login",
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, color: Colors.purpleAccent.withValues(alpha: 0.8)),
                        ),
                      ),
                      const SizedBox(height: defaultPadding * 1.5),

                      // ------------------- EMAIL -------------------
                      LoginTextField(
                        hintText: "Email",
                        icon: Icons.email_outlined,
                        controller: emailController,
                        readOnly: controller.emailReadOnly,
                        textInputType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: defaultPadding),

                      // ------------------- ERROR -------------------
                      if (controller.errorMessage != null)
                        Text(
                          controller.errorMessage!,
                          style: const TextStyle(color: Colors.red),
                        ),
                      const SizedBox(height: defaultPadding),

                      // ------------------- OTP FIELD -------------------
                      if (controller.showOtpField)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            LoginTextField(
                              hintText: "Enter OTP",
                              icon: Icons.lock_outline,
                              controller: otpController,
                              textInputType: TextInputType.number,
                              readOnly: false,
                            ),
                            const SizedBox(height: 5),
                            Text(
                              "OTP expires in: ${controller.otpRemainingFormatted}",
                              style: const TextStyle(color: Colors.white70),
                            ),
                            const SizedBox(height: defaultPadding),
                          ],
                        ),

                      // ------------------- BUTTON -------------------
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            _handleLogin(context, controller);
                          },
                          // onPressed: controller.isLoading
                          //     ? null
                          //     : () async {
                          //         if (controller.showOtpField) {
                          //           // Verify OTP
                          //           await controller.verifyOtp(otpController.text.trim());
                          //         } else {
                          //           // Login
                          //           await controller.login(emailController.text.trim());
                          //
                          //           showTopRightToast(context, controller.loginMessage ?? "");
                          //         }
                          //       },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: controller.isLoading
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              : Text(
                                  controller.showOtpField ? "Verify OTP" : "Login",
                                ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  void showTopRightToast(BuildContext context, String message) {
    final overlay = Overlay.of(context);
    late OverlayEntry overlayEntry;

    // Animation controller
    final controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: Navigator.of(context), // use TickerProvider
    );

    // Slide animation: start off-screen top-right, move to visible, then exit top-left
    final entryAnimation = Tween<Offset>(
      begin: const Offset(1, -1), // off-screen top-right
      end: Offset.zero, // on-screen
    ).animate(CurvedAnimation(parent: controller, curve: Curves.easeOut));

    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 20,
        right: 20,
        child: Material(
          color: Colors.transparent,
          child: SlideTransition(
            position: entryAnimation,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(8),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8,
                  ),
                ],
              ),
              child: Text(
                message,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );

    // Insert overlay
    overlay.insert(overlayEntry);

    // Forward animation (enter)
    controller.forward();

    // After 5 seconds, animate out to top-left
    Future.delayed(const Duration(seconds: 5), () async {
      final exitAnimation = Tween<Offset>(
        begin: Offset.zero,
        end: const Offset(-1, -1), // top-left off-screen
      ).animate(CurvedAnimation(parent: controller, curve: Curves.easeIn));

      controller.reset();
      controller.forward(from: 0);
      overlayEntry.markNeedsBuild();

      await Future.delayed(const Duration(milliseconds: 500));
      overlayEntry.remove();
      controller.dispose();
    });
  }
}
