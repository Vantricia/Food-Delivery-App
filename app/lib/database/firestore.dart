import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class FirestoreService {
  //get collection of orders
  String? userEmail;
  String? getCurrentUserEmail() {
    User? user = FirebaseAuth.instance.currentUser;
    userEmail = user?.email;
    return userEmail;
  }

  String _formatPrice(double price) {
    return '\$${price.toStringAsFixed(2)}';
  }

  DateFormat formatter = DateFormat('yyyy-MM-dd');
  final CollectionReference orders =
      FirebaseFirestore.instance.collection('orders');

  //save order to db
  Future<String> saveOrderToDatabase(
      String receipt, double total, String location, String totalItem) async {
    DocumentReference orderRef = await orders.add({
      'date': formatter.format(DateTime.now()),
      'email': getCurrentUserEmail().toString(),
      'total': _formatPrice(total),
      'location': location,
      'totalItem': totalItem,
      'order': receipt,
      'driver': "Searching..",
    });
    return orderRef.id;
  }
}
