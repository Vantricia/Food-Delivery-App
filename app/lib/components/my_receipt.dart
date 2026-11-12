import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/models/restaurant.dart';

class MyReceipt extends StatelessWidget {
  final double discount;

  const MyReceipt({super.key, required this.discount});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding:
              const EdgeInsets.only(left: 25, right: 25, bottom: 25, top: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Thank you for your order!',
              ),
              const SizedBox(
                height: 25,
              ),
              Container(
                decoration: BoxDecoration(
                  border:
                      Border.all(color: Theme.of(context).colorScheme.primary),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(25),
                child: Consumer<Restaurant>(
                  builder: (context, restaurant, child) =>
                      Text(restaurant.displayCartReceipt(discount)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
