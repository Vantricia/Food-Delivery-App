import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:test/models/restaurant.dart';
import 'delivery_progress_page.dart'; // Import your DeliveryProgressPage

import '../admin/env.dart';

class PaymentsPage extends StatefulWidget {
  final Restaurant restaurant;

  const PaymentsPage({super.key, required this.restaurant});

  @override
  State<PaymentsPage> createState() => _PaymentsPageState();
}

class _PaymentsPageState extends State<PaymentsPage> {
  late GlobalKey<FormState> paymentForm;
  Map<String, dynamic>? paymentIntentData;
  TextEditingController voucherController = TextEditingController();
  double discount = 0.0;

  @override
  void initState() {
    super.initState();
    paymentForm = GlobalKey<FormState>();
  }

  void applyVoucher() {
    String voucherCode = voucherController.text.trim();
    setState(() {
      if (voucherCode == 'DISCOUNT10') {
        discount = 0.10; // 10% discount
      } else if (voucherCode == 'DISCOUNT20') {
        discount = 0.20; // 20% discount
      } else {
        discount = 0.0; // Invalid or no voucher
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid voucher code')),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final double totalPrice = widget.restaurant.getTotalPrice();
    final double discountedPrice = totalPrice * (1 - discount);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: paymentForm,
          child: ListView(
            shrinkWrap: true,
            children: [
              _buildVoucherSection(),
              const SizedBox(height: 20),
              if (discount > 0) ...[
                Text(
                  'Total Price: \$${totalPrice.toStringAsFixed(2)}',
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.lineThrough),
                ),
                const SizedBox(height: 10),
                Text(
                  'Discounted Price: \$${discountedPrice.toStringAsFixed(2)}',
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.green),
                ),
              ] else ...[
                Text(
                  'Total Price: \$${totalPrice.toStringAsFixed(2)}',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  var paymentAmount = (discountedPrice * 100).toInt();
                  makePayment(
                      amount: paymentAmount.toString(), currency: "USD");
                },
                child: const Text('Make Payment'),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVoucherSection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Colors.grey),
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Have a voucher?',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: voucherController,
            decoration: InputDecoration(
              labelText: 'Enter Voucher Code',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: applyVoucher,
            child: const Text('Apply Voucher'),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> makePayment(
      {required String amount, required String currency}) async {
    debugPrint(amount);
    try {
      paymentIntentData = await createPaymentIntent(amount, currency);

      const gpay = PaymentSheetGooglePay(
        merchantCountryCode: "US",
        currencyCode: "USD",
        testEnv: true,
      );
      if (paymentIntentData != null) {
        await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
            googlePay: gpay,
            merchantDisplayName: 'Adiwele',
            paymentIntentClientSecret: paymentIntentData!['client_secret'],
            customerEphemeralKeySecret: paymentIntentData!['ephemeralKey'],
          ),
        );
        displayPaymentSheet();
      }
    } catch (e, s) {
      debugPrint('exception:$e$s');
    }
  }

  displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet().then(
        (value) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => DeliveryProgressPage(discount: discount),
            ),
            (route) => false,
          );
        },
      );
    } on StripeException catch (e) {
      debugPrint('Payment failed: ${e.error.localizedMessage}');
    } catch (e) {
      debugPrint('An unexpected error occurred: $e');
    }
  }

  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': amount,
        'currency': currency,
        'payment_method_types[]': 'card'
      };
      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        body: body,
        headers: {
          'Authorization':
              'Bearer sk_test_51PVpc0Fd5dPHDqPbnTMeylmUk8TjrTVgsvl0oxPxpWMJYsZNL2D5DbPdqF9dd3ms1zXVdg2xLhnQKONuiIs4Kup500AjY3mKeC',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
      );

      return jsonDecode(response.body.toString());
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
