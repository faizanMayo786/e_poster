import 'dart:async';

import '../view/sign_up_view.dart';
import 'package:get/get.dart';

// Splash Controller
class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();

    Timer(
      const Duration(seconds: 3),
      () => Get.off(
        SignUpView(),
      ),
    );
  }
}
