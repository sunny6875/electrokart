import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/google_map_controller.dart';

class GoogleMapView extends GetView<GoogleMapController> {
  const GoogleMapView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GoogleMapView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'GoogleMapView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
