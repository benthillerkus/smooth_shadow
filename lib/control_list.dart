import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smooth_shadow/configuration.dart';
import 'package:smooth_shadow/control_groups/blur.dart';
import 'package:smooth_shadow/control_groups/distance.dart';
import 'package:smooth_shadow/control_groups/layers.dart';
import 'package:smooth_shadow/control_groups/opacity.dart';
import 'package:smooth_shadow/controls/controls.dart';
import 'package:smooth_shadow/controls/curve.dart';
import 'package:smooth_shadow/controls/slider.dart';
import 'package:smooth_shadow/main.dart';

class ConfiguratorList extends ConsumerWidget {
  const ConfiguratorList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final configuration = ref.watch(configurationProvider);

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
