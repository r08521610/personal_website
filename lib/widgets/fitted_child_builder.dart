import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class FittedChildBuilder extends StatefulWidget {
  final Widget Function(double width, double height) builder;
  FittedChildBuilder({Key? key, required this.builder}) : super(key: key);

  @override
  _FittedChildBuilderState createState() => _FittedChildBuilderState();
}

class _FittedChildBuilderState extends State<FittedChildBuilder> {
  final _key = GlobalKey();
  double _height = 0;
  double _width = 0;

  @override
  void initState() {
    SchedulerBinding.instance?.addPostFrameCallback((timeStamp) {
      final _context = _key.currentContext;
      if (_context?.size != null) {
        setState(() {
          _height = _context!.size!.height;
          _width = _context.size!.width;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: _key,
      child: widget.builder(_width, _height),
    );
  }
}
