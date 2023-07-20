import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../constants/app.dart';

class BrokerView extends StatelessWidget {
  const BrokerView({super.key});

  void showSnackBar(BuildContext context, String message,
      [int durationInSeconds = 3]) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: durationInSeconds),
        dismissDirection: DismissDirection.horizontal,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Icon(Icons.cloud_off_outlined, size: 150, color: Colors.teal),
            const SizedBox(height: 16),
            const TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: kStrServer,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: kStrPort,
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
            const SizedBox(height: 16),
            const TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: kStrUsername,
              ),
            ),
            const SizedBox(height: 16),
            const TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: kStrPassword,
              ),
              obscureText: true,
            ),
            const SizedBox(height: 16),
            const TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: kStrClientId,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => showSnackBar(context, 'Connecting to broker...'),
              style: ButtonStyle(
                padding: MaterialStateProperty.all(
                  const EdgeInsets.symmetric(
                    horizontal: 48,
                    vertical: 14,
                  ),
                ),
                backgroundColor: MaterialStateProperty.all(Colors.teal),
              ),
              child: const Text(kStrConnect),
            ),
          ],
        ),
      ),
    );
  }
}
