import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/components/my_receipt.dart';
import 'package:test/database/firestore.dart';
import 'package:test/models/restaurant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test/pages/home_page.dart'; // Ensure you have the correct import for HomePage

class DeliveryProgressPage extends StatefulWidget {
  final double discount;

  const DeliveryProgressPage({super.key, required this.discount});

  @override
  State<DeliveryProgressPage> createState() => _DeliveryProgressPageState();
}

class _DeliveryProgressPageState extends State<DeliveryProgressPage> {
  // Get access to the database
  FirestoreService db = FirestoreService();
  String? driverName;
  String? orderId;

  @override
  void initState() {
    super.initState();

    // Submit order to Firestore db and get the order ID
    String receipt =
        context.read<Restaurant>().displayCartReceipt(widget.discount);
    double total = context.read<Restaurant>().getTotalPrice();
    String location = context.read<Restaurant>().deliveryAddress;
    String totalItem =
        context.read<Restaurant>().getTotalItemCount().toString();
    double discountedTotal = total * (1 - widget.discount);

    db
        .saveOrderToDatabase(receipt, discountedTotal, location, totalItem)
        .then((id) {
      setState(() {
        orderId = id;
      });
      // Fetch driver's name from Firestore
      _fetchDriverName(id);
    });
  }

  Future<void> _fetchDriverName(String orderId) async {
    try {
      var orderSnapshot = await FirebaseFirestore.instance
          .collection('orders')
          .doc(orderId)
          .get();

      if (orderSnapshot.exists) {
        setState(() {
          driverName = orderSnapshot.data()?['driver'] ?? 'Unknown';
        });
      }
    } catch (e) {
      debugPrint('Error fetching driver name: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Delivery in Progress'),
        actions: [
          IconButton(
            icon: Icon(
              Icons.home,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
                (route) => false,
              );
            },
          ),
        ],
      ),
      // Rider details
      bottomNavigationBar: _buildBottomNavBar(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              MyReceipt(
                discount: widget.discount,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavBar(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      padding: const EdgeInsets.all(25),
      child: Row(
        children: [
          // Driver's profile picture
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.inversePrimary,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.person),
              onPressed: () {},
            ),
          ),
          const SizedBox(width: 10),
          // Driver details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Name: ${driverName ?? "Searching.."}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                Text(
                  'Driver',
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
              ],
            ),
          ),
          // Message button
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.inversePrimary,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.message),
              onPressed: () {},
              color: Colors.green,
            ),
          ),
          const SizedBox(width: 8),
          // Call button
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.inversePrimary,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.call),
              onPressed: () {},
              color: Colors.green,
            ),
          ),
        ],
      ),
    );
  }
}
