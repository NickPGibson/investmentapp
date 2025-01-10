

import 'package:flutter/material.dart';

class Tappable extends StatefulWidget {

  final Widget Function(double elevation) builder;
  final void Function()? onTapped;

  const Tappable({required this.builder, required this.onTapped, super.key});

  @override
  State<Tappable> createState() => _TappableState();
}

class _TappableState extends State<Tappable> {

  bool _isTappedDown = false;

  void _onTapDown(_) {
    setState(() {
      _isTappedDown = true;
    });
  }

  void _onTapUp(_) {
    if (widget.onTapped != null) {
      widget.onTapped!();
    }
    setState(() {
      _reset();
    });
  }

  void _onTapCancel() {
    setState(() {
      _reset();
    });
  }

  void _reset() {
    _isTappedDown = false;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapUp: _onTapUp,
      onTapDown: _onTapDown,
      onTapCancel: _onTapCancel,
      child: widget.builder(widget.onTapped == null ? _defaultElevation : _isTappedDown ? 0.0 : _defaultElevation),
    );
  }

  static const double _defaultElevation = 2.0;
}
