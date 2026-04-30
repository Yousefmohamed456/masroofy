import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:masroofy/navigation_menu.dart';

class SecurityRepository extends GetxController {
  static SecurityRepository get instance => Get.find();

  @override
  void onReady() {
    FlutterNativeSplash.remove();
    redirectToDashboard();
  }

  void redirectToDashboard() {
    Get.offAll(() => const NavigationMenu());
  }

  bool checkSecurity() {
    return true;
  }
}
