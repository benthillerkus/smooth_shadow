import 'package:flutter/widgets.dart';
import 'package:smooth_shadow/extensions.dart';
import 'package:smooth_shadow/main.dart';

class DirectionControl extends StatelessWidget {
  const DirectionControl(
      {super.key, required this.value, required this.onChanged});

  final Offset value;
  final ValueChanged<Offset> onChanged;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.white,
        shape: BoxShape.circle,
      ),
      child: SizedBox.square(
        dimension: 200,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Align(
              alignment: Alignment(
                value.dx.map(inMin: -1, inMax: 1, outMin: -1, outMax: 1),
                value.dy.map(inMin: -1, inMax: 1, outMin: -1, outMax: 1),
              ),
              child: GestureDetector(
                onTapDown: (details) {
                  onChanged(details.localPosition);
                },
                onPanUpdate: (details) {
                  onChanged(details.localPosition);
                },
                child: FocusableActionDetector(
                  mouseCursor: SystemMouseCursors.precise,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: colors.surfaceText,
                      shape: BoxShape.circle,
                    ),
                    child: const SizedBox.square(
                      dimension: 20,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
