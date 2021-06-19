import 'package:flutter/material.dart';
import 'package:personal_website/constant/breakpoints.dart';

class Sizes extends InheritedWidget {
  Sizes({Key? key, required Widget child}) : super(key: key, child: child);

  static Sizes of(BuildContext context) {
    final result = context.dependOnInheritedWidgetOfExactType<Sizes>();
    assert(result != null, 'No Sizes found in context');
    return result!;
  }

  final SizeSwatch spacing = const SizeSwatch(swatch: <BreakPoints, double>{
    BreakPoints.xsm: 4.0,
    BreakPoints.sm: 8.0,
    BreakPoints.md: 16.0,
    BreakPoints.lg: 32.0,
    BreakPoints.xlg: 64.0,
  });

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;
}
