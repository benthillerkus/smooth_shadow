import 'package:flutter/widgets.dart';
import 'package:smooth_shadow/control_groups/blur.dart';
import 'package:smooth_shadow/control_groups/distance.dart';
import 'package:smooth_shadow/control_groups/layers.dart';
import 'package:smooth_shadow/control_groups/opacity.dart';

class ConfiguratorList extends StatelessWidget {
  const ConfiguratorList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        for (final Widget widget in [
          const LayersControlGroup(),
          const OpacityControlGroup(),
          const DistanceControlGroup(),
          const BlurControlGroup(),
        ])
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: widget,
          )
      ],
    );
  }
}
