import 'package:flutter/material.dart';
import 'package:nft_deaa/src/core/core.dart';

class TextNumberWidget extends StatelessWidget {
  const TextNumberWidget(
      {Key? key,
      required this.value,
      // this.flex = 0,
      this.sizeValue = 26,
      this.color = AppColors.white,
        this.style,
      this.isPercent = false})
      : super(key: key);
  final String value;
  final double sizeValue;
  final bool isPercent;
  final Color? color;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(

        children: [
          TextSpan(text: value.split(".")[0], style: style ?? AppStyle.smiBold(size: sizeValue).copyWith(color: color,)),
           if (value.split(".").length > 1 && !isPercent)
            TextSpan(
                text: ".${value.split(".")[1]}${value.split(".")[1].length == 1 ? "0": ""}",
                style: AppStyle.regular(size: sizeValue > 10 ? sizeValue - 8 : sizeValue - 2).copyWith(color: color,))
           else if (value.split(".").length <= 1 && !isPercent)
             TextSpan(
                 text: ".00",
                 style: AppStyle.regular(size: sizeValue > 10 ? sizeValue - 8 : sizeValue - 2).copyWith(color: color,)),
          if (isPercent) TextSpan(text: "%", style: style ?? AppStyle.smiBold(size: sizeValue).copyWith(color: color,)),
        ],
      ),
    );
  }
}
