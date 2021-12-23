import 'package:dsixv02app/shared/app_Images.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class LootSpriteImage extends StatelessWidget {
  bool? isClosed;

  LootSpriteImage({
    @required this.isClosed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 8,
      height: 8,
      child: Stack(
          alignment: Alignment.topLeft,
          children: (isClosed!) ? AppImages.closedLoot : AppImages.openLoot),
    );
  }
}
