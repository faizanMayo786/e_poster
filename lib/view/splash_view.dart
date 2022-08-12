import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/splash_controller.dart';

// Splash Screen with Company Logo
class SplashScreen extends GetView<SplashController> {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(SplashController());
    return const Scaffold(
      body: Center(
        // Replace Logo
        child: FlutterLogo(),
      ),
    );
  }
}
