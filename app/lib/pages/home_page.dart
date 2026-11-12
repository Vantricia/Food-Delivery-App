import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/components/my_current_location.dart';
import 'package:test/components/my_description_box.dart';
import 'package:test/components/my_drawer.dart';
import 'package:test/components/my_food_tile.dart';
import 'package:test/components/my_sliver_app_bar.dart';
import 'package:test/components/my_tab_bar.dart';
import 'package:test/components/my_username.dart';
import 'package:test/models/food.dart';
import 'package:test/models/restaurant.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String? userEmail;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: FoodCategory.values.length, vsync: this);
    getCurrentUserEmail();
  }

  Future<void> getCurrentUserEmail() async {
    User? user = FirebaseAuth.instance.currentUser;
    setState(() {
      userEmail = user?.email;
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  //sort out the list of food that belong to a specific category
  List<Food> _filterMenuByCategory(FoodCategory category, List<Food> fullMenu) {
    return fullMenu.where((food) => food.category == category).toList();
  }

  //return list of food in the category
  List<Widget> getFoodinThisCategory(List<Food> fullMenu) {
    return FoodCategory.values.map((category) {
      List<Food> categoryMenu = _filterMenuByCategory(category, fullMenu);

      return ListView.builder(
          itemCount: categoryMenu.length,
          padding: EdgeInsets.zero,
          itemBuilder: (context, index) {
            final food = categoryMenu[index];
            return FoodTile(food: food, onTap: () {});
          });
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const MyDrawer(),
        body: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
                  MySliverAppBar(
                    title: MyTabBar(tabController: _tabController),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                '      Hi,',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .inversePrimary),
                              ),
                              MyUsername(),
                            ],
                          ),
                          Divider(
                            indent: 25,
                            endIndent: 25,
                            color: Theme.of(context).colorScheme.inversePrimary,
                          ),
                          //my current location
                          MyCurrentLocation(),
                          //description box
                          const MyDescriptionBox(),
                        ],
                      ),
                    ),
                  ),
                ],
            body: Consumer<Restaurant>(
                builder: (context, restaurant, child) => TabBarView(
                    controller: _tabController,
                    children: getFoodinThisCategory(restaurant.menu)))));
  }
}
