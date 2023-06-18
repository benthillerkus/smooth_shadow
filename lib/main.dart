import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_shadow/controls/controls.dart';
import 'package:smooth_shadow/controls/direction.dart';
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
  white: Color(0xFFFFFFFF),
);

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
              DefaultMaterialLocalizations.delegate
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
    final finalOffset = useState(const Offset(100, 100));
    final finalBlur = useState(80);
    final spread = useState(0);

    final configuration = [
      for (int i = 0; i < layers.value; i++)
        () {
          final progress = i / (layers.value - 1);
          return BoxShadow(
            offset: finalOffset.value.scale(progress, progress),
            color: Color.fromRGBO(0, 0, 0, progress * finalTransparency.value),
            blurRadius: progress * finalBlur.value,
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
                  inMax: 1600,
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
                width: 520,
                height: 400,
                child: Padding(
                  padding: const EdgeInsets.all(40),
                  child: SelectableText.rich(
                    style: GoogleFonts.sourceCodePro(
                      fontWeight: FontWeight.w500,
                      fontSize: 14.0,
                      color: colors.text.withOpacity(
                        0.5,
                      ),
                    ),
                    TextSpan(
                      children: [
                        const TextSpan(text: "[\n"),
                        for (final shadow in configuration)
                          TextSpan(
                              text:
                                  """  BoxShadow(${shadow.offset == Offset.zero ? "" : """

    offset: Offset(${shadow.offset.dx.humanReadable}, ${shadow.offset.dy.humanReadable}),"""}
    color: Color.fromRGBO(0, 0, 0, ${shadow.color.opacity.humanReadable}),
    blurRadius: ${shadow.blurRadius.humanReadable},${shadow.spreadRadius == 0.0 ? "" : """

    spreadRadius: ${shadow.spreadRadius.humanReadable},"""}
  ),
"""),
                        const TextSpan(text: "]"),
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
                href: Uri.https("github.com", "benthillerkus/smooth-shadow"),
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
                  ]),
                  ControlBox(children: [
                    LabeledSlider(
                      label: "Final distance",
                      unit: "px",
                      state: Continuous(
                        finalOffset.value.distance,
                        max: 500,
                        onChanged: (value) => finalOffset.value =
                            Offset.fromDirection(
                                finalOffset.value.direction, value),
                      ),
                    ),
                    Center(
                      child: DirectionControl(
                        value: Offset.fromDirection(finalOffset.value.direction),
                        onChanged: (value) => finalOffset.value =
                            Offset.fromDirection(
                                value.direction, finalOffset.value.distance),
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
