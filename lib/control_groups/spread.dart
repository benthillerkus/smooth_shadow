import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smooth_shadow/configuration.dart';
import 'package:smooth_shadow/controls/controls.dart';
import 'package:smooth_shadow/controls/slider.dart';

class SpreadControlGroup extends ConsumerWidget {
  const SpreadControlGroup({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final spread =
        ref.watch(configurationProvider.select((value) => (value.spread)));

    return ControlBox.single(
      child: LabeledSlider(
        label: "Reduce spread",
        unit: "px",
        state: Discrete(spread,
            max: 0,
            min: -100,
            onChanged: (value) => ref
                .read(configurationProvider.notifier)
                .update((state) => state.copyWith(spread: value))),
      ),
    );
  }
}
