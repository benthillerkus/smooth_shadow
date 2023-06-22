import 'package:flutter/widgets.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:smooth_shadow/main.dart';

enum _GrabState {
  none,
  handle1,
  handle2,
}

class CurveEditor extends HookWidget {
  const CurveEditor({
    super.key,
    required this.curve,
    required this.onChanged,
  });

  final Cubic curve;
  final ValueChanged<Cubic> onChanged;

  @override
  Widget build(BuildContext context) {
    final grabState = useRef(_GrabState.none);

    return CustomPaint(
      painter: _CurvePainter(curve, resolution: 128),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final handle1 = Offset(curve.a, 1 - curve.b).scale(
            constraints.maxWidth,
            constraints.maxHeight,
          );
          final handle2 = Offset(curve.c, 1 - curve.d).scale(
            constraints.maxWidth,
            constraints.maxHeight,
          );
          return Listener(
            onPointerDown: (details) {
              if ((details.localPosition - handle1).distance < 8) {
                grabState.value = _GrabState.handle1;
              } else if ((details.localPosition - handle2).distance < 8) {
                grabState.value = _GrabState.handle2;
              } else {
                grabState.value = _GrabState.none;
              }
            },
            onPointerMove: (details) {
              final point = (details.localPosition).scale(
                1 / constraints.maxWidth,
                1 / constraints.maxHeight,
              );
              switch (grabState.value) {
                case _GrabState.handle1:
                  onChanged(
                    Cubic(
                      point.dx.clamp(0, 1),
                      1 - point.dy.clamp(0, 1),
                      curve.c,
                      curve.d,
                    ),
                  );
                case _GrabState.handle2:
                  onChanged(
                    Cubic(
                      curve.a,
                      curve.b,
                      point.dx.clamp(0, 1),
                      1 - point.dy.clamp(0, 1),
                    ),
                  );
                case _GrabState.none:
              }
            },
            onPointerUp: (details) => grabState.value = _GrabState.none,
            onPointerCancel: (details) => grabState.value = _GrabState.none,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  left: handle1.dx - 8,
                  top: handle1.dy - 8,
                  child: FocusableActionDetector(
                    mouseCursor: SystemMouseCursors.click,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: colors.accent,
                        shape: BoxShape.circle,
                      ),
                      child: const SizedBox.square(
                        dimension: 16,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: handle2.dx - 8,
                  top: handle2.dy - 8,
                  child: FocusableActionDetector(
                    mouseCursor: SystemMouseCursors.click,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: colors.accent,
                        shape: BoxShape.circle,
                      ),
                      child: const SizedBox.square(
                        dimension: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _CurvePainter extends CustomPainter {
  final Cubic curve;
  final int resolution;

  _CurvePainter(this.curve, {this.resolution = 64});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = colors.accent
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final handle1 = Offset(curve.a, 1 - curve.b).scale(size.width, size.height);
    final handle2 = Offset(curve.c, 1 - curve.d).scale(size.width, size.height);
    canvas.drawLine(size.bottomLeft(Offset.zero), handle1, paint);
    canvas.drawLine(handle2, size.topRight(Offset.zero), paint);

    paint.color = colors.link;
    paint.strokeWidth = 4;
    final path = Path()..moveTo(0, size.height);

    for (var x = 0; x <= resolution; x++) {
      final y = curve.transform(x / resolution);
      path.lineTo(x / resolution * size.width, size.height - y * size.height);
    }

    canvas.drawPath(path, paint);
    paint.style = PaintingStyle.fill;
    canvas.drawCircle(size.bottomLeft(Offset.zero), 4, paint);
    canvas.drawCircle(size.topRight(Offset.zero), 4, paint);
  }

  @override
  bool shouldRepaint(_CurvePainter oldDelegate) =>
      oldDelegate.curve != curve || oldDelegate.resolution != resolution;
}
