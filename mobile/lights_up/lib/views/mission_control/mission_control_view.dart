import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';

import '../../constants/app.dart';
import '../../constants/mqtt_topics.dart';
import '../../state/providers/listen_for_updates_provider.dart';
import '../../state/providers/mqtt_client_manager_provider.dart';

class MissionControlView extends HookConsumerWidget {
  const MissionControlView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mqttManager = ref.watch(mqttClientManagerProvider);
    bool isLightsOn = ref.watch(isLightsOnProvider);

    useEffect(() {
      ref.watch(listenForUpdatesProvider);
      return null;
    }, const []);

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
                value: isLightsOn,
                onChanged: (value) {
                  isLightsOn = value;
                  mqttManager?.publish(
                    kBedRoomLights,
                    isLightsOn ? '1' : '0',
                  );
                },
              ),
            ],
          ),
          Icon(
            Icons.lightbulb_circle_rounded,
            size: 350,
            color: isLightsOn ? Colors.amber.shade300 : Colors.grey.shade300,
          ),
        ],
      ),
    );
  }
}
