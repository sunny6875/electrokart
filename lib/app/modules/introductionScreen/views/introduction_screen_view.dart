import 'package:electrokart/app/utils/colours.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../controllers/introduction_screen_controller.dart';

class IntroductionScreenView extends GetView<IntroductionScreenController> {
  const IntroductionScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
   var width =  MediaQuery.of(context).size.width;
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        height: height,
        width:width,
        decoration: const BoxDecoration(
          gradient: bgGradient,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 8,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Stack(
                children: [
                  ColorFiltered(
                    colorFilter: const ColorFilter.mode(
                      Colors.white,
                      BlendMode.modulate,
                    ),
                    child: Lottie.asset(
                      "assets/lottie/iconback.json",
                      width: 210,
                    ),
                  ),
                  Positioned(
                      left: 0,
                      right: 0,
                      top: 10,
                      child: Image.asset("assets/images/logo.png")),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 12,
            ),
            Obx(
              () => controller.isSelected.value
                  ? Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 80),
                          child: Text(
                            "ELECTROKART",
                            style: TextStyle(
                                fontSize: 28,
                                color: Color(0xFFFFFFFF),
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          "Essentials for Setting Up the",
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                        const Text(
                          "ideal  Household",
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                        InkWell(
                          onTap: () {
                            print('..................');
                            controller.isSelected.value = false;
                          },
                          child: Container(
                            margin: const EdgeInsets.only(top: 30),
                            height: 46.8,
                            width: 230.24,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                    width: 1.5, color: Colors.white)),
                            child: const Center(
                                child: InkWell(
                              child: Text(
                                "Let’s Begin",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
                              ),
                            )),
                          ),
                        ),
                      ],
                    )
                  : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Column(
                        children: [
                          const Text(
                            "Essentials for Setting Up the",
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFFFFFFFF),
                            ),
                          ),
                          const Text(
                            "ideal  Household",
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFFFFFFFF),
                            ),
                          ),
                          const SizedBox(
                            height: 60,
                          ),
                          loginSignUButton(width, "Login", () {
                            Get.offNamed('/login-screen');
                          }),
                          const SizedBox(
                            height: 20,
                          ),
                          loginSignUButton(width, 'Skip', (){
                            Get.offNamed('/buttom-bar');
                          }),
                        ],
                      ),
                  ),
            ),
          ],
        ),
      ),
    ));
  }
  Widget loginSignUButton (double width, String text, VoidCallback onPressed){


    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 58,
        width: width,
        decoration: BoxDecoration(
          color: text == 'Login'?appcolor:Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border:
          Border.all(width: 2.5, color: Colors.white),
        ),
        child: InkWell(
          // onTap: () => Get.to(() => SignUpScreen()),

          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                  color: Colors.white, fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }

}

