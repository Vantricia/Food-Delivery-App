import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:test/pages/stripe_page.dart";
import "package:test/components/my_button.dart";
import "package:test/components/my_cart_tile.dart";
import "package:test/models/restaurant.dart";

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Restaurant restaurant = Restaurant();
    return Consumer<Restaurant>(builder: (context, restaurant, child) {
      final userCart = restaurant.cart;

      return Scaffold(
        appBar: AppBar(
          title: const Text("Cart"),
          foregroundColor: Theme.of(context).colorScheme.primary,
          actions: [
            IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("Clear cart?"),
                      actions: [
                        //cancelbutton
                        TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text("Cancel")),
                        //yesbutton
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              restaurant.clearCart();
                            },
                            child: const Text('yes'))
                      ],
                    ),
                  );
                },
                icon: const Icon(Icons.delete))
          ],
        ),
        body: Column(
          children: [
            //list of cart
            Expanded(
              child: Column(
                children: [
                  userCart.isEmpty
                      ? const Expanded(
                          child: Center(child: Text("Cart is empty")))
                      : Expanded(
                          child: ListView.builder(
                              itemCount: userCart.length,
                              itemBuilder: (context, index) {
                                //get individual cart item
                                final cartItem = userCart[index];

                                //return cart tile ui
                                return MyCartTile(cartItem: cartItem);
                              }))
                ],
              ),
            ),

            //button to pay
            MyButton(
                text: "Go to checkout",
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PaymentsPage(
                              restaurant: restaurant,
                            )))),

            const SizedBox(
              height: 25,
            )
          ],
        ),
      );
    });
  }
}
