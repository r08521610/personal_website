import 'package:flutter/material.dart';

/// [reference: breakpoints](https://material.io/design/layout/responsive-layout-grid.html#breakpoints)
enum BreakPoints { xsm, sm, md, lg, xlg }

@immutable
abstract class Swatch<T, U> {
  final T _main;
  const Swatch(this._main, this._swatch);

  U get main => _swatch[_main]!;

  @protected
  final Map<T, U> _swatch;

  U? operator [](T index) => _swatch[index];
}

class SizeSwatch extends Swatch<BreakPoints, double> {
  const SizeSwatch(
      {BreakPoints main = BreakPoints.md,
      required Map<BreakPoints, double> swatch})
      : super(main, swatch);

  double get xsm => this[BreakPoints.xsm]!;
  double get sm => this[BreakPoints.sm]!;
  double get md => this[BreakPoints.md]!;
  double get lg => this[BreakPoints.lg]!;
  double get xlg => this[BreakPoints.xlg]!;
}
