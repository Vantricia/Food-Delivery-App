import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:test/models/cart_item.dart';
import 'food.dart';

class Restaurant extends ChangeNotifier {
  final List<Food> _menu = [
    //burger
    Food(
        name: "Cheeseburger",
        description:
            "A juicy beef patty with melted cheese, lettuce, tomato, and pickles in a toasted bun.",
        imagePath: "lib/images/burger/cheeseburger.jpg",
        price: 80,
        category: FoodCategory.burgers,
        availableAddons: [
          Addon(name: "extra cheese", price: 10),
          Addon(name: "bacon", price: 10),
          Addon(name: "extra patty", price: 20),
        ]),
    Food(
        name: "Double Cheeseburger",
        description:
            "Two juicy beef patty with melted cheese, lettuce, tomato, and pickles in a toasted bun.",
        imagePath: "lib/images/burger/doublecheeseburger.jpg",
        price: 95,
        category: FoodCategory.burgers,
        availableAddons: [
          Addon(name: "extra cheese", price: 10),
          Addon(name: "bacon", price: 10),
          Addon(name: "extra patty", price: 10),
        ]),
    Food(
        name: "Bacon Burger",
        description:
            "A juicy beef patty with bacon, melted cheese, lettuce, tomato, and pickles in a toasted bun.",
        imagePath: "lib/images/burger/baconburger.jpg",
        price: 100,
        category: FoodCategory.burgers,
        availableAddons: [
          Addon(name: "extra cheese", price: 10),
          Addon(name: "bacon", price: 10),
          Addon(name: "extra patty", price: 10),
        ]),
    Food(
        name: "Combo Burger",
        description:
            "Two juicy beef patty with bacon, melted cheese, lettuce, tomato, and pickles in a toasted bun.",
        imagePath: "lib/images/burger/comboburger.jpg",
        price: 110,
        category: FoodCategory.burgers,
        availableAddons: [
          Addon(name: "extra cheese", price: 10),
          Addon(name: "bacon", price: 10),
          Addon(name: "extra patty", price: 10),
        ]),
    Food(
        name: "Vegan Burger",
        description:
            "A savory plant-based patty topped with fresh lettuce, tomato, and creamy avocado in a toasted bun.",
        imagePath: "lib/images/burger/veganburger.jpg",
        price: 105,
        category: FoodCategory.burgers,
        availableAddons: [
          Addon(name: "extra cheese", price: 10),
          Addon(name: "extra patty", price: 20),
        ]),
    //salads
    Food(
        name: "Green Salad",
        description:
            "A fresh mix of leafy greens, crisp vegetables, and a light vinaigrette.",
        imagePath: "lib/images/salads/greensalad.jpg",
        price: 60,
        category: FoodCategory.salad,
        availableAddons: [
          Addon(name: "extra sauce", price: 10),
          Addon(name: "chicken", price: 10),
          Addon(name: "extra greens", price: 10),
        ]),
    Food(
        name: "Chopped Salad",
        description:
            "A fresh mix of chopped greens, veggies, and toppings, all tossed in a light vinaigrette.",
        imagePath: "lib/images/salads/choppedsalad.jpg",
        price: 65,
        category: FoodCategory.salad,
        availableAddons: [
          Addon(name: "extra sauce", price: 10),
          Addon(name: "chicken", price: 10),
          Addon(name: "extra greens", price: 10),
        ]),
    Food(
        name: "Rainbow Salad",
        description:
            "A vibrant mix of fresh vegetables, fruits, and greens, bursting with color and flavor.",
        imagePath: "lib/images/salads/rainbowsalad.jpg",
        price: 65,
        category: FoodCategory.salad,
        availableAddons: [
          Addon(name: "extra sauce", price: 10),
          Addon(name: "extra fruits", price: 25),
          Addon(name: "extra greens", price: 10),
        ]),
    Food(
        name: "Coconut Chicken Salad",
        description:
            "A refreshing mix of tender chicken, shredded coconut, and crisp greens, topped with a zesty citrus dressing.",
        imagePath: "lib/images/salads/coconutchickensalad.jpg",
        price: 80,
        category: FoodCategory.salad,
        availableAddons: [
          Addon(name: "extra sauce", price: 10),
          Addon(name: "extra chicken", price: 10),
          Addon(name: "extra greens", price: 10),
        ]),
    Food(
        name: "Mediteranian Salad",
        description:
            "A refreshing mix of crisp vegetables, olives, feta cheese, and a light lemon-olive oil dressing.",
        imagePath: "lib/images/salads/msalad.jpg",
        price: 65,
        category: FoodCategory.salad,
        availableAddons: [
          Addon(name: "extra sauce", price: 10),
          Addon(name: "chicken", price: 10),
          Addon(name: "extra greens", price: 10),
        ]),
    //drinks
    Food(
        name: "Orange Juice",
        description:
            "Freshly squeezed, tangy-sweet orange juice, packed with vitamin C and vibrant flavor.",
        imagePath: "lib/images/drinks/orange.jpg",
        price: 20,
        category: FoodCategory.drinks,
        availableAddons: [
          Addon(name: "Jellies", price: 5),
          Addon(name: "Coconuts", price: 10),
          Addon(name: "Bobas", price: 10),
        ]),
    Food(
        name: "Watermelon Juice",
        description:
            "Refreshing watermelon juice, bursting with sweet, juicy flavor and a hint of summer coolness.",
        imagePath: "lib/images/drinks/watermelon.jpg",
        price: 20,
        category: FoodCategory.drinks,
        availableAddons: [
          Addon(name: "Jellies", price: 5),
          Addon(name: "Coconuts", price: 10),
          Addon(name: "Bobas", price: 10),
        ]),
    Food(
        name: "Matcha Latte",
        description:
            "A creamy blend of matcha green tea, steamed milk, and a touch of sweetness.",
        imagePath: "lib/images/drinks/matchalatte.jpg",
        price: 35,
        category: FoodCategory.drinks,
        availableAddons: [
          Addon(name: "Jellies", price: 5),
          Addon(name: "Coconuts", price: 10),
          Addon(name: "Bobas", price: 10),
        ]),
    Food(
        name: "Iced Latte",
        description:
            "A refreshing blend of espresso and chilled milk over ice, perfect for a cool caffeine boost.",
        imagePath: "lib/images/drinks/coffee.jpg",
        price: 25,
        category: FoodCategory.drinks,
        availableAddons: [
          Addon(name: "Jellies", price: 5),
          Addon(name: "Coconuts", price: 10),
          Addon(name: "Bobas", price: 10),
        ]),
    Food(
        name: "Coca Cola",
        description:
            "A refreshing, carbonated soft drink with a distinctive cola flavor and a hint of caramel sweetness.",
        imagePath: "lib/images/drinks/cocacola.jpg",
        price: 10,
        category: FoodCategory.drinks,
        availableAddons: [
          Addon(name: "Jellies", price: 5),
          Addon(name: "Coconuts", price: 10),
          Addon(name: "Bobas", price: 10),
        ]),
    //sides
    Food(
        name: "Chicken Bites",
        description:
            "Crispy, tender chicken bites perfect for dipping and snacking.",
        imagePath: "lib/images/sides/chickenbites.jpg",
        price: 30,
        category: FoodCategory.sides,
        availableAddons: [
          Addon(name: "extra sauce", price: 5),
          Addon(name: "extra chicken", price: 10),
          Addon(name: "fries", price: 20),
        ]),
    Food(
        name: "Chicken Nuggets",
        description:
            "Crispy, golden-brown chicken nuggets with tender, juicy meat inside.",
        imagePath: "lib/images/sides/chickennuggets.jpg",
        price: 30,
        category: FoodCategory.sides,
        availableAddons: [
          Addon(name: "extra sauce", price: 5),
          Addon(name: "extra nuggets", price: 20),
          Addon(name: "fries", price: 20),
        ]),
    Food(
        name: "French Fries",
        description:
            "Crispy, golden-brown potato strips, lightly salted and perfect for dipping.",
        imagePath: "lib/images/sides/frenchfries.jpg",
        price: 30,
        category: FoodCategory.sides,
        availableAddons: [
          Addon(name: "extra sauce", price: 5),
          Addon(name: "chicken bites", price: 15),
          Addon(name: "extra fries", price: 10),
        ]),
    Food(
        name: "Spring Rolls",
        description:
            "Crispy wrappers filled with fresh vegetables and savory meats, served with a tangy dipping sauce.",
        imagePath: "lib/images/sides/springroll.jpg",
        price: 30,
        category: FoodCategory.sides,
        availableAddons: [
          Addon(name: "extra sauce", price: 5),
          Addon(name: "extra spring rolls", price: 20),
          Addon(name: "fries", price: 20),
        ]),
    Food(
        name: "Chicken Wings",
        description: "Crispy chicken wings perfect for dipping and snacking.",
        imagePath: "lib/images/sides/wings.jpg",
        price: 30,
        category: FoodCategory.sides,
        availableAddons: [
          Addon(name: "extra sauce", price: 5),
          Addon(name: "extra wings", price: 15),
          Addon(name: "fries", price: 20),
        ]),

    //desserts
    Food(
        name: "Creme Brulee",
        description: "A creamy custard topped with a caramelized sugar crust.",
        imagePath: "lib/images/desserts/creme.jpg",
        price: 40,
        category: FoodCategory.dessert,
        availableAddons: [
          Addon(name: "ice cream", price: 10),
          Addon(name: "whipped cream", price: 5),
          Addon(name: "caramel drizzle", price: 5),
        ]),
    Food(
        name: "Chocolate Lava Cake",
        description:
            "A decadent chocolate cake with a molten, gooey center that oozes rich chocolate when cut.",
        imagePath: "lib/images/desserts/lavacake.jpg",
        price: 40,
        category: FoodCategory.dessert,
        availableAddons: [
          Addon(name: "ice cream", price: 10),
          Addon(name: "whipped cream", price: 5),
          Addon(name: "caramel drizzle", price: 5),
        ]),
    Food(
        name: "Caramel Cake",
        description:
            "A moist cake layered with rich, buttery caramel frosting, delivering a sweet and decadent flavor.",
        imagePath: "lib/images/desserts/caramelcake.jpg",
        price: 40,
        category: FoodCategory.dessert,
        availableAddons: [
          Addon(name: "ice cream", price: 10),
          Addon(name: "whipped cream", price: 5),
          Addon(name: "caramel drizzle", price: 5),
        ]),
    Food(
        name: "Fruit Pie",
        description:
            "A delightful fruit pie filled with sweet, juicy fruit encased in a flaky, golden crust.",
        imagePath: "lib/images/desserts/fruitpie.jpg",
        price: 40,
        category: FoodCategory.dessert,
        availableAddons: [
          Addon(name: "ice cream", price: 10),
          Addon(name: "whipped cream", price: 5),
          Addon(name: "caramel drizzle", price: 5),
        ]),
    Food(
        name: "Waffles",
        description: "Crispy on the outside, fluffy on the inside.",
        imagePath: "lib/images/desserts/waffles.jpg",
        price: 40,
        category: FoodCategory.dessert,
        availableAddons: [
          Addon(name: "ice cream", price: 10),
          Addon(name: "whipped cream", price: 5),
          Addon(name: "caramel drizzle", price: 5),
        ]),
  ];

