import 'package:flutter/material.dart';

class Heading extends StatelessWidget {

  final String text;
  const Heading({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: Text(text, style: Theme.of(context).textTheme.titleLarge,),
    );
  }
}
