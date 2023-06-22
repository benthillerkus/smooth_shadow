import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smooth_shadow/control_groups/blur.dart';
import 'package:smooth_shadow/control_groups/distance.dart';
import 'package:smooth_shadow/control_groups/layers.dart';
import 'package:smooth_shadow/control_groups/opacity.dart';
import 'package:smooth_shadow/control_groups/spread.dart';

class ConfiguratorList extends ConsumerWidget {
  const ConfiguratorList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(
      primary: true,
      clipBehavior: Clip.none,
      children: [
        for (final Widget widget in [
          const LayersControlGroup(),
          const OpacityControlGroup(),
          const DistanceControlGroup(),
          const BlurControlGroup(),
          const SpreadControlGroup(),
        ])
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: widget,
          )
      ],
    );
  }
}
