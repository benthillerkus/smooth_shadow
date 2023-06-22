import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smooth_shadow/configuration.dart';
import 'package:smooth_shadow/controls/controls.dart';
import 'package:smooth_shadow/controls/curve.dart';
import 'package:smooth_shadow/controls/slider.dart';
import 'package:smooth_shadow/main.dart';

class BlurControlGroup extends StatelessWidget {
  const BlurControlGroup({super.key});

  @override
  Widget build(BuildContext context) {
    return const ControlBox(children: [
      _MaxBlur(),
      _BlurDistribution(),
    ]);
  }
}

class _MaxBlur extends ConsumerWidget {
  // ignore: unused_element
  const _MaxBlur({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final maxBlur =
        ref.watch(configurationProvider.select((value) => value.maxBlur));

    return LabeledSlider(
      label: "Final blur strength",
      unit: "px",
      state: Discrete(maxBlur,
          max: 500,
          onChanged: (value) => ref
              .read(configurationProvider.notifier)
              .update((state) => state.copyWith(maxBlur: value))),
    );
  }
}

class _BlurDistribution extends ConsumerWidget {
  // ignore: unused_element
  const _BlurDistribution({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final layerCount =
        ref.watch(configurationProvider.select((value) => (value.layerCount)));
    final blurDistribution = ref.watch(
        configurationProvider.select((value) => (value.blurDistribution)));

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
              child: LayoutBuilder(builder: (context, constraints) {
                return Row(
                  children: [
                    for (int i = 1; i <= layerCount; i++)
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 1),
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: colors.light,
                            ),
                            child: SizedBox(
                              height: blurDistribution
                                      .transform(i / layerCount)
                                      .clamp(0, 1) *
                                  constraints.maxHeight,
                            ),
                          ),
                        ),
                      )
                  ],
                );
              }),
            ),
            CurveEditor(
              curve: blurDistribution,
              onChanged: (value) => ref
                  .read(configurationProvider.notifier)
                  .update((state) => state.copyWith(blurDistribution: value)),
            )
          ],
        ),
      ),
    );
  }
}
