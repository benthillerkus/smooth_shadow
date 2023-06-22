import 'package:flutter/material.dart' as material;
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_shadow/codebox.dart';
import 'package:smooth_shadow/control_list.dart';
import 'package:smooth_shadow/extensions.dart';
import 'package:smooth_shadow/link.dart';

void main() {
  runApp(const ProviderScope(
    child: WirsingApp(
      child: MainApp(),
    ),
  ));
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

class WirsingApp extends ConsumerWidget {
  const WirsingApp({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
        ),
      ),
    );
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
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
            child: const Codebox(),
          );
        }),
        const Align(
          alignment: Alignment.topRight,
          child: SizedBox(
            width: 460,
            child: ConfiguratorList(),
          ),
        ),
      ],
    );
  }
}
