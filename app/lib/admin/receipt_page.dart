import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ReceiptPage extends StatefulWidget {
  final String orderId;

  const ReceiptPage({super.key, required this.orderId});

  @override
  _ReceiptPageState createState() => _ReceiptPageState();
}

class _ReceiptPageState extends State<ReceiptPage> {
  Map<String, dynamic>? orderData;

  @override
  void initState() {
    super.initState();
    _fetchOrderDetails();
  }

  Future<void> _fetchOrderDetails() async {
    var orderSnapshot = await FirebaseFirestore.instance
        .collection('orders')
        .doc(widget.orderId)
        .get();

    if (orderSnapshot.exists) {
      setState(() {
        orderData = orderSnapshot.data();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Receipt Details'),
      ),
      body: orderData == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _buildHeader(context),
                    const SizedBox(height: 20),
                    _buildReceiptDetails(context),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Center(
      child: Text(
        'Receipt',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 28,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }

  Widget _buildReceiptDetails(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.inversePrimary,
      margin: const EdgeInsets.all(8.0),
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          'Email: ${orderData!['email'] ?? 'No email available'}\n\n${orderData!['order'] ?? 'No receipt available'}',
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
