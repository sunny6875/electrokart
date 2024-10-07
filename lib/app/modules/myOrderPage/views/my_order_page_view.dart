import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/my_order_page_controller.dart';

class MyOrderPageView extends GetView<MyOrderPageController> {
  const MyOrderPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 100,
              decoration: const BoxDecoration(
                color: Color(0xff0F3A4B),
              ),
              child: const Padding(
                padding: EdgeInsets.only(left: 16, right: 16),
                child: Row(
                  children: [
                     Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 40,
                    ),
                     Spacer(),
                    Text(
                      "My Order",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    Icon(Icons.notifications_active)
                  ],
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 2,
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            children: [
                              Image.asset(
                                "assets/washing.png",
                                height: 100,
                                width: 100,
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              const Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("washing machine xl"),
                                  SizedBox(height: 8),
                                  Text("Gery"),
                                  SizedBox(
                                    height: 12,
                                  ),
                                  Text(
                                    "EDIT",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  )
                                ],
                              ),
                              const Spacer(),
                              Column(
                                children: [
                                  const Text(
                                    "₹8,999",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.remove),
                                        onPressed: () {},
                                        iconSize: 15,
                                      ),
                                      const Text("2"),
                                      IconButton(
                                        icon: const Icon(Icons.add),
                                        onPressed: () {

                                        },
                                        iconSize: 15,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 30, right: 30),
                          child: Divider(
                            height: 2,
                          ),
                        )
                      ],
                    );
                  }),
            ),
            const Spacer(),
            const Padding(
              padding:  EdgeInsets.only(left: 16, right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Sub Total",
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                  Text(
                    "₹50,000",
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  )
                ],
              ),
            ),
            const Divider(
              height: 2,
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
        
        
              child: Container(
                height: 56.31,
                width: 277,
                decoration: BoxDecoration(
                    color: const Color(0xff0F3A4B),borderRadius: BorderRadius.circular(8),
                    border: Border.all(width: 2.5, color: Colors.white)),
                child: const Center(child: Text("PROCEED TO CHECKOUT",style: TextStyle(color: Colors.white,fontSize: 16),)), ),
            ),
            const SizedBox(
              height: 15,
            )
          ],
        ),
      ),
    );
  }
}
