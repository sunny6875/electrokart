import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' as flutter;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:electrokart/app/modules/CategoryPage/modals/product_category.dart';
import 'package:persistent_shopping_cart/model/cart_model.dart';
import 'package:persistent_shopping_cart/persistent_shopping_cart.dart';
import '../../../../Searchfrom.dart';
import '../../../../drawer.dart';
import '../controllers/home_page_controller.dart';
import 'package:electrokart/app/utils/colours.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_bounceable/flutter_bounceable.dart';

import 'bannerposter.dart';

class HomePageView extends StatefulWidget {
  HomePageView({Key? key}) : super(key: key);

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  ScrollController _scrollController = ScrollController();
  final HomePageController controller = Get.put(HomePageController());
  TextEditingController searchController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // _scrollToBottom() {
  //   _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
  // }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      // Load next page when reaching the end of the list
      controller.loadNextPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    // WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: AppBar(
            backgroundColor: Colors.white,
            toolbarHeight: 60,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/images/logo transparnt bg.png"),
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(

                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          content: Container(
                            width: double.maxFinite,
                            child: SearchForm(),
                          ),
                        );
                      },
                    );
                  },
                ),

              ],
            ),
          ),
        ),
      ),
      drawer: MyDrawer(),

      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(gradient: bg1Gradient),
          child: Column(
            children: [

              // const SizedBox(height: 20),
              CarouselSlider(
                items: [
                  Container(
                    //   margin: EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      image: const DecorationImage(
                        image: NetworkImage(
                            "https://electrokart.in/wp-content/uploads/2024/02/homepage-banner-1-1.webp"),
                        fit: BoxFit.contain
                        ,
                      ),
                    ),
                  ),

                  //3rd Image of Slider
                  Container(
                    //  margin: EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      image: const DecorationImage(
                        image: NetworkImage(
                            "https://electrokart.in/wp-content/uploads/2024/02/final-banner-2-1.webp"),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),

                  //4th Image of Slider
                  Container(
                    //  margin: EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      image: const DecorationImage(
                        image: NetworkImage(
                            "https://electrokart.in/wp-content/uploads/2024/02/banner-3-1.webp"),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ],

                //Slider Container properties
                options: CarouselOptions(
                  height: 100.0,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  // aspectRatio: 16 / 9,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enableInfiniteScroll: true,
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  viewportFraction: 0.8,
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 12, right: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Category",
                        style: TextStyle(
                            fontSize: 18,
                            color: appcolor,
                            fontWeight: FontWeight.bold)),
                    InkWell(
                      onTap: () {
                        Get.toNamed(
                          '/category-page',
                        );
                      },
                      child: const Text(
                        "View all",
                        style:
                        TextStyle(fontSize: 13, color: Color(0xffCF0808)),
                      ),
                    )
                  ],
                ),
              ),
              FutureBuilder<List<Categorymodel>>(
                future: controller.getCategories(),
                builder: (context, snapshot) {
                  // if (snapshot.connectionState == ConnectionState.waiting) {
                  //   return const Center(
                  //       child: CircularProgressIndicator(
                  //     color: Colors.black,
                  //   ));
                  // }
                  if (snapshot.hasData && snapshot.data != null) {
                    List<Categorymodel>? categories = snapshot.data;

                    return SizedBox(
                      height: 150,
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: categories!.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Get.toNamed(
                                      '/sub-category-page',
                                      arguments:
                                      categories[index].subcategories,
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: SizedBox(
                                      height: 100,
                                      width: 100,
                                      child: ClipRRect(
                                        borderRadius:
                                        BorderRadius.circular(120),
                                        child: Image.network(
                                          categories[index].image.isNotEmpty ? categories[index].image
                                              : 'https://static.vecteezy.com/system/resources/thumbnails/045/590/065/small_2x/404-error-page-not-found-business-concept-app-screen-modern-screen-template-mobile-app-vector.jpg',

                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Text(categories[index].slug)
                              ],
                            );
                          }),
                    );
                  } else if (snapshot.hasError) {
                    print(snapshot.error);
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return const Text('No data available');
                  }
                },
              ),
              SizedBox(
                  height:400 ,
                  child: ProductCategories()),
              const SizedBox(height: 10),

              const Text("Top Featured Brand At Electrokart",
                  style: TextStyle(
                      fontSize: 18,
                      color: Color(0xff0F3A4B),
                      fontWeight: FontWeight.bold)),


              const SizedBox(height: 10),
              buildImageScroller(context),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 12, right: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("New Arrival Products",
                        style: TextStyle(
                            fontSize: 18,
                            color: Color(0xff0F3A4B),
                            fontWeight: FontWeight.bold)),
                    InkWell(
                      // onTap: () {
                      //   Navigator.of(context).push(MaterialPageRoute(
                      //       builder: (context) => ProductPageView()));
                      // },
                      onTap: () => Get.toNamed('/cart-page'),
                      child: const Text(
                        "View all",
                        style:
                        TextStyle(fontSize: 12, color: Color(0xffCF0808)),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                  height: 150,
                  child: FutureBuilder(
                      future: controller.getProductss(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else {
                          return RefreshIndicator(
                            onRefresh: () async {
                              this.controller.getProductss();

                              await Future.value({});
                            },
                            child: ListView.builder(
                                controller: _scrollController,
                                //  shrinkWrap: true,
                                itemCount: snapshot.data!.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  final product = snapshot.data![index];
                                  return SizedBox(
                                    //   height: 180,
                                      child: Column(
                                        children: [
                                          InkWell(
                                            onTap: () => Get.toNamed(
                                                "/product-description-page",
                                                arguments: product.id),
                                            child: Container(
                                              margin: const EdgeInsets.all(8),
                                              height: 100,
                                              width: 100,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                BorderRadius.circular(12),
                                              ),
                                              child: ClipRRect(
                                                borderRadius:
                                                BorderRadius.circular(12),
                                                child: Center(
                                                  child: Image.network(
                                                    product!
                                                        .images
                                                        .isNotEmpty
                                                        ? product
                                                        .images[0]
                                                        .src ??
                                                        ''
                                                        : 'https://static.vecteezy.com/system/resources/thumbnails/045/590/065/small_2x/404-error-page-not-found-business-concept-app-screen-modern-screen-template-mobile-app-vector.jpg',
                                                    fit: BoxFit.contain,
                                                    height: 90,
                                                    width: 100,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text(
                                            product.name.length > 10
                                                ? product.name.substring(0, 10)
                                                : product.name,
                                          )
                                        ],
                                      ));
                                }),
                          );
                        }
                      })),
              const SizedBox(height: 20),
              const Text("Products on sale",
                  style: TextStyle(
                      fontSize: 22,
                      color: Color(0xff0F3A4B),
                      fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 2,
                child: FutureBuilder(
                    future: controller.getProductss(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else {
                        var itemsList = snapshot.data;
                        return  GridView.builder(
                          padding: const EdgeInsets.all(10),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 0.7,
                          ),
                          itemCount: itemsList?.length,
                          itemBuilder: (context, index) {
                            return Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Circular badge for sale

                                  Stack(
                                    children: [

                                      SizedBox(
                                        height: 125,
                                        child: InkWell(
                                          onTap: () => Get.toNamed(
                                            "/product-description-page",
                                            arguments: itemsList[index].id,
                                          ),
                                          child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: itemsList![index].images.length,
                                            itemBuilder: (context, imageIndex) {
                                              return Container(
                                                height: 40,
                                                margin: const EdgeInsets.symmetric(horizontal: 5),
                                                child: Image.network(
                                                  itemsList![index].images[imageIndex].src,
                                                  fit: BoxFit.contain,
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 0,
                                        right: 0,
                                        child: Container(
                                          padding: EdgeInsets.all(15),
                                          decoration: BoxDecoration(
                                            color: Colors.cyan.shade900, // Customize badge color here
                                            shape: BoxShape.circle,
                                          ),
                                          child: Text(
                                            'SALE!',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "₹${itemsList![index].regularPrice.isNotEmpty ? itemsList![index].regularPrice : itemsList![index].salePrice}",
                                        style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          decoration: TextDecoration.lineThrough,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        "₹${itemsList![index].salePrice.isNotEmpty ? itemsList![index].salePrice : itemsList![index].regularPrice}",
                                        style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          color: appcolor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    itemsList[index].name.length > 10
                                        ? itemsList[index].name.substring(0, 10)
                                        : itemsList[index].name,
                                  ),
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: PersistentShoppingCart().showAndUpdateCartItemWidget(
                                        inCartWidget: Container(
                                          height: 30,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            border: Border.all(color: Colors.black),
                                          ),
                                          child: Center(
                                            child: Text(
                                              'Remove',
                                              style: Theme.of(context).textTheme.bodySmall,
                                            ),
                                          ),
                                        ),
                                        notInCartWidget: Container(
                                          height: 30,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.green),
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 5,
                                            ),
                                            child: Center(
                                              child: Text(
                                                'Add to cart',
                                                style: Theme.of(context).textTheme.bodySmall,
                                              ),
                                            ),
                                          ),
                                        ),
                                        product: PersistentShoppingCartItem(
                                          productId: index.toString(),
                                          productName: itemsList![index].name,
                                          productDescription: itemsList![index].description,
                                          unitPrice: double.parse(
                                            itemsList![index].price.isNotEmpty
                                                ? itemsList![index].price
                                                : '00',
                                          ),
                                          productThumbnail: itemsList![index].images.isNotEmpty
                                              ? itemsList![index].images[0].src ??
                                              'https://example.com/placeholder-image.jpg'
                                              : 'https://example.com/placeholder-image.jpg',
                                          quantity: 1,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            );

                          },
                        );
                      }
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
  ListTile buildCategoryTile(String category, List<String>? subcategories) {
    return ListTile(
        title: Text(category),
        onTap: () {
          // Handle tapping on category (optional)
        },
        trailing: subcategories != null
            ? Icon(Icons.arrow_drop_down)
            : null, // Show arrow if there are subcategories
        subtitle: subcategories != null
            ? ExpansionTile(


          title: Text('sub'),
          children: subcategories
              .map((subcategory) => ListTile(
            title: Text(subcategory),
            onTap: () {
              // Handle tapping on subcategory (optional)
            },
          ))
              .toList(),
        ):Container()

    );
  }
  Widget buildCircularImage(String imagePath, String route, bool argument) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Bounceable(
        onTap: () {
          Get.toNamed('/search-page', arguments: [route, argument]);
        },
        child: ClipOval(
          child: SizedBox(
            width: MediaQuery.of(context).size.width / 4.2,
            height: MediaQuery.of(context).size.width / 4.2,
            child: Image.asset(
              imagePath,
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildCircularImageRow(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          buildCircularImage("assets/images/LG.png", "LG", true),
          buildCircularImage("assets/images/samsung.png", "Samsung", true),
          buildCircularImage("assets/images/sony.png", "sony", true),
          buildCircularImage("assets/images/philips.png", "philips", true),
          buildCircularImage("assets/images/goodrej.png", "goodrej", true),
          buildCircularImage("assets/images/symphony.png", "symphony", true),
          buildCircularImage("assets/images/voltas.png", "voltas", true),
          buildCircularImage("assets/images/whirlpool.png", "whirlpool", false),
        ],
      ),
    );
  }

  Widget buildImageScroller(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: buildCircularImageRow(context),
        ),
      ],
    );
  }

}
