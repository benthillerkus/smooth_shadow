import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:smooth_shadow/main.dart';

class CurveEditor extends StatelessWidget {
  const CurveEditor({
    super.key,
    required this.curve,
    required this.onChanged,
  });

  final Cubic curve;
  final ValueChanged<Cubic> onChanged;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _CurvePainter(curve),
      child: LayoutBuilder(builder: (context, constraints) {
        final handle1 = Offset(curve.a, 1 - curve.b).scale(
          constraints.maxWidth,
          constraints.maxHeight,
        );
        final handle2 = Offset(curve.c, 1 - curve.d).scale(
          constraints.maxWidth,
          constraints.maxHeight,
        );

        return HookBuilder(builder: (context) {
          final controller = useMemoized(OverlayPortalController.new);
          WidgetsBinding.instance.addPostFrameCallback((_) {
            controller.show();
          });
          return OverlayPortal(
            controller: controller,
            overlayChildBuilder: (_) {
              final box = context.findRenderObject();
              if (box == null) return const SizedBox.shrink();
              return LayoutBuilder(builder: (context, _) {
                Offset position = (box as RenderBox).localToGlobal(Offset.zero);
                return Stack(
                  children: [
                    Positioned(
                      left: handle1.dx - 8 + position.dx,
                      top: handle1.dy - 8 + position.dy,
                      child: Listener(
                        onPointerMove: (details) {
                          final point = (details.position - position).scale(
                            1 / constraints.maxWidth,
                            1 / constraints.maxHeight,
                          );
                          onChanged(
                              Cubic(point.dx, 1 - point.dy, curve.c, curve.d));
                        },
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
                    ),
                    Positioned(
                      left: handle2.dx - 8 + position.dx,
                      top: handle2.dy - 8 + position.dy,
                      child: Listener(
                        onPointerMove: (details) {
                          final point = (details.position - position).scale(
                            1 / constraints.maxWidth,
                            1 / constraints.maxHeight,
                          );
                          onChanged(
                              Cubic(curve.a, curve.b, point.dx, 1 - point.dy));
                        },
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
                    ),
                  ],
                );
              });
            },
            child: const SizedBox.expand(),
          );
        });
      }),
    );
  }
}

class _CurvePainter extends CustomPainter {
  final Cubic curve;

  _CurvePainter(this.curve);

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

    for (var x = 0; x <= 64; x++) {
      final y = curve.transform(x / 64);
      path.lineTo(x / 64 * size.width, size.height - y * size.height);
    }

    canvas.drawPath(path, paint);
    paint.style = PaintingStyle.fill;
    canvas.drawCircle(size.bottomLeft(Offset.zero), 4, paint);
    canvas.drawCircle(size.topRight(Offset.zero), 4, paint);
  }

  @override
  bool shouldRepaint(_CurvePainter oldDelegate) => oldDelegate.curve != curve;
}
