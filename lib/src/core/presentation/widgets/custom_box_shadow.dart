import 'package:flutter/material.dart';
import 'package:nft_deaa/src/core/core.dart';

class CustomBoxShadow extends BoxShadow {
  final BlurStyle blurStyle;

   const CustomBoxShadow({
    Color color = AppColors.primaryColor,
    Offset? offset ,
    double blurRadius =  5.0,
    this.blurStyle = BlurStyle.outer,
  }) : super(color: color, offset: offset ?? const Offset(0, 1.0), blurRadius: blurRadius);

  @override
  Paint toPaint() {
    final Paint result = Paint()
      ..color = color
      ..maskFilter = MaskFilter.blur(blurStyle, blurSigma);
    assert(() {
      if (debugDisableShadows)
        result.maskFilter = null;
      return true;
    }());
    return result;
  }
}

