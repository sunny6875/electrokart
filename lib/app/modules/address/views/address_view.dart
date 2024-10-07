import 'package:electrokart/app/utils/colours.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/address_controller.dart';

class AddressView extends GetView<AddressController> {
  const AddressView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AddressView'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
            future: controller.getUserDetails(),
          builder: (context,snapshot) {
            var data = snapshot.data;
            return Form(
              key: controller.formKey,
              child: Container(
                margin: const EdgeInsets.all(10),
                height: MediaQuery.of(context).size.height,
        
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
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

                          onChanged: (value) {
                            // Update the first name in the controller
                            controller.firstName.text = value;
                          },
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      " Email"  ,
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

                          // initialValue: data!.firstName,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            suffixText: "Change",
                            suffixStyle: TextStyle(
                                color: Color(0xff275C71),
                                fontSize: 8),
                          ),

                          onChanged: (value) {
                            // Update the first name in the controller
                            controller.email.text = value;
                          },
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Address "  ,
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
                          controller: TextEditingController(text: data?.billing['address_1'] ?? ''),
        
                          // initialValue: data!.firstName,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            suffixText: "Change",
                            suffixStyle: TextStyle(
                                color: Color(0xff275C71),
                                fontSize: 8),
                          ),

                          onChanged: (value) {
                            // Update the first name in the controller
                            controller.address.text = value;
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "City "  ,
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
                          controller: TextEditingController(text: data?.billing['city'] ?? ''),
        
                          // initialValue: data!.firstName,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            suffixText: "Change",
                            suffixStyle: TextStyle(
                                color: Color(0xff275C71),
                                fontSize: 8),
                          ),

                          onChanged: (value) {
                            // Update the first name in the controller
                            controller.city.text = value;
                          },
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            if (controller.formKey.currentState!.validate()) {
                              String email = controller.email.text;
        
                              String address = controller.address.text;
                              String city = controller.address.text;
        
                              String name = controller.firstName.text;
                              controller.getAddress(email, name,address, city);
                            } // controller.setInitialRoute(true);
                          },
                          child: Container(
                              height: 40,
                              width: 150,
                              decoration: BoxDecoration(
                                  color: appcolor,
                                  borderRadius: BorderRadius.circular(10)),
                              child: const Center(
                                  child: Text(
                                'Submit',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400),
                              ))),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }
        ),
      ),
    );
  }
}
