import 'package:flutter/rendering.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smooth_shadow/configuration.dart';
import 'package:smooth_shadow/extensions.dart';
import 'package:smooth_shadow/main.dart';

final flutterCodeTextSpanProvider = Provider((ref) {
  final shadows = ref.watch(shadowsProvider);
  return TextSpan(
    children: [
      const TextSpan(text: "const"),
      const TextSpan(text: " <", style: codeClutter),
      const TextSpan(text: "BoxShadow", style: codeObject),
      const TextSpan(text: ">[\n", style: codeClutter),
      for (final shadow in shadows)
        TextSpan(
          children: [
            const TextSpan(text: "  "),
            const TextSpan(text: "BoxShadow", style: codeObject),
            const TextSpan(text: "(\n", style: codeClutter),
            shadow.offset == Offset.zero
                ? const TextSpan()
                : TextSpan(
                    children: [
                      const TextSpan(text: "    "),
                      const TextSpan(text: "offset"),
                      const TextSpan(text: ": ", style: codeClutter),
                      const TextSpan(text: "Offset", style: codeObject),
                      const TextSpan(text: "(", style: codeClutter),
                      TextSpan(
                        text: shadow.offset.dx.humanReadable,
                        style: TextStyle(color: colors.link),
                      ),
                      const TextSpan(text: ", ", style: codeClutter),
                      TextSpan(
                        text: shadow.offset.dy.humanReadable,
                        style: TextStyle(color: colors.link),
                      ),
                      const TextSpan(text: "),\n", style: codeClutter),
                    ],
                  ),
            const TextSpan(text: "    "),
            const TextSpan(text: "color"),
            const TextSpan(text: ": ", style: codeClutter),
            const TextSpan(text: "Color", style: codeObject),
            const TextSpan(text: ".", style: codeClutter),
            const TextSpan(text: "fromRGBO", style: codeMethod),
            const TextSpan(text: "(", style: codeClutter),
            for (int i = 0; i < 3; i++)
              const TextSpan(children: [
                TextSpan(text: "0"),
                TextSpan(text: ", ", style: codeClutter),
              ]),
            TextSpan(
              text: shadow.color.opacity.humanReadable,
              style: TextStyle(color: colors.link),
            ),
            const TextSpan(text: "),\n", style: codeClutter),
            const TextSpan(text: "    "),
            const TextSpan(text: "blurRadius"),
            const TextSpan(text: ": ", style: codeClutter),
            TextSpan(
              text: shadow.blurRadius.humanReadable,
              style: TextStyle(color: colors.link),
            ),
            const TextSpan(text: ",\n", style: codeClutter),
            shadow.spreadRadius == 0
                ? const TextSpan()
                : TextSpan(children: [
                    const TextSpan(text: "    "),
                    const TextSpan(text: "spreadRadius"),
                    const TextSpan(text: ": ", style: codeClutter),
                    TextSpan(
                      text: shadow.spreadRadius.humanReadable,
                      style: TextStyle(color: colors.link),
                    ),
                    const TextSpan(text: ",\n", style: codeClutter),
                  ]),
            const TextSpan(text: "  ),\n", style: codeClutter),
          ],
        ),
      const TextSpan(text: "]", style: codeClutter),
    ],
  );
});
