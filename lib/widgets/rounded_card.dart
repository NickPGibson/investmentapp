
import 'package:flutter/material.dart';
import 'package:investmentapp/widgets/tappable.dart';

class RoundedCard extends StatelessWidget {

  final Widget child;
  final void Function()? onTapped;

  const RoundedCard({required this.child, this.onTapped, super.key});

  @override
  Widget build(BuildContext context) => Tappable(
    builder: (elevation) => Opacity(
      opacity: 1,
      child: Card(
        elevation: elevation,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: child,
        )
      )
    ),
    onTapped: onTapped,
  );
}
