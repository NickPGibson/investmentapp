
/*
import 'package:flutter/material.dart';

class InvestmentScaffold extends StatefulWidget {

  final Widget body;
  final AppBar? appBar;
  final Widget? bottomNavigationBar;

  const InvestmentScaffold({required this.body, this.appBar, this.bottomNavigationBar, super.key});

  @override
  State<InvestmentScaffold> createState() => _InvestmentScaffoldState();
}

class _InvestmentScaffoldState extends State<InvestmentScaffold> with TickerProviderStateMixin {

  final DecorationTween _decorationTween = DecorationTween(
    begin: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              Colors.lightBlue.shade50,
              Colors.lightBlue.shade100,
            ]
        )
    ),
    end: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              Colors.lightBlue.shade100,
              Colors.lightBlue.shade200,

            ]
        )
    ),
  );

  late final AnimationController _controller = getAnimationController(this);

  AnimationController getAnimationController(TickerProvider tickerProvider) => AnimationController(
    vsync: tickerProvider,
    duration: const Duration(seconds: 3),
  )..repeat(reverse: true);

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
          appBar: widget.appBar,
          body: DecoratedBoxTransition(
            decoration: _decorationTween.animate(_controller),
            child: widget.body,
          ),
          bottomNavigationBar: widget.bottomNavigationBar,
        );


  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
*/