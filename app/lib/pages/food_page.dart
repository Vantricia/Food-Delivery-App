import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/components/my_button.dart';
import 'package:test/models/food.dart';
import 'package:test/models/restaurant.dart';

class FoodPage extends StatefulWidget {
  final Food food;
  final Map<Addon, bool> selectedAddons = {};

  FoodPage({
    super.key,
    required this.food,
  }) {
    for (Addon addon in food.availableAddons) {
      selectedAddons[addon] = false;
    }
  }

  @override
  State<FoodPage> createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  void addToCart(Food food, Map<Addon, bool> selectedAddons) {
    //close current page
    Navigator.pop(context);

    //format selected addons
    List<Addon> currentlySelectedAddons = [];
    for (Addon addon in widget.food.availableAddons) {
      if (widget.selectedAddons[addon] == true) {
        currentlySelectedAddons.add(addon);
      }
    }
    //add to cart
    context.read<Restaurant>().addToCart(food, currentlySelectedAddons);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Scaffold(
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //food image
                SizedBox(
                  width: screenWidth,
                  child: Image.asset(
                    widget.food.imagePath,
                    alignment: AlignmentDirectional.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      //food name
                      Text(
                        widget.food.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),

                      Text(
                        '\$${widget.food.price}',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary),
                      ),

                      //food description
                      Text(widget.food.description),
                      const SizedBox(
                        height: 15,
                      ),

                      const Text(
                        'Add-ons',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      //Addons
                      Container(
                        padding: EdgeInsets.zero,
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 1,
                                color:
                                    Theme.of(context).colorScheme.secondary)),
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: widget.food.availableAddons.length,
                          itemBuilder: (context, index) {
                            Addon addon = widget.food.availableAddons[index];
                            return CheckboxListTile(
                              title: Text(addon.name),
                              subtitle: Text(
                                '\$${addon.price}',
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary),
                              ),
                              value: widget.selectedAddons[addon],
                              onChanged: (bool? value) {
                                setState(() {
                                  widget.selectedAddons[addon] = value!;
                                });
                              },
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                MyButton(
                    text: 'Add to Cart',
                    onTap: () {
                      addToCart(widget.food, widget.selectedAddons);
                    }),
                const SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ),
        //back button
        SafeArea(
            child: Opacity(
          opacity: 0.7,
          child: Container(
            margin: const EdgeInsets.only(left: 25),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.inversePrimary,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ))
      ],
    );
  }
}
