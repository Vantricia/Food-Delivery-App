import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:test/admin/admin_drawer.dart';
import 'orders_table.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  List<Map<String, dynamic>> orders = [];

  @override
  void initState() {
    super.initState();
    getOrders();
  }

  Future<void> getOrders() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('orders').get();
    setState(() {
      orders = querySnapshot.docs
          .map((doc) => {
                'id': doc.id,
                'date': doc['date'],
                'email': doc['email'],
                'location': doc['location'],
                'totalItem': doc['totalItem'],
                'total': doc['total'],
                'order': doc['order']
              })
          .toList();
    });
  }

  void handleDelete(String id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Are you sure?'),
          content: const Text("You won't be able to revert this!"),
          actions: <Widget>[
            TextButton(
              child: const Text('No, cancel!'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Yes, delete it!'),
              onPressed: () async {
                await FirebaseFirestore.instance
                    .collection('orders')
                    .doc(id)
                    .delete();
                setState(() {
                  orders = orders.where((order) => order['id'] != id).toList();
                });
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Order deleted!')),
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AdminDrawer(),
      appBar: AppBar(
        title: Text(
          'Orders',
          style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
        ),
      ),
      body: orders.isEmpty
          ? const Center(child: SpinKitCircle(color: Colors.blue))
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Expanded(
                    child: OrdersTable(
                      orders: orders,
                      handleDelete: handleDelete,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
