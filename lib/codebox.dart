import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smooth_shadow/codegen.dart';
import 'package:smooth_shadow/configuration.dart';
import 'package:smooth_shadow/main.dart';

class Codebox extends ConsumerWidget {
  const Codebox({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final code = ref.watch(flutterCodeTextSpanProvider);
    final shadows = ref.watch(shadowsProvider);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.white,
        borderRadius: BorderRadius.circular(6.0),
        boxShadow: shadows,
      ),
      child: SizedBox(
        width: 500,
        height: 600,
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: SelectableText.rich(
            showCursor: true,
            style: GoogleFonts.sourceCodePro(
              fontWeight: FontWeight.w500,
              fontSize: 14.0,
              color: colors.text.withOpacity(
                0.5,
              ),
            ),
            code,
          ),
        ),
      ),
    );
  }
}
