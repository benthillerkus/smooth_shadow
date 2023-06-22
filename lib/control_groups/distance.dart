import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smooth_shadow/configuration.dart';
import 'package:smooth_shadow/controls/controls.dart';
import 'package:smooth_shadow/controls/curve.dart';
import 'package:smooth_shadow/controls/slider.dart';
import 'package:smooth_shadow/main.dart';

class DistanceControlGroup extends StatelessWidget {
  const DistanceControlGroup({super.key});

  @override
  Widget build(BuildContext context) {
    return const ControlBox(children: [
      _MaxHorizontalDistance(),
      _MaxVerticalDistance(),
      _DistanceDistribution()
    ]);
  }
}

class _MaxHorizontalDistance extends ConsumerWidget {
  // ignore: unused_element
  const _MaxHorizontalDistance({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final maxDistance = ref
        .watch(configurationProvider.select((value) => value.maxDistance.dx));
    return LabeledSlider(
      label: "Final horizontal distance",
      unit: "px",
      state: Continuous(maxDistance,
          max: 500,
          onChanged: (value) => ref.read(configurationProvider.notifier).update(
              (state) => state.copyWith(
                  maxDistance: Offset(value, state.maxDistance.dy)))),
    );
  }
}

class _MaxVerticalDistance extends ConsumerWidget {
  // ignore: unused_element
  const _MaxVerticalDistance({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final maxDistance = ref
        .watch(configurationProvider.select((value) => value.maxDistance.dy));
    return LabeledSlider(
      label: "Final vertical distance",
      unit: "px",
      state: Continuous(
        maxDistance,
        max: 500,
        onChanged: (value) => ref.read(configurationProvider.notifier).update(
            (state) => state.copyWith(
                maxDistance: Offset(state.maxDistance.dx, value))),
      ),
    );
  }
}

class _DistanceDistribution extends ConsumerWidget {
  // ignore: unused_element
  const _DistanceDistribution({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final layerCount =
        ref.watch(configurationProvider.select((value) => value.layerCount));
    final distanceDistribution = ref.watch(
        configurationProvider.select((value) => value.distanceDistribution));
    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.white,
      ),
      child: SizedBox(
        height: 100,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 3),
              child: Row(
                children: [
                  for (int i = 1; i <= layerCount; i++)
                    Expanded(
                      flex: (distanceDistribution
                                  .transform(i / layerCount)
                                  .clamp(0.001, 1) *
                              1000)
                          .toInt(),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 1),
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: colors.light,
                            borderRadius: BorderRadius.circular(3.0),
                          ),
                          child: const SizedBox.expand(),
                        ),
                      ),
                    )
                ],
              ),
            ),
            CurveEditor(
                curve: distanceDistribution,
                onChanged: (value) => ref
                    .read(configurationProvider.notifier)
                    .update(
                        (state) => state.copyWith(distanceDistribution: value)))
          ],
        ),
      ),
    );
  }
}
