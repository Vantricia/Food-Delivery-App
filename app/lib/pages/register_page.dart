import 'package:flutter/material.dart';
import 'package:test/components/my_textfield.dart';
import 'package:test/components/my_button.dart';
import 'package:test/services/auth/auth_service.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //text editing controllers for email and password
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  //register method

  void register() async {
    //get auth service
    final authService = AuthService();

    //check if password match -> create user
    if (passwordController.text == confirmPasswordController.text) {
      //create user
      try {
        await authService.signUpWithEmailPassword(
            emailController.text, passwordController.text);
      }

      //display any errors
      catch (e) {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text(e.toString()),
                ));
      }
    }

    //if password dont match -> show error
    else {
      showDialog(
          context: context,
          builder: (context) => const AlertDialog(
                title: Text('passwords do not  match'),
              ));
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //logo
          Icon(Icons.lock_open_rounded,
              size: 72, color: Theme.of(context).colorScheme.inversePrimary),

          const SizedBox(height: 25),

          //message,slogan
          Text(
            "Create an account",
            style: TextStyle(
              fontSize: 16,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
          ),

          const SizedBox(height: 25),

          //email textfield
          MyTextfield(
            controller: emailController,
            hintText: "Email",
            obscureText: false,
          ),

          const SizedBox(height: 10),

          //password textfield
          MyTextfield(
            controller: passwordController,
            hintText: "Password",
            obscureText: true,
          ),

          const SizedBox(height: 10),

          //confirm password textfield
          MyTextfield(
            controller: confirmPasswordController,
            hintText: "Confirm Password",
            obscureText: true,
          ),

          const SizedBox(height: 10),
          //sign up button
          MyButton(
            text: "Sign Up",
            onTap: register,
          ),

          const SizedBox(height: 125),
          //Already have an account? Login here
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Already have an account?",
                style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary),
              ),
              const SizedBox(width: 4),
              GestureDetector(
                onTap: widget.onTap,
                child: Text(
                  "Login Now",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
