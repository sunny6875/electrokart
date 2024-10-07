import 'package:electrokart/app/utils/colours.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/about_us_controller.dart';

class AboutUsView extends GetView<AboutUsController> {
  const AboutUsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'ElectroKart',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'About Us Description goes here...',
              style: TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Contact Information:',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            ListTile(
              leading: const Icon(Icons.email),
              title: const Text('Email: info@electrokart.com'),
              onTap: () {
                // Handle email tapping
              },
            ),
            ListTile(
              leading: const Icon(Icons.phone),
              title: const Text('Phone: +1 123-456-7890'),
              onTap: () {
                // Handle phone tapping
              },
            ),
            // Add more ListTile for other contact information
          ],
        ),
      ),
    );
  }
}
