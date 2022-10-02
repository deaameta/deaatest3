import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nft_deaa/src/core/core.dart';

class BackgroundImageWidget extends StatelessWidget {
  final Widget child;

  const BackgroundImageWidget({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          alignment: Alignment.center,
          color: AppColors.black,
          width: SizeConfig.screenWidth,
          height: SizeConfig.screenHeight,
        ),
        BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 0.4, sigmaY: 0.4),
            child: Container(height: SizeConfig.screenHeight, width: SizeConfig.screenWidth, color: AppColors.white.withOpacity(0.1))),
        child
      ],
    );
  }
}
