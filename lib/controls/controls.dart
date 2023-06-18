import 'package:flutter/widgets.dart';
import 'package:smooth_shadow/controls/slider.dart';
import 'package:smooth_shadow/main.dart';

class ControlBox extends StatelessWidget {
  const ControlBox({super.key, required this.children});

  ControlBox.single({super.key, required Widget child}) : children = [child];

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle.merge(
      style: TextStyle(fontSize: 16, color: colors.surfaceText),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(3.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: children.length == 1
                ? children
                : [
                    for (final child in children)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: child,
                      )
                  ],
          ),
        ),
      ),
    );
  }
}

class LabeledSlider extends StatelessWidget {
  const LabeledSlider({
    super.key,
    required this.label,
    required this.state,
    this.unit = "",
  });

  final String label;
  final String unit;
  final SliderState state;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(label),
            DecoratedBox(
              decoration: BoxDecoration(
                color: colors.white,
                borderRadius: BorderRadius.circular(3.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: Text(
                  switch ((state, unit)) {
                    (Discrete(value: final value), _) => "$value$unit",
                    (Continuous(value: final value), "%") =>
                      "${value.toStringAsFixed(2).replaceFirst(".", "").replaceAll("0", " ").trimLeft().replaceAll(" ", "0").padLeft(1, "0")
                      //lmao
                      }$unit",
                    (Continuous(value: final value), _) =>
                      "${value.toStringAsFixed(2)}$unit",
                  },
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        Slider(
          state: state,
        ),
      ],
    );
  }
}
