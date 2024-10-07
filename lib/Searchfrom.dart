import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchForm extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: TextFormField(
        controller: searchController,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter a search term';
          }
          return null;
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: BorderSide(width: 4, color: Theme.of(context).primaryColor),
          ),
          filled: true,
          fillColor: Colors.black.withOpacity(0.5), // Black transparent background
          suffixIcon: InkWell(
            onTap: () {
              if (_formKey.currentState!.validate()) {
                Navigator.of(context).pop();
                print(searchController.text);
                Get.toNamed('/search-page', arguments: [
                  searchController.text,
                  true
                ]);
                searchController.clear();
              }
            },
            child: const Icon(Icons.search),
          ),
          hintText: "Search for the product",
          hintStyle: TextStyle(color: Colors.white), // Hint text color
        ),
        style: TextStyle(color: Colors.white), // Input text color
      ),
    );
  }
}
