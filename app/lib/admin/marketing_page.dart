import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MarketingPage extends StatelessWidget {
  const MarketingPage({super.key});

  Future sendEmail({
    required String name,
    required String email,
    required String subject,
    required String message,
  }) async {
    const String serviceId = 'service_l1yl7sj';
    const String templateId = 'template_hlbe62s';
    const String userId = 'ARyC4qnwJwh1jbx88';

    final url = Uri.parse("https://api.emailjs.com/api/v1.0/email/send");
    final response = await http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          "service_id": serviceId,
          "template_id": templateId,
          "user_id": userId,
          "template_params": {
            "user_name": name,
            "user_email": email,
            "user_subject": subject,
            "user_message": message,
          }
        }));

    print(response.body);
  }

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final subjectController = TextEditingController();
    final messageController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Email Marketing',
          style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
        ),
        backgroundColor: Theme.of(context).colorScheme.surface,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            const Text(
              'Please fill out the form below to send your message.',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'My Name',
                labelStyle:
                    TextStyle(color: Theme.of(context).colorScheme.secondary),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.secondary),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle:
                    TextStyle(color: Theme.of(context).colorScheme.secondary),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.secondary),
                ),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: subjectController,
              decoration: InputDecoration(
                labelText: 'Subject',
                labelStyle:
                    TextStyle(color: Theme.of(context).colorScheme.secondary),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.secondary),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: messageController,
              decoration: InputDecoration(
                labelText: 'Message',
                labelStyle:
                    TextStyle(color: Theme.of(context).colorScheme.secondary),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.secondary),
                ),
              ),
              maxLines: 5,
            ),
            const SizedBox(height: 24),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  final name = nameController.text;
                  final email = emailController.text;
                  final subject = subjectController.text;
                  final message = messageController.text;

                  // Handle the form submission logic here
                  print('Name: $name');
                  print('Email: $email');
                  print('Subject: $subject');
                  print('Message: $message');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.surface,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text('Submit', style: TextStyle(fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
