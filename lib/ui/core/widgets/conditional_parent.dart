import 'package:flutter/material.dart';

class ConditionalParent extends StatelessWidget {
  final Widget child;
  final bool condition;
  final Widget Function(Widget child) builder;
  final Widget Function(Widget child)? fallbackBuilder;

  const ConditionalParent({
    super.key,
    required this.condition,
    required this.child,
    required this.builder,
    this.fallbackBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return condition
        ? builder(child)
        : fallbackBuilder == null
            ? child
            : fallbackBuilder!(child);
  }
}
