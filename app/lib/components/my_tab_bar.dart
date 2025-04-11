import 'package:flutter/material.dart';
import 'package:test/models/food.dart';

class MyTabBar extends StatelessWidget {
  final TabController tabController;

  const MyTabBar({
    super.key,
    required this.tabController,
  });

  List<Tab> _BuildCategoryTabs() {
    return FoodCategory.values.map((category) {
      return Tab(
        text: category.toString().split(".").last,
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TabBar(
        labelColor: Theme.of(context).colorScheme.inversePrimary,
        dividerColor: Theme.of(context).colorScheme.inversePrimary,
        indicatorColor: Theme.of(context).colorScheme.inversePrimary,
        controller: tabController,
        tabs: _BuildCategoryTabs(),
      ),
    );
  }
}
