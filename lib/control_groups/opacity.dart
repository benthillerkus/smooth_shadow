import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smooth_shadow/configuration.dart';
import 'package:smooth_shadow/controls/checkbox.dart';
import 'package:smooth_shadow/controls/controls.dart';
import 'package:smooth_shadow/controls/curve.dart';
import 'package:smooth_shadow/controls/slider.dart';
import 'package:smooth_shadow/main.dart';

class OpacityControlGroup extends StatelessWidget {
  const OpacityControlGroup({super.key});

  @override
  Widget build(BuildContext context) {
    return const ControlBox(children: [
      _MaxOpacity(),
      _TransparencyDistribution(),
      _ReverseOpacity()
    ]);
  }
}

class _MaxOpacity extends ConsumerWidget {
  // ignore: unused_element
  const _MaxOpacity({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final maxOpacity =
        ref.watch(configurationProvider.select((value) => (value.maxOpacity)));

    return LabeledSlider(
      label: "Final transparency",
      unit: "%",
      state: Continuous(
        maxOpacity,
        onChanged: (value) => ref.read(configurationProvider.notifier).update(
              (state) => state.copyWith(maxOpacity: value),
            ),
      ),
    );
  }
}

class _TransparencyDistribution extends ConsumerWidget {
  // ignore: unused_element
  const _TransparencyDistribution({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final layerCount =
        ref.watch(configurationProvider.select((value) => (value.layerCount)));
    final transparencyDistribution = ref.watch(configurationProvider
        .select((value) => (value.transparencyDistribution)));
    final reverseOpacity = ref
        .watch(configurationProvider.select((value) => (value.reverseOpacity)));
    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.white,
      ),
      child: SizedBox(
        height: 100,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(5),
              child: Row(
                children: [
                  for (int i = 1; i <= layerCount; i++)
                    Expanded(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(
                            0,
                            0,
                            0,
                            (transparencyDistribution.transform(reverseOpacity
                                    ? (1 - ((i - 1) / layerCount))
                                    : (i / layerCount)))
                                .clamp(0, 1),
                          ),
                        ),
                        child: const SizedBox.expand(),
                      ),
                    )
                ],
              ),
            ),
            CurveEditor(
              curve: transparencyDistribution,
              onChanged: (value) => ref
                  .read(configurationProvider.notifier)
                  .update((state) =>
                      state.copyWith(transparencyDistribution: value)),
            )
          ],
        ),
      ),
    );
  }
}

class _ReverseOpacity extends ConsumerWidget {
  // ignore: unused_element
  const _ReverseOpacity({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reverseOpacity = ref
        .watch(configurationProvider.select((value) => (value.reverseOpacity)));

    return GestureDetector(
      onTap: () => ref
          .read(configurationProvider.notifier)
          .update((state) => state.copyWith(reverseOpacity: !reverseOpacity)),
      child: Wrap(
        spacing: 5,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Checkbox(ticked: reverseOpacity),
          const Text("Reverse alpha")
        ],
      ),
    );
  }
}
