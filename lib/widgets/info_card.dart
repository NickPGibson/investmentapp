
import 'package:flutter/material.dart';
import 'package:investmentapp/widgets/rounded_card.dart';

class InfoCard extends StatelessWidget {

  const InfoCard({super.key,
    this.onTapped,
    required this.topText,
    required this.bottomText,
    required this.image,
    this.isGrey = false
  });

  final void Function()? onTapped;
  final Text topText;
  final Text bottomText;
  final ImageProvider image;
  final bool isGrey;

  @override
  Widget build(BuildContext context) => RoundedCard(
    onTapped: onTapped,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: Row(
          children: [
            CircleAvatar(backgroundImage: image, radius: 20,),
            Expanded(child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  topText,
                  bottomText
                ]
              ),
            )),
          ],
        )),
        if (onTapped != null) const Icon(Icons.arrow_forward_ios_outlined)
      ],
    )
  );
}
