import 'package:electrokart/app/utils/colours.dart';
import 'package:electrokart/app/widgets/textFormFieldCustome.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/login_screen_controller.dart';

class LoginScreenView extends GetView<LoginScreenController> {
  LoginScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          // height: MediaQuery.of(context).size.height,
          //  width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(top: 30),
          decoration: const BoxDecoration(gradient: bg1Gradient),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 35),
            child: Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [Row(mainAxisAlignment:MainAxisAlignment.end,children: [InkWell(onTap: () => Get.offNamed('/buttom-bar'),
                  child: const Text("Skip",style: TextStyle(
                  color: Color(0xff6A7073),
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
                            ),
                ),],),
                  Image.asset("assets/images/logo.png"),
                  const SizedBox(
                    height: 12,
                  ),

                  const Text(
                    "Welcome!",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 22),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 12),
                    child: Text(
                      "Please Login or Sign up to continue",
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  ),
                  const Text(
                    "using our app",
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                  const SizedBox(height: 20),
                  textFormFieldCustom(
                      "abc@gmail.com", "Email", controller.email,
                      isEmail: true),
                  const SizedBox(height: 20),
                  textFormFieldCustom(
                      "12345678", "Password", controller.password,
                      isPassword: true),
                  const SizedBox(height: 12),

                  Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Container(
                      height: 60,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: appcolor,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(width: 2.5, color: Colors.white),
                      ),
                      child: InkWell(
                        // onTap: () => Get.to(() => BottombarScreen( x: 0)),
                        onTap: () {
                          if (controller.formKey.currentState!.validate()) {
                            String email = controller.email.text;
                            String password = controller.password.text;
                            controller.loginUser(email, password);
                          } // controller.setInitialRoute(true);
                        },
                        child: const Center(
                          child: Text(
                            "Login",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                  ),

                  const Text("or"),
                  Container(
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(width: 2.5, color: Colors.white),
                    ),
                    child: InkWell(
                      onTap: () {
                        if(controller.googleLogin()== true){
                          Get.offNamed('/buttom-bar');
                        }else{
                      Text("error");
                        }
                        // controller.googleLogin();
                        // Get.offNamed('/buttom-bar');
                      },
                      child: const Center(
                        child: Text(
                          "SignInWithGoogle",
                          style: TextStyle(
                              color: Color(0xff6A7073),
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Do not have an account?",
                          style: TextStyle(color: Colors.grey, fontSize: 19),
                        ),
                        InkWell(
                          // onTap: () => Get.to(() => SignUpScreen()),
                          onTap: () => Get.toNamed('/sign-up-screen'),
                          child: const Padding(
                            padding: EdgeInsets.only(left: 5),
                            child: Text(
                              "Sign up",
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
