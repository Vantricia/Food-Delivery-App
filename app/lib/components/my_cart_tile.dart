import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:test/components/my_quantity_selector.dart";
import "package:test/models/cart_item.dart";
import "package:test/models/restaurant.dart";

class MyCartTile extends StatelessWidget {
  final CartItem cartItem;
  const MyCartTile({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    return Consumer<Restaurant>(
        builder: (context, restaurant, child) => Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      width: 1,
                      color: Theme.of(context).colorScheme.secondary)),
              margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //food image
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(
                            cartItem.food.imagePath,
                            height: 100,
                            width: 100,
                          ),
                        ),

                        const SizedBox(
                          width: 10,
                        ),

                        //name price
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 5,
                            ),
                            Text(cartItem.food.name),
                            Text(
                              '\$${cartItem.food.price}',
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.secondary),
                            ),
                            //increment decrement
                            QuantitySelector(
                                quantity: cartItem.quantity,
                                food: cartItem.food,
                                onIncrement: () {
                                  restaurant.addToCart(
                                      cartItem.food, cartItem.selectedAddon);
                                },
                                onDecrement: () {
                                  restaurant.removeFromCart(cartItem);
                                }),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: cartItem.selectedAddon.isEmpty ? 0 : 60,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.only(right: 8.0),
                      children: cartItem.selectedAddon
                          .map((addon) => Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 10, left: 10, right: 10),
                                child: FilterChip(
                                  label: Row(
                                    children: [
                                      //addon name
                                      Text(
                                        addon.name,
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary),
                                      ),

                                      //addon price
                                      Text(
                                        ' \$${addon.price}',
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary),
                                      ),
                                    ],
                                  ),
                                  shape: StadiumBorder(
                                      side: BorderSide(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary)),
                                  onSelected: (value) {},
                                  backgroundColor: Theme.of(context)
                                      .colorScheme
                                      .inversePrimary,
                                  labelStyle: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    fontSize: 12,
                                  ),
                                ),
                              ))
                          .toList(),
                    ),
                  ),
                ],
              ),
            ));
  }
}
