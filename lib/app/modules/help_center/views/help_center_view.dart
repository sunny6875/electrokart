import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/help_center_controller.dart';

class HelpCenterView extends GetView<HelpCenterController> {
  const HelpCenterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help Center'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: ListView(
          children: <Widget>[
            ListTile(
              title: const Text('FAQs'),
              onTap: () {
                // Navigate to FAQs screen
              },
            ),
            ListTile(
              title: const Text('Contact Us'),
              onTap: () {
                // Navigate to Contact Us screen
              },
            ),
            const SizedBox(height: 30),
            const Text(
              "Electrokart Retail",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            const Text(
                "Puri Complex, Ganesh Bazar, Srinagar Garhwal, Uttarakhand-246174\nelectrokartretail@gmail.com"),
            // Add more ListTiles for different help topics
          ],
        ),
      ),
    );
  }
}
