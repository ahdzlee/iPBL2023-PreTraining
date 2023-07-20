import 'package:flutter/material.dart';

import '../../constants/app.dart';

class ConnectionStateWidget extends StatelessWidget {
  const ConnectionStateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.redAccent,
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        kStrDisconnected,
        textAlign: TextAlign.center,
        style: Theme.of(context)
            .textTheme
            .titleMedium
            ?.copyWith(color: Colors.white),
      ),
    );
  }
}
