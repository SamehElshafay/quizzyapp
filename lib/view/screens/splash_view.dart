import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizzy_app/utils/app_images.dart';
import 'package:quizzy_app/view_model/splash_view_model.dart';

class SplashView extends GetView<SplashViewModel> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              Assets.imagesLogoImage,
              cacheHeight: 132,
              cacheWidth: 132,
            ),
            Image.asset(
              Assets.imagesLogoText,
              cacheHeight: 64,
              cacheWidth: 168,
            ),
            Text("${controller.splashTextInit}"),
          ],
        ),
      ),
    );
  }
}
