import 'dart:math';

import 'package:flutter/material.dart' as material;
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_shadow/controls/checkbox.dart';
import 'package:smooth_shadow/controls/controls.dart';
import 'package:smooth_shadow/controls/curve.dart';
import 'package:smooth_shadow/controls/slider.dart';
import 'package:smooth_shadow/extensions.dart';
import 'package:smooth_shadow/link.dart';

void main() {
  runApp(const WirsingApp(child: MainApp()));
}

const colors = (
  background: Color(0xffedf2f7),
  text: Color.fromARGB(255, 73, 100, 128),
  link: Color.fromARGB(255, 49, 140, 252),
  surface: Color.fromARGB(255, 223, 230, 238),
  surfaceText: Color.fromARGB(255, 49, 63, 78),
  light: Color.fromARGB(255, 210, 220, 233),
  accent: Color.fromARGB(255, 241, 40, 160),
  white: Color(0xFFFFFFFF),
);

const codeObject =
    TextStyle(color: material.Color.fromARGB(255, 179, 162, 132));
const codeMethod =
    TextStyle(color: material.Color.fromARGB(255, 139, 163, 146));
const codeClutter = TextStyle(color: material.Color.fromARGB(45, 0, 0, 0));

class WirsingApp extends StatelessWidget {
  const WirsingApp({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: DefaultTextStyle(
          style: GoogleFonts.inter(
            color: colors.text,
            fontSize: 12.0,
          ),
          child: Localizations(
            locale: const Locale('en', 'US'),
            delegates: const [
              DefaultWidgetsLocalizations.delegate,
              material.DefaultMaterialLocalizations.delegate
            ],
            child: Overlay(
              initialEntries: [
                OverlayEntry(
                  builder: (context) => DecoratedBox(
                    decoration: BoxDecoration(
                      color: colors.background,
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(20.0),
                      child: MainApp(),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}

class MainApp extends HookWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final layers = useState(6);
    final finalTransparency = useState(0.07);
    final transparencyCurve = useState(const Cubic(0.1, 0.5, 0.9, 0.5));
    final reverseAlpha = useState(false);
    final finalOffset = useState(const Offset(100, 100));
    final distanceCurve = useState(const Cubic(0.7, 0.1, 0.9, 0.3));
    final finalBlur = useState(80);
    final blurCurve = useState(const Cubic(0.7, 0.1, 0.9, 0.3));
    final spread = useState(0);

    final configuration = [
      for (int i = 1; i <= layers.value; i++)
        () {
          final progress = layers.value == 0 ? 1.0 : i / layers.value;
          return BoxShadow(
            offset: finalOffset.value * distanceCurve.value.transform(progress),
            color: Color.fromRGBO(
              0,
              0,
              0,
              (transparencyCurve.value.transform(reverseAlpha.value
                          ? (1 - (i - 1) / layers.value)
                          : progress) *
                      finalTransparency.value)
                  .clamp(0, 1),
            ),
            blurRadius: blurCurve.value.transform(progress) * finalBlur.value,
            spreadRadius: spread.value.toDouble(),
          );
        }()
    ];

    return Stack(
      children: [
        LayoutBuilder(builder: (context, constraints) {
          return AnimatedAlign(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            alignment: Alignment(
                constraints.biggest.width.map(
                  inMin: 800,
                  inMax: 1900,
                  outMin: -1,
                  outMax: 0,
                ),
                0),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: colors.white,
                borderRadius: BorderRadius.circular(6.0),
                boxShadow: configuration,
              ),
              child: SizedBox(
                width: 500,
                height: 600,
                child: Padding(
                  padding: const EdgeInsets.all(40),
                  child: material.SelectableText.rich(
                    showCursor: true,
                    style: GoogleFonts.sourceCodePro(
                      fontWeight: FontWeight.w500,
                      fontSize: 14.0,
                      color: colors.text.withOpacity(
                        0.5,
                      ),
                    ),
                    TextSpan(
                      children: [
                        const TextSpan(text: "const"),
                        const TextSpan(text: " <", style: codeClutter),
                        const TextSpan(text: "BoxShadow", style: codeObject),
                        const TextSpan(text: ">[\n", style: codeClutter),
                        for (final shadow in configuration)
                          TextSpan(
                            children: [
                              const TextSpan(text: "  "),
                              const TextSpan(
                                  text: "BoxShadow", style: codeObject),
                              const TextSpan(text: "(\n", style: codeClutter),
                              shadow.offset == Offset.zero
                                  ? const TextSpan()
                                  : TextSpan(
                                      children: [
                                        const TextSpan(text: "    "),
                                        const TextSpan(text: "offset"),
                                        const TextSpan(
                                            text: ": ", style: codeClutter),
                                        const TextSpan(
                                            text: "Offset", style: codeObject),
                                        const TextSpan(
                                            text: "(", style: codeClutter),
                                        TextSpan(
                                          text: shadow.offset.dx.humanReadable,
                                          style: TextStyle(color: colors.link),
                                        ),
                                        const TextSpan(
                                            text: ", ", style: codeClutter),
                                        TextSpan(
                                          text: shadow.offset.dy.humanReadable,
                                          style: TextStyle(color: colors.link),
                                        ),
                                        const TextSpan(
                                            text: "),\n", style: codeClutter),
                                      ],
                                    ),
                              const TextSpan(text: "    "),
                              const TextSpan(text: "color"),
                              const TextSpan(text: ": ", style: codeClutter),
                              const TextSpan(text: "Color", style: codeObject),
                              const TextSpan(text: ".", style: codeClutter),
                              const TextSpan(
                                  text: "fromRGBO", style: codeMethod),
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
                                      const TextSpan(
                                          text: ": ", style: codeClutter),
                                      TextSpan(
                                        text: shadow.spreadRadius.humanReadable,
                                        style: TextStyle(color: colors.link),
                                      ),
                                      const TextSpan(
                                          text: ",\n", style: codeClutter),
                                    ]),
                              const TextSpan(
                                  text: "  ),\n", style: codeClutter),
                            ],
                          ),
                        const TextSpan(text: "]", style: codeClutter),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
        Align(
          alignment: Alignment.topLeft,
          child: Wrap(
            direction: Axis.vertical,
            spacing: 4,
            children: [
              const Text(
                "Make a smooth shadow, friend.",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              Anchor(
                href: Uri.https("github.com", "benthillerkus/smooth_shadow"),
                text: "Check out the source code",
              )
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Wrap(
            children: [
              const Text("Reimplementing "),
              Anchor(
                href: Uri.https("shadows.brumm.af"),
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: SizedBox(
            width: 460,
            child: ListView(
              children: [
                for (final Widget widget in [
                  ControlBox.single(
                    child: LabeledSlider(
                      label: "Layers of shadows",
                      state: Discrete(
                        layers.value,
                        max: 10,
                        onChanged: (value) => layers.value = value,
                      ),
                    ),
                  ),
                  ControlBox(children: [
                    LabeledSlider(
                      label: "Final transparency",
                      unit: "%",
                      state: Continuous(
                        finalTransparency.value,
                        onChanged: (value) => finalTransparency.value = value,
                      ),
                    ),
                    DecoratedBox(
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
                                  for (int i = 1; i <= layers.value; i++)
                                    Expanded(
                                      child: DecoratedBox(
                                        decoration: BoxDecoration(
                                          color: Color.fromRGBO(
                                            0,
                                            0,
                                            0,
                                            (transparencyCurve.value.transform(
                                                    reverseAlpha.value
                                                        ? (1 -
                                                            ((i - 1) /
                                                                layers.value))
                                                        : (i / layers.value)))
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
                              curve: transparencyCurve.value,
                              onChanged: (value) =>
                                  transparencyCurve.value = value,
                            )
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => reverseAlpha.value = !reverseAlpha.value,
                      child: Wrap(
                        spacing: 5,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Checkbox(ticked: reverseAlpha.value),
                          const Text("Reverse alpha")
                        ],
                      ),
                    )
                  ]),
                  ControlBox(children: [
                    LabeledSlider(
                      label: "Final horizontal distance",
                      unit: "px",
                      state: Continuous(
                        finalOffset.value.dx,
                        max: 500,
                        onChanged: (value) => finalOffset.value =
                            Offset(value, finalOffset.value.dy),
                      ),
                    ),
                    LabeledSlider(
                      label: "Final vertical distance",
                      unit: "px",
                      state: Continuous(
                        finalOffset.value.dy,
                        max: 500,
                        onChanged: (value) => finalOffset.value =
                            Offset(finalOffset.value.dx, value),
                      ),
                    ),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        color: colors.white,
                      ),
                      child: SizedBox(
                        height: 100,
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 3),
                              child: Row(
                                children: [
                                  for (int i = 1; i <= layers.value; i++)
                                    Expanded(
                                      flex: (distanceCurve.value
                                                  .transform(i / layers.value) *
                                              1000)
                                          .toInt(),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 1),
                                        child: DecoratedBox(
                                          decoration: BoxDecoration(
                                            color: colors.light,
                                            borderRadius:
                                                BorderRadius.circular(3.0),
                                          ),
                                          child: const SizedBox.expand(),
                                        ),
                                      ),
                                    )
                                ],
                              ),
                            ),
                            CurveEditor(
                              curve: distanceCurve.value,
                              onChanged: (value) => distanceCurve.value = value,
                            )
                          ],
                        ),
                      ),
                    ),
                  ]),
                  ControlBox(children: [
                    LabeledSlider(
                      label: "Final blur strength",
                      unit: "px",
                      state: Discrete(
                        finalBlur.value,
                        max: 500,
                        onChanged: (value) => finalBlur.value = value,
                      ),
                    ),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        color: colors.white,
                      ),
                      child: SizedBox(
                        height: 100,
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 3),
                              child: LayoutBuilder(
                                  builder: (context, constraints) {
                                return Row(
                                  children: [
                                    for (int i = 1; i <= layers.value; i++)
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 1),
                                          child: DecoratedBox(
                                            decoration: BoxDecoration(
                                              color: colors.light,
                                            ),
                                            child: SizedBox(
                                              height: blurCurve.value.transform(
                                                      i / layers.value) *
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
                              curve: blurCurve.value,
                              onChanged: (value) => blurCurve.value = value,
                            )
                          ],
                        ),
                      ),
                    ),
                  ]),
                  ControlBox.single(
                    child: LabeledSlider(
                      label: "Reduce spread",
                      unit: "px",
                      state: Discrete(
                        spread.value,
                        max: 0,
                        min: -100,
                        onChanged: (value) => spread.value = value,
                      ),
                    ),
                  )
                ])
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: widget,
                  )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
