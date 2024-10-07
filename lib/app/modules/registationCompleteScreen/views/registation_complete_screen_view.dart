import 'package:electrokart/app/utils/colours.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../controllers/registation_complete_screen_controller.dart';

class RegistationCompleteScreenView
    extends GetView<RegistationCompleteScreenController> {
  const RegistationCompleteScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            gradient: bg1Gradient,
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 60, left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ColorFiltered(
                    colorFilter: const ColorFilter.mode(
                      Colors.red,
                      BlendMode.modulate,
                    ),
                    child: Lottie.asset(
                      "assets/lottie/check.json",
                      width: 60,
                    )),
                const SizedBox(height: 50),
                const Text(
                  "Registered",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "You have successfully",
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
                const Text(
                  "registered in our app.",
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 3),
                Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: appcolor,
                    border: Border.all(width: 2.5, color: Colors.white),
                  ),
                  child: InkWell(
                    // onTap: ()=>Get.to(()=>LoginScreen()),
                    onTap: () => Get.offNamed('/buttom-bar'),
                    child: const Center(
                      child: Text(
                        "Start",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
