import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/services/auth/auth_gate.dart';
import 'package:test/firebase_options.dart';
import 'package:test/models/restaurant.dart';
import 'package:test/themes/theme_provider.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey =
      'pk_test_51PVpc0Fd5dPHDqPbfMtCpRI195SDNTupMxOXZb5yZAX9JicB1PASHifbZvgy9tnNpn4YszobsMfOou885Hs0KLR100BLc7DmNn';
  await Stripe.instance.applySettings();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(MultiProvider(
    providers: [
      //theme
      ChangeNotifierProvider(create: (context) => ThemeProvider()),
      //restaurant
      ChangeNotifierProvider(create: (context) => Restaurant()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const AuthGate(),
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}