  //delivery address
  String _deliveryAddress = 'blv';
  //Getters
  //get menu
  List<Food> get menu => _menu;
  List<CartItem> get cart => _cart;
  String get deliveryAddress => _deliveryAddress;
  //user cart
  final List<CartItem> _cart = [];

  //operation
  //update delivery address
  void updateDeliveryAddress(String newAddress) {
    _deliveryAddress = newAddress;
    notifyListeners();
  }

  //add to cart
  void addToCart(Food food, List<Addon> selectedAddons) {
    CartItem? cartItem = _cart.firstWhereOrNull((item) {
      bool isSameFood = item.food == food;
      bool isSameAddons =
          const ListEquality().equals(item.selectedAddon, selectedAddons);

      return isSameFood && isSameAddons;
    });

    if (cartItem != null) {
      cartItem.quantity++;
    } else {
      _cart.add(CartItem(
        food: food,
        selectedAddon: selectedAddons,
      ));
    }
    notifyListeners();
  }

  //remove from cart
  void removeFromCart(CartItem cartItem) {
    int cartIndex = _cart.indexOf(cartItem);

    if (cartIndex != -1) {
      if (_cart[cartIndex].quantity > 1) {
        _cart[cartIndex].quantity--;
      } else {
        _cart.removeAt(cartIndex);
      }
      notifyListeners();
    }
  }

