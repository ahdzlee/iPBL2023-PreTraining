import 'dart:math';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../constants/app.dart';
import '../../state/mqtt_client_manager.dart';

class BrokerView extends HookWidget {
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
    final serverController = useTextEditingController();
    final portController = useTextEditingController();
    final usernameController = useTextEditingController();
    final passwordController = useTextEditingController();
    final clientIdController = useTextEditingController();

    const defaultPort = 1883;

    final server = useRef('');
    final port = useRef(defaultPort);
    final username = useRef('');
    final password = useRef('');
    final clientId = useRef('');

    useEffect(() {
      serverController.addListener(() {
        server.value = serverController.text;
      });

      portController.text = defaultPort.toString();
      portController.addListener(() {
        port.value = int.tryParse(portController.text) ?? defaultPort;
      });

      usernameController.addListener(() {
        username.value = usernameController.text;
      });

      passwordController.addListener(() {
        password.value = passwordController.text;
      });

      clientIdController.addListener(() {
        clientId.value = clientIdController.text;
      });
      return null;
    }, []);

    void handleMqttClientConnect() {
      if (server.value.isEmpty) {
        showSnackBar(context, 'Server is required');
        return;
      }

      if (clientId.value.isEmpty) {
        // generate a random client id if not provided
        var random = Random();
        clientId.value = 'flutter_client_${random.nextInt(100)}';
      }

      final mqttManager = MqttClientManager(
        server: server.value,
        port: port.value,
        username: username.value,
        password: password.value,
        clientId: clientId.value,
      );
      mqttManager.connect();
    }

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Icon(Icons.cloud_off_outlined, size: 150, color: Colors.teal),
            const SizedBox(height: 16),
            TextField(
              controller: serverController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: kStrServer,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: portController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: kStrPort,
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
            const SizedBox(height: 16),
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: kStrUsername,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: kStrPassword,
              ),
              obscureText: true,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: clientIdController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: kStrClientId,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: handleMqttClientConnect,
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
