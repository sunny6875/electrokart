import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductCategories extends StatelessWidget {
  void navigateToSearchResults(String query) {
    Get.toNamed('/search-page', arguments: [
      query,
      true
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: CategoryCard(
            imageUrl: 'https://electrokart.in/wp-content/uploads/2024/02/1.webp',
            title: 'Cool Elegance, Fresh Innovation',
            buttonText: 'EXPLORE MORE',
            ontap: () => navigateToSearchResults('Cool Elegance, Fresh Innovation'),
          ),
        ),
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: CategoryCard(
                  imageUrl: 'https://electrokart.in/wp-content/uploads/2024/02/5.webp',
                  title: 'Mixer Grinder',
                  buttonText: 'EXPLORE MORE',
                  ontap: () => navigateToSearchResults('Mixer Grinder'),
                ),
              ),
              Expanded(
                child: CategoryCard(
                  imageUrl: 'https://electrokart.in/wp-content/uploads/2024/02/4.webp',
                  title: 'TV and Audio',
                  buttonText: 'EXPLORE MORE',
                  ontap: () => navigateToSearchResults('TV and Audio'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String buttonText;
  final VoidCallback ontap;

  const CategoryCard({
    required this.imageUrl,
    required this.title,
    required this.buttonText,
    required this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(imageUrl),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.5), // Darker overlay
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white, // Changed to white for better visibility
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10.0),
                ElevatedButton(
                  onPressed: ontap,
                  child: Text(
                    buttonText,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 8,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pinkAccent, // Match button color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0), // Rounded corners
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 12.0), // Button size
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
