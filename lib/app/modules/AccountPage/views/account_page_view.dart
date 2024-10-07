import 'package:electrokart/app/modules/checkOutPage/views/check_out_page_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:electrokart/app/utils/colours.dart';
import '../controllers/account_page_controller.dart';
import '../modals/userDetailModal.dart';

class AccountPageView extends StatefulWidget {
  const AccountPageView({super.key});

  @override
  State<AccountPageView> createState() => _AccountPageViewState();
}

class _AccountPageViewState extends State<AccountPageView> {
  AccountPageController controller = AccountPageController();

  @override
  void initState() {
    super.initState();
    // Fetch user details when the view initializes
    controller.getUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: controller.getUserDetails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Show a loading spinner while waiting for the data
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // Handle error state
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            // Once data is loaded, display the UI
            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 220,
                    decoration: const BoxDecoration(
                      gradient: bgGradient,
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.elliptical(200, 130),
                      ),
                    ),
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 20),
                          SizedBox(
                            child: CircleAvatar(
                              backgroundColor: appcolor,
                              radius: 40,
                              child: Icon(
                                Icons.person,
                                color: Colors.white,
                                size: 70,
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          // Display the username from the controller
                          InkWell(
                            onTap: () {
                              // Navigate to profile or edit profile page
                            },
                            child: Text(
                              controller.userDetails?.firstName ?? 'Loading...',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  if (controller.userDetails != null)
                  buildMenuItem(
                    context,
                    title: 'My Order',
                    iconPath: 'assets/images/bag.png',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CheckOutPageView(),
                      ),
                    ),
                  ),
                  buildMenuItem(
                    context,
                    title: 'Help Center',
                    iconPath: 'assets/images/help_center.png',
                    onTap: () => Get.toNamed("/help-center"),
                  ),
                  buildMenuItem(
                    context,
                    title: 'Contact Us',
                    iconPath: 'assets/images/contactus.png',
                    onTap: () => Get.toNamed("/contact-us"),
                  ),
                  buildMenuItem(
                    context,
                    title: 'Add Address',
                    iconPath: 'assets/images/address.png',
                    onTap: () => Get.toNamed("/address"),
                  ),
                  if (controller.userDetails != null)
                  buildMenuItem(
                    context,
                    title: 'Edit Profile',
                    iconPath: 'assets/images/edit_profile.png',
                    onTap: () => Get.toNamed("/edit-profile-page"),
                  ),
                  buildMenuItem(
                    context,
                    title: 'About us',
                    iconPath: 'assets/images/about.png',
                    onTap: () => Get.toNamed("/about-us"),
                  ),
                  buildMenuItem(
                    context,
                    title: 'Private Policy',
                    iconPath: 'assets/images/Privacy Policy icon .png',
                    onTap: () => Get.toNamed("/private-policy"),
                  ),
                  buildMenuItem(
                    context,
                    title: 'Return & Refund Policy',
                    iconPath: 'assets/images/return.png',
                    onTap: () => Get.toNamed("/return-refund"),
                  ),
                  buildMenuItem(
                    context,
                    title: 'Terms & Conditions',
                    iconPath: 'assets/images/terms & conditions icon .png',
                    onTap: () => Get.toNamed("/term-and-condition"),
                  ),
                  if (controller.userDetails != null) // Conditionally show logout button
                    buildMenuItem(
                      context,
                      title: 'LogOut',
                      iconPath: 'assets/images/logout.png',
                      onTap: () {
                        controller.setInitialRoute();
                        Get.offAllNamed('/login-screen');
                      },
                      textColor: Colors.red,
                    ),
                  if (controller.userDetails == null) // Conditionally show logout button

                    buildMenuItem(

                      context,
                      title: 'login',
                      iconPath: 'assets/images/logout.png',
                      onTap: () {

                        Get.offAllNamed('/login-screen');
                      },
                      textColor: Colors.red,
                    ),
                  const SizedBox(height: 5),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Widget buildMenuItem(BuildContext context,
      {required String title,
        required String iconPath,
        required VoidCallback onTap,
        Color? textColor}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 5.0,
          ),
        ],
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundColor: const Color(0xffD9D9D9),
                child: Image.asset(
                  iconPath,
                  color: appcolor,
                  height: 22,
                  width: 22,
                ),
              ),
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 15,
                color: textColor ?? appcolor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
