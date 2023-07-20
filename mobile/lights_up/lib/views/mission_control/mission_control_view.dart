import 'package:flutter/material.dart';

import '../../constants/app.dart';

class MissionControlView extends StatelessWidget {
  const MissionControlView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                kStrTurnOnTheLights,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Switch(
                value: true,
                onChanged: (value) {},
              ),
            ],
          ),
          Icon(
            Icons.lightbulb_circle_rounded,
            size: 350,
            color: Colors.grey.shade300,
          ),
        ],
      ),
    );
  }
}
