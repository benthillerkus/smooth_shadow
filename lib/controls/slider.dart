import 'dart:ui' as ui;

import 'package:flutter/widgets.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:smooth_shadow/extensions.dart';
import 'package:smooth_shadow/main.dart';

sealed class SliderState {}

class Discrete extends SliderState {
  final int value;
  final int min;
  final int max;
  final ValueChanged<int> onChanged;

  Discrete(this.value,
      {this.min = 0, required this.max, required this.onChanged});
}

class Continuous extends SliderState {
  final double value;
  final double min;
  final double max;
  final ValueChanged<double> onChanged;

  Continuous(this.value,
      {this.min = 0.0, this.max = 1.0, required this.onChanged});
}

class Slider extends StatelessWidget {
  const Slider({
    super.key,
    required this.state,
  });

  final SliderState state;

  void onChanged(double progress) {
    switch (state) {
      case Continuous(
          min: final min,
          max: final max,
          onChanged: final onChanged
        ):
        onChanged(progress.map(outMin: min, outMax: max));
      case Discrete(min: final min, max: final max, onChanged: final onChanged):
        onChanged(progress.map(outMin: min, outMax: max).toInt());
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _SliderPainter(
          progress: switch (state) {
        Continuous(value: final value, min: final min, max: final max) =>
          value.ratio(min, max),
        Discrete(value: final value, min: final min, max: final max) =>
          value.ratio(min, max),
      }),
      child: LayoutBuilder(builder: (context, constraints) {
        return HookBuilder(builder: (context) {
          final isDragging = useState(false);
          return GestureDetector(
            onTapDown: (details) {
              onChanged(details.localPosition.dx / constraints.maxWidth);
            },
            onPanUpdate: (details) {
              onChanged(details.localPosition.dx / constraints.maxWidth);
            },
            onPanStart: (details) {
              isDragging.value = true;
            },
            onPanEnd: (details) {
              isDragging.value = false;
            },
            child: FocusableActionDetector(
              mouseCursor: SystemMouseCursors.click,
              child: AnimatedAlign(
                duration: isDragging.value
                    ? const Duration()
                    : const Duration(milliseconds: 200),
                curve: Curves.ease,
                alignment: Alignment(
                    switch (state) {
                      Continuous(
                        value: final value,
                        min: final min,
                        max: final max
                      ) =>
                        value.map(
                          inMin: min,
                          inMax: max,
                          outMin: -1,
                          outMax: 1,
                        ),
                      Discrete(
                        value: final value,
                        min: final min,
                        max: final max
                      ) =>
                        value.map(
                          inMin: min,
                          inMax: max,
                          outMin: -1,
                          outMax: 1,
                        ),
                    },
                    0),
                child: MouseRegion(
                  cursor: SystemMouseCursors.grab,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                        color: colors.white,
                        shape: BoxShape.circle,
                        boxShadow: const [
                          BoxShadow(
                              offset: Offset(0, 2),
                              blurRadius: 6,
                              color: Color.fromRGBO(0, 0, 0, 0.3)),
                        ]),
                    child: const SizedBox.square(
                      dimension: 20,
                    ),
                  ),
                ),
              ),
            ),
          );
        });
      }),
    );
  }
}

class _SliderPainter extends CustomPainter {
  final double progress;

  _SliderPainter({this.progress = 0.5});

  @override
  void paint(Canvas canvas, Size size) {
    final start = size.centerLeft(Offset.zero).translate(10, 0);
    final end = size.centerRight(Offset.zero).translate(-10, 0);
    canvas.drawLine(
      start,
      end,
      Paint()
        ..shader = ui.Gradient.linear(
            start,
            end,
            [colors.link, colors.link, colors.light, colors.light],
            [0.0, progress, progress + 0.001, 1.0])
        ..strokeWidth = 5
        ..strokeCap = StrokeCap.round,
    );
  }

  @override
  bool shouldRepaint(_SliderPainter oldDelegate) =>
      progress != oldDelegate.progress;
}
