import 'package:flutter/material.dart';
import 'package:personal_website/widgets/clip_bdrs.dart';

class AnimatedClipBDRS extends StatefulWidget {
  // topLeftX
  final double top;
  // topRightY
  final double right;
  // bottomRightX
  final double bottom;
  // bottomLeftY
  final double left;
  final Widget? child;
  AnimatedClipBDRS(
      {Key? key,
      this.top = 0,
      this.right = 0,
      this.bottom = 0,
      this.left = 0,
      this.child})
      : super(key: key);

  @override
  _AnimatedClipBDRSState createState() => _AnimatedClipBDRSState();
}

class _AnimatedClipBDRSState extends State<AnimatedClipBDRS>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  double get topLeftX => widget.top + _controller.value > 1
      ? _rebound(widget.top)
      : widget.top + _controller.value;
  double get topRightX => 1 - topLeftX;

  double get topRightY => widget.right + _controller.value > 1
      ? _rebound(widget.right)
      : widget.right + _controller.value;
  double get bottomRightY => 1 - topRightY;

  double get bottomRightX => widget.bottom + _controller.value > 1
      ? _rebound(widget.bottom)
      : widget.bottom + _controller.value;
  double get bottomLeftX => 1 - bottomRightX;

  double get bottomLeftY => widget.left + _controller.value > 1
      ? _rebound(widget.left)
      : widget.left + _controller.value;
  double get topLeftY => 1 - bottomLeftY;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this,
        duration: Duration(seconds: 2),
        lowerBound: 0.4,
        upperBound: 0.6);

    _controller.addListener(() {
      setState(() {});
    });

    _controller.forward();
    _controller.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return ClipBDRS(
      topLeftX: topLeftX,
      topRightX: topRightX,
      bottomRightX: bottomRightX,
      bottomLeftX: bottomLeftX,
      topLeftY: topLeftY,
      topRightY: topRightY,
      bottomRightY: bottomRightY,
      bottomLeftY: bottomLeftY,
      child: widget.child ?? Container(),
    );
  }

  double _rebound(double origin) => 1 - ((origin + _controller.value) % 1);
}
