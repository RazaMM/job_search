import 'package:flutter/material.dart';

extension BrightnessShift on Color {
  Color lighten(double amount) {
    final hsl = HSLColor.fromColor(this);
    final lightened =
        hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));

    return lightened.toColor();
  }

  Color darken(double amount) {
    final hsl = HSLColor.fromColor(this);
    final darkened =
        hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));

    return darkened.toColor();
  }
}
