import 'dart:io';
import 'dart:ui';
import 'package:electrokart/app/utils/colours.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/edit_profile_page_controller.dart';

class EditProfilePageView extends GetView<EditProfilePageController> {
  const EditProfilePageView({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 50),
                      height: 74,
                      width: 300,
                      decoration: BoxDecoration(
                          color: const Color(0xff0F3A4B),
                          borderRadius: BorderRadius.circular(8)),
                      child: const Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Center(
                            child: Text(
                          "Edit Profile",
                          style: TextStyle(color: Colors.white, fontSize: 22),
                        )),
                      ),
                    ),
                    Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                            height: 80.0,
                            width: 80.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white,
                                width: 2.0,
                              ),
                            ),
                            child: CircleAvatar(
                              backgroundColor: const Color(0xff0F3A4B),
                              // radius: 10,
                              child: Image.asset(
                                'assets/images/edit_profile (2).png',
                                fit: BoxFit.contain,
                              ),
                            )))
                  ],
                ),
                const SizedBox(height: 30),
                SizedBox(
                  //height: MediaQuery.of(context).size.height/2,
                  child: FutureBuilder(
                      future: controller.getUserDetails(),
                      builder: (context, snapshot) {
                        // if (snapshot.connectionState ==
                        //     ConnectionState.waiting) {
                        //   return const Center(
                        //     child:
                        //         CircularProgressIndicator(color: Colors.black),
                        //   );
                        // }
                        var data = snapshot.data;
                        return Form(
                          key: controller.formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                               Text(
                                "First Name"  ,
                                style: TextStyle(
                                    fontSize: 16,
                                    color: appcolor,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 5.0,
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    controller: TextEditingController(text: data?.firstName ?? ''),

                                     // initialValue: data!.firstName,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      suffixText: "Change",
                                      suffixStyle: TextStyle(
                                          color: Color(0xff275C71),
                                          fontSize: 8),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter first name';
                                      }
                                      return null;
                                    },
                                    onChanged: (value) {
                                      // Update the first name in the controller
                                      controller.firstName.text = value;
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(height: 15),
                              const Text(
                                "Last Name",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: appcolor,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 5.0,
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    controller: TextEditingController(text: data?.lastName ?? ''),

                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      suffixText: "Change",
                                      suffixStyle: TextStyle(
                                          color: Color(0xff275C71),
                                          fontSize: 11),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter last name';
                                      }
                                      return null;
                                    },
                                    onChanged: (value) {
                                      // Update the first name in the controller
                                      controller.lastName.text = value;
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(height: 15),
                              const Text(
                                "Email",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: appcolor,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 5.0,
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(
                                      controller: TextEditingController(text: data?.email ?? ''),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter email ';
                                        }
                                        return null;
                                      },
                                      onChanged: (value) {
                                        // Update the first name in the controller
                                        controller.email.text = value;
                                      },
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        suffixText: "Change",
                                        suffixStyle: TextStyle(
                                            color: Color(0xff275C71),
                                            fontSize: 11),

                                      )

                                  ),

                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),   const Text(
                                "Mobile Number",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: appcolor,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 5.0,
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(
                                      controller: TextEditingController(text: data?.billing['phone'] ?? ''),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter mobile number ';
                                        }
                                        return null;
                                      },
                                      onChanged: (value) {
                                        controller.mobile.text = value;
                                      },
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        suffixText: "Change",
                                        suffixStyle: TextStyle(
                                            color: Color(0xff275C71),
                                            fontSize: 11),

                                      )

                                  ),

                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              const SizedBox(height: 15),
                              const Text(
                                "Password",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: appcolor,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 5.0,
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(
                                      controller: controller.password,
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        suffixText: "Change",
                                        suffixStyle: TextStyle(
                                            color: Color(0xff275C71),
                                            fontSize: 11),
                                      )),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                ),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        if (controller.formKey.currentState!.validate()) {
                          String firstName = controller.firstName.text;
                          String lastName = controller.lastName.text;
                          String email = controller.email.text;
                          String mobile = controller.mobile.text;
                          String password = controller.password.text;
                          controller.Delete(
                              firstName, lastName, email,mobile, password);
                        }
                        ;
                      },
                      child: Container(
                        height: 46.8,
                        width: MediaQuery.of(context).size.width / 2.5,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(width: 3.5, color: Colors.white),
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.shade200,
                                blurRadius: 5.0,
                                offset: const Offset(0.5, 0.5)),
                          ],
                        ),
                        child: const Center(
                            child: Text(
                          "Delete",
                          style: TextStyle(color: Color(0xff0F3A4B)),
                        )),
                      ),
                    ),
                    const SizedBox(width: 20),
                    InkWell(
                      onTap: () {
                        if (controller.formKey.currentState!.validate()) {
                          String firstName = controller.firstName.text;
                          String lastName = controller.lastName.text;
                          String email = controller.email.text;
                          String mobile = controller.mobile.text;
                          String password = controller.password.text;
                          controller.Update(
                              firstName, lastName, email,mobile, password,);
                        }
                        ;
                      },
                      child: Container(
                        height: 46.8,
                        width: MediaQuery.of(context).size.width / 2.5,
                        decoration: BoxDecoration(
                            color: const Color(0xff0F3A4B),
                            border: Border.all(width: 3.5, color: Colors.white),
                            borderRadius: BorderRadius.circular(8)),
                        child: const Center(
                            child: Text(
                          "Update",
                          style: TextStyle(color: Colors.white),
                        )),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
