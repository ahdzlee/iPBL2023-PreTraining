import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';

import '../../constants/app.dart';
import '../../constants/mqtt_topics.dart';
import '../../state/providers/mqtt_client_manager_provider.dart';

class MissionControlView extends HookConsumerWidget {
  const MissionControlView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mqttManager = ref.watch(mqttClientManagerProvider);

    final isLightsOn = useState(false);

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
                value: isLightsOn.value,
                onChanged: (value) {
                  isLightsOn.value = value;
                  mqttManager?.publish(
                    kBedRoomLights,
                    isLightsOn.value ? '1' : '0',
                  );
                },
              ),
            ],
          ),
          Icon(
            Icons.lightbulb_circle_rounded,
            size: 350,
            color:
                isLightsOn.value ? Colors.amber.shade300 : Colors.grey.shade300,
          ),
        ],
      ),
    );
  }
}
