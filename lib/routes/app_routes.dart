import 'package:get/get.dart';
import 'package:masroofy/features/security/pin_screen.dart';

class AppRoutes {
  static const String pin = '/pin';

  static final List<GetPage> pages = [
    GetPage(
      name: pin,
      page: () => const PinScreen(
        title: 'Enter a 4-digit PIN',
        subtitle: 'Used to unlock the app later',
      ),
    ),
  ];
}