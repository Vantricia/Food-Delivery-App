import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/models/restaurant.dart';

class MyCurrentLocation extends StatelessWidget {
  final textController = TextEditingController();
  void openLocationSearchBox(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Your Location"),
        content: TextField(
          controller: textController,
          decoration: const InputDecoration(hintText: "Search Adress.."),
        ),
        actions: [
          //cancelbutton
          MaterialButton(
            onPressed: () {
              Navigator.pop(context);
              textController.clear();
            },
            child: const Text("Cancel"),
          ),
          //savebutton
          MaterialButton(
            onPressed: () {
              //update new address
              String newAddress = textController.text;
              context.read<Restaurant>().updateDeliveryAddress(newAddress);
              Navigator.pop(context);
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  MyCurrentLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Deliver Now",
            style:
                TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
          ),
          GestureDetector(
            onTap: () => openLocationSearchBox(context),
            child: Row(
              children: [
                Consumer<Restaurant>(
                  builder: (context, restarant, child) => Text(
                    restarant.deliveryAddress,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Icon(Icons.keyboard_arrow_down_rounded,
                    color: Theme.of(context).colorScheme.inversePrimary),
              ],
            ),
          )
        ],
      ),
    );
  }
}
