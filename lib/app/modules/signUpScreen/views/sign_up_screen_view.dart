import 'package:electrokart/app/utils/colours.dart';
import 'package:electrokart/app/widgets/textFormFieldCustome.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/sign_up_screen_controller.dart';

class SignUpScreenView extends GetView<SignUpScreenController> {
  SignUpScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          // height: MediaQuery.of(context).size.height,
          // width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(gradient: bg1Gradient),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
            child: Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset("assets/images/logo.png"),
                  const Text(
                    "Sign up",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 22),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 12),
                    child: Text(
                      "Create an new account ",
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  ),
                  const SizedBox(height: 30),
                  textFormFieldCustom(
                      "", "First Name", controller.firstName),
                  const SizedBox(height: 20),
                  textFormFieldCustom(
                      "", "Last Name", controller.lastName),
                  const SizedBox(height: 20),
                  textFormFieldCustom(
                      "", "email", controller.email,
                      isEmail: true),
                  const SizedBox(height: 20),
                  textFormFieldCustom("", "password", controller.password,
                      isPassword: true),
                  SizedBox(
                    // width: 450,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Obx(
                          () => Padding(
                            padding: const EdgeInsets.only(right: 2),
                            child: Checkbox(
                              checkColor: Colors.white,
                              activeColor: appcolor,
                              value: controller.checkBox.value,
                              onChanged: (bool? value) {
                                controller.checkBox.value = value ?? false;
                              },
                            ),
                          ),
                        ),
                        const Text("I Agree Terms and conditions")
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: InkWell(
                      onTap: () {
                        if (controller.formKey.currentState!.validate()) {
                          String firstName = controller.firstName.text;
                          String lastName = controller.lastName.text;
                          String email = controller.email.text;
                          String password = controller.password.text;
                          controller.signUpUser(
                              firstName, lastName, email, password);
                        }

                        // Get.offNamed('/registation-complete-screen');
                      },
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: appcolor,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(width: 2.5, color: Colors.white),
                        ),
                        child: const Center(
                          child: Text(
                            "SignUp",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Do have an account?",
                          style: TextStyle(color: Colors.grey, fontSize: 19),
                        ),
                        InkWell(
                          // onTap: () => Get.to(() => SignUpScreen()),
                          onTap: () => Get.toNamed('/login-screen'),

                          child: const Padding(
                            padding: EdgeInsets.only(left: 5),
                            child: Text(
                              "Login",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
