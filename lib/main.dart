import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'app.dart';
import 'features/security/repositories/security_repository.dart';

Future<void> main() async {
  // Widget binding
  final WidgetsBinding widgetsBinding =
  WidgetsFlutterBinding.ensureInitialized();

  // Local storage
  await GetStorage.init();

  // Keep splash
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // Dependency Injection
  Get.put(SecurityRepository());

  // Run app
  runApp(const App());
}