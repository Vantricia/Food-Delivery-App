import "package:flutter/material.dart";
import "package:test/models/food.dart";
import "package:test/pages/food_page.dart";

class FoodTile extends StatelessWidget {
  final Food food;
  final Function()? onTap;

  const FoodTile({
    super.key,
    required this.food,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => FoodPage(food: food))),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                //text food
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        food.name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '\$${food.price}',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary),
                      ),
                      const SizedBox(height: 10),
                      Text(food.description),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.asset(
                    food.imagePath,
                    height: 120,
                    width: 140,
                  ),
                )
              ],
            ),
          ),
        ),
        Divider(
          color: Theme.of(context).colorScheme.secondary,
        )
      ],
    );
  }
}