  //total price
  double getTotalPrice({double discount = 0.0}) {
    double total = 0.0;
    for (CartItem cartItem in _cart) {
      double itemTotal = cartItem.food.price;

      for (Addon addon in cartItem.selectedAddon) {
        itemTotal += addon.price;
      }
      total += itemTotal * cartItem.quantity;
    }
    return total * (1 - discount);
  }

  //get total number of items in cart
  int getTotalItemCount() {
    int totalItemCount = 0;

    for (CartItem cartItem in _cart) {
      totalItemCount += cartItem.quantity;
    }
    return totalItemCount;
  }

  //clear cart
  void clearCart() {
    _cart.clear();
    notifyListeners();
  }

  //helpers
  //print receipt
  String displayCartReceipt(double discount) {
    final receipt = StringBuffer();
    receipt.writeln("Here's your receipt.");
    receipt.writeln();

    //format date
    String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

    receipt.writeln(formattedDate);
    receipt.writeln();
    receipt.writeln("-------------");
    receipt.writeln();

    for (final cartItem in _cart) {
      receipt.writeln(
          "${cartItem.quantity} x ${cartItem.food.name} - ${_formatPrice(cartItem.food.price)}");
      if (cartItem.selectedAddon.isNotEmpty) {
        receipt.writeln("   Add-ons: ${_formatAddons(cartItem.selectedAddon)}");
      }
      receipt.writeln();
    }
    receipt.writeln('-------------');
    receipt.writeln();
    receipt.writeln("Total Item: ${getTotalItemCount()}");
    double discountedTotalPrice = getTotalPrice() * (1 - discount);
    receipt.writeln("Total Price: ${_formatPrice(discountedTotalPrice)}");
    receipt.writeln();
    receipt.writeln("Delivering to: $deliveryAddress");

    return receipt.toString();
  }

  //format double value into money
  String _formatPrice(double price) {
    return '\$${price.toStringAsFixed(2)}';
  }

  //format list of addons into a string summary
  String _formatAddons(List<Addon> addon) {
    return addon
        .map((addon) => ('${addon.name} ${_formatPrice(addon.price)}'))
        .join(', ');
  }
}
