import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class MyDrawer extends StatefulWidget {
  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> with SingleTickerProviderStateMixin {
   AnimationController? _controller;
  Animation<double> ?_animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _controller!,
      curve: Curves.easeInOut,
    );

    _controller!.forward();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  void navigateToSearchResults(String query) {
    Get.toNamed('/search-page', arguments: [query, true]);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.pinkAccent,
              image: DecorationImage(
                image: AssetImage('assets/drawer_header_background.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Text(
              'Home',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          buildAnimatedCategoryTile('Mobiles', Icons.phone_android, 'Mobiles'),
          buildAnimatedExpansionTile('TV and Audio', Icons.tv, [
            buildCategoryTile('Television', Icons.tv, 'Television'),
            buildCategoryTile('Audio', Icons.audiotrack, 'Audio'),
            buildCategoryTile('View All', Icons.view_list, 'TV and Audio'),
          ]),
          buildAnimatedExpansionTile('Home Appliances', Icons.home, [
            buildCategoryTile('Refrigerator', Icons.kitchen, 'Refrigerator'),
            buildCategoryTile('Washing Machine', Icons.local_laundry_service, 'Washing Machine'),
            buildCategoryTile('Air Conditioner', Icons.ac_unit, 'Air Conditioner'),
            buildCategoryTile('Water Purifier', Icons.water_damage, 'Water Purifier'),
            buildCategoryTile('Water Heaters', Icons.hot_tub, 'Water Heaters'),
            buildCategoryTile('Room Heaters', Icons.wb_sunny, 'Room Heaters'),
            buildCategoryTile('Air Cooler', Icons.toys, 'Air Cooler'),
            buildCategoryTile('Electric Fan', Icons.air, 'Electric Fan'),
            buildCategoryTile('Dishwasher', Icons.local_dining, 'Dishwasher'),
            buildCategoryTile('Inverter and Batteries', Icons.battery_charging_full, 'Inverter and Batteries'),
            buildCategoryTile('Voltage Stabilizer', Icons.power, 'Voltage Stabilizer'),
            buildCategoryTile('Air Purifier', Icons.air, 'Air Purifier'),
            buildCategoryTile('Vacuum Cleaners', Icons.cleaning_services, 'Vacuum Cleaners'),
            buildCategoryTile('View All', Icons.view_list, 'Home Appliances'),
          ]),
          buildAnimatedExpansionTile('Kitchen Appliances', Icons.kitchen, [
            buildCategoryTile('Microwave and OTG', Icons.microwave, 'Microwave and OTG'),
            buildCategoryTile('Induction, Cooker, and Gas Stove', Icons.fireplace, 'Induction, Cooker, and Gas Stove'),
            buildCategoryTile('Mixer Grinder', Icons.blender, 'Mixer Grinder'),
            buildCategoryTile('Electric Kettle', Icons.local_cafe, 'Electric Kettle'),
            buildCategoryTile('Chimney', Icons.kitchen, 'Chimney'),
            buildCategoryTile('Air Fryer', Icons.restaurant, 'Air Fryer'),
            buildCategoryTile('Rice Cooker', Icons.rice_bowl, 'Rice Cooker'),
            buildCategoryTile('Chopper and Hand Blender', Icons.food_bank, 'Chopper and Hand Blender'),
            buildCategoryTile('Juicers', Icons.local_drink, 'Juicers'),
            buildCategoryTile('Dry and Steam Irons', Icons.iron, 'Dry and Steam Irons'),
            buildCategoryTile('Toasters and Sandwich Makers', Icons.fastfood, 'Toasters and Sandwich Makers'),
            buildCategoryTile('Weighing Scale', Icons.scale, 'Weighing Scale'),
            buildCategoryTile('View All', Icons.view_list, 'Kitchen Appliances'),
          ]),
          buildAnimatedExpansionTile('LED Lighting and Electrical Accessories', Icons.lightbulb, [
            buildCategoryTile('LED Bulbs', Icons.lightbulb_outline, 'LED Bulbs'),
            buildCategoryTile('LED Battens', Icons.light, 'LED Battens'),
            buildCategoryTile('LED Down Lights', Icons.light, 'LED Down Lights'),
            buildCategoryTile('LED Panel Lights', Icons.light, 'LED Panel Lights'),
            buildCategoryTile('LED Street Lights', Icons.streetview, 'LED Street Lights'),
            buildCategoryTile('LED Flood Lights', Icons.light, 'LED Flood Lights'),
            buildCategoryTile('Spike Guards', Icons.bolt, 'Spike Guards'),
            buildCategoryTile('Multi Plug', Icons.power, 'Multi Plug'),
            buildCategoryTile('Torches and Table Lamps', Icons.flashlight_on, 'Torches and Table Lamps'),
            buildCategoryTile('Emergency Lights', Icons.lightbulb, 'Emergency Lights'),
            buildCategoryTile('View All', Icons.view_list, 'LED Lighting and Electrical Accessories'),
          ]),
          buildAnimatedExpansionTile('Cookware', Icons.kitchen, [
            buildCategoryTile('Pressure Cooker', Icons.kitchen, 'Pressure Cooker'),
            buildCategoryTile('Non-stick Cookware', Icons.kitchen, 'Non-stick Cookware'),
            buildCategoryTile('View All', Icons.view_list, 'Cookware'),
          ]),
          buildAnimatedExpansionTile('Commercial Refrigerator', Icons.store, [
            buildCategoryTile('Deep Freezer', Icons.kitchen, 'Deep Freezer'),
            buildCategoryTile('Visi Coolers', Icons.kitchen, 'Visi Coolers'),
            buildCategoryTile('Water Coolers', Icons.water_damage, 'Water Coolers'),
            buildCategoryTile('Water Dispensers', Icons.local_drink, 'Water Dispensers'),
            buildCategoryTile('View All', Icons.view_list, 'Commercial Refrigerator'),
          ]),
          buildAnimatedExpansionTile('Personal Grooming', Icons.person, [
            buildCategoryTile('Women', Icons.female, 'Women'),
            buildCategoryTile('Men', Icons.male, 'Men'),
            buildCategoryTile('View All', Icons.view_list, 'Personal Grooming'),
          ]),
        ],
      ),
    );
  }

  Widget buildAnimatedCategoryTile(String title, IconData icon, String query) {
    return FadeTransition(
      opacity: _animation!,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: ListTile(
          leading: Icon(icon, color: Colors.blueAccent),
          title: Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          onTap: () {
            navigateToSearchResults(query);
          },
        ),
      ),
    );
  }

  Widget buildAnimatedExpansionTile(String title, IconData icon, List<Widget> children) {
    return AnimatedBuilder(
      animation: _animation!,
      builder: (context, child) {
        return Opacity(
          opacity: _animation!.value,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Theme(
              data: Theme.of(context).copyWith(
                dividerColor: Colors.transparent,
              ),
              child: ExpansionTile(
                leading: Icon(icon, color: Colors.blueAccent),
                title: Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                children: children.map((child) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: child,
                  );
                }).toList(),
              ),
            ),
          ),
        );
      },
    );
  }

  ListTile buildCategoryTile(String title, IconData icon, String query) {
    return ListTile(
      leading: Icon(icon, color: Colors.blueAccent),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: () {
        navigateToSearchResults(query);
      },
    );
  }
}
