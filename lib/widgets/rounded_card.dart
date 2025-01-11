
import 'package:flutter/material.dart';
import 'package:investmentapp/widgets/invest_nest_padding.dart';
import 'package:investmentapp/widgets/tappable.dart';

class RoundedCard extends StatelessWidget {

  final Widget child;
  final void Function()? onTapped;
  final bool isGrey;

  const RoundedCard({required this.child, this.onTapped, this.isGrey = false, super.key});

  @override
  Widget build(BuildContext context) => Tappable(
    builder: (elevation) => Opacity(
      opacity: isGrey ? 0.5 : 1,
      child: Card(
        elevation: elevation,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        child: InvestNestPadding(
          child: child,
        )
      )
    ),
    onTapped: onTapped,
  );
}
