

import 'package:flutter/material.dart';

class InvestNestPadding extends StatelessWidget {
  final Widget child;

  const InvestNestPadding({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: child,
    );
  }
}
