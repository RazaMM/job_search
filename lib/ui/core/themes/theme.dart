import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract final class AppTheme {
  static const _seedColor = Colors.indigo;

  static final light = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.light,
      seedColor: _seedColor,
    ),
    //textTheme: GoogleFonts.plusJakartaSansTextTheme(),
  );

  static final dark = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.dark,
      seedColor: _seedColor,
    ),
    //textTheme: GoogleFonts.plusJakartaSansTextTheme(),
  );

  static const radius = Radius.circular(15);

  static BoxDecoration getBoxDecoration({
    Color? background,
    required Color shadow,
    BorderRadius borderRadius = BorderRadius.zero,
  }) {
    return BoxDecoration(
      color: background,
      borderRadius: borderRadius,
      boxShadow: [
        BoxShadow(
          color: shadow,
          offset: const Offset(0, 4),
        )
      ],
    );
  }
}
