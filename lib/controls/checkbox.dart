import 'package:flutter/widgets.dart';
import 'package:smooth_shadow/main.dart';

class Checkbox extends StatelessWidget {
  const Checkbox({
    super.key,
    required this.ticked,
  });

  final bool ticked;

  @override
  Widget build(BuildContext context) {
    return FocusableActionDetector(
      mouseCursor: SystemMouseCursors.click,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: ticked ? colors.link : colors.white,
          borderRadius: BorderRadius.circular(3.0),
          border: Border.all(
            color: colors.surfaceText,
          ),
        ),
        child: const SizedBox.square(
          dimension: 15,
        ),
      ),
    );
  }
}
