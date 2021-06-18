import 'package:flutter/material.dart';
import 'package:personal_website/widgets/fitted_child_builder.dart';

class ClipBDRS extends StatefulWidget {
  final Widget? child;
  final double topLeftX;
  final double topRightX;
  final double bottomRightX;
  final double bottomLeftX;
  final double topLeftY;
  final double topRightY;
  final double bottomRightY;
  final double bottomLeftY;

  ClipBDRS(
      {Key? key,
      required this.topLeftX,
      required this.topRightX,
      required this.bottomRightX,
      required this.bottomLeftX,
      double? topLeftY,
      double? topRightY,
      double? bottomRightY,
      double? bottomLeftY,
      this.child})
      : topLeftY = topLeftY ?? topLeftX,
        topRightY = topRightY ?? topRightX,
        bottomRightY = bottomRightY ?? bottomRightX,
        bottomLeftY = bottomLeftY ?? bottomLeftX,
        super(key: key);

  factory ClipBDRS.only(
      {double topLeftX = 0,
      double topRightX = 0,
      double bottomRightX = 0,
      double bottomLeftX = 0,
      double topLeftY = 0,
      double topRightY = 0,
      double bottomRightY = 0,
      double bottomLeftY = 0}) {
    return ClipBDRS(
        topLeftX: topLeftX,
        topRightX: topRightX,
        bottomRightX: bottomRightX,
        bottomLeftX: bottomLeftX,
        topLeftY: topLeftY,
        topRightY: topRightY,
        bottomRightY: bottomRightY,
        bottomLeftY: bottomLeftY);
  }

  factory ClipBDRS.symmetric({double vertical = 0, double horizontal = 0}) {
    return ClipBDRS(
        topLeftX: horizontal,
        topRightX: horizontal,
        bottomRightX: horizontal,
        bottomLeftX: horizontal,
        topLeftY: vertical,
        topRightY: vertical,
        bottomRightY: vertical,
        bottomLeftY: vertical);
  }

  @override
  _ClipBDRSState createState() => _ClipBDRSState();
}

class _ClipBDRSState extends State<ClipBDRS> {
  @override
  Widget build(BuildContext context) {
    if (widget.topLeftX < 1 ||
        widget.topLeftY < 1 ||
        widget.topRightX < 1 ||
        widget.topRightY < 1 ||
        widget.bottomRightX < 1 ||
        widget.bottomRightY < 1 ||
        widget.bottomLeftX < 1 ||
        widget.bottomLeftY < 1) {
      return FittedChildBuilder(builder: _child);
    } else {
      return _child(1, 1);
    }
  }

  Widget _child(double width, double height) => ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.elliptical(
                widget.topLeftX * (widget.topLeftX < 1 ? width : 1),
                widget.topLeftY * (widget.topLeftY < 1 ? height : 1)),
            topRight: Radius.elliptical(
                widget.topRightX * (widget.topRightX < 1 ? width : 1),
                widget.topRightY * (widget.topRightY < 1 ? height : 1)),
            bottomRight: Radius.elliptical(
                widget.bottomRightX * (widget.bottomRightX < 1 ? width : 1),
                widget.bottomRightY * (widget.bottomRightY < 1 ? height : 1)),
            bottomLeft: Radius.elliptical(
                widget.bottomLeftX * (widget.bottomLeftX < 1 ? width : 1),
                widget.bottomLeftY * (widget.bottomLeftY < 1 ? height : 1))),
        child: widget.child ?? Container(),
      );
}
