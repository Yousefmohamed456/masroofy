import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:masroofy/features/security/pin_screen.dart';

import 'app.dart';
import 'features/security/repositories/security_repository.dart';

Future<void> main() async {

  // Widget binding
  final WidgetsBinding widgetsBinding =
  WidgetsFlutterBinding.ensureInitialized();

  // Get local storage for simple states
  await GetStorage.init();

  // Await splash screen until other items are loaded
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  Get.put(SecurityRepository());
  // Start App
  runApp(App());
}
