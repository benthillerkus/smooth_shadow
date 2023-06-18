import 'package:flutter/widgets.dart';
import 'package:smooth_shadow/main.dart';
import 'package:url_launcher/link.dart';

class Anchor extends StatefulWidget {
  const Anchor({super.key, required this.href, this.text});

  final Uri href;
  final String? text;

  @override
  State<Anchor> createState() => _AnchorState();
}

class _AnchorState extends State<Anchor> {
  bool _hovered = false;
  bool _focused = false;

  @override
  Widget build(BuildContext context) {
    return Link(
      uri: widget.href,
      builder: (context, followLink) {
        return GestureDetector(
          onTap: followLink,
          child: FocusableActionDetector(
            onShowHoverHighlight: (value) => setState(() => _hovered = value),
            onShowFocusHighlight: (value) => setState(() => _focused = value),
            mouseCursor: SystemMouseCursors.click,
            child: Text(
              widget.text ?? widget.href.toString(),
              style: TextStyle(
                color: colors.link,
                backgroundColor: _focused ? colors.link.withOpacity(0.2) : null,
                decoration: _hovered ? TextDecoration.underline : null,
              ),
            ),
          ),
        );
      },
    );
  }
}
