import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smooth_shadow/configuration.dart';
import 'package:smooth_shadow/controls/controls.dart';
import 'package:smooth_shadow/controls/slider.dart';

class LayersControlGroup extends ConsumerWidget {
  const LayersControlGroup({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final layerCount =
        ref.watch(configurationProvider.select((value) => value.layerCount));

    return ControlBox.single(
      child: LabeledSlider(
        label: "Layers of shadows",
        state: Discrete(
          layerCount,
          max: 10,
          onChanged: (value) => ref
              .read(configurationProvider.notifier)
              .update((state) => state.copyWith(layerCount: value)),
        ),
      ),
    );
  }
}
