/*
 * Created by Yamen Abdulrahman on 1/26/2022.
 * Connection email: yamen.abd98@gmail.com
*/

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nft_deaa/src/core/core.dart';
import 'package:nft_deaa/src/core/util/helper.dart';


class ReloadWidget extends StatelessWidget {
  final String content;
  final VoidCallback onPressed;
  final String _image;

  ReloadWidget.empty({Key? key, required this.content, required this.onPressed})
      : _image = Helper.getSvgImage("empty.svg"),
        super(key: key);

  ReloadWidget.error({Key? key, required this.content, required this.onPressed})
      : _image = Helper.getSvgImage("error.svg"),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: size.height * 0.03,
        horizontal: size.width * 0.1,
      ),
      child: GestureDetector(
        onTap: onPressed,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            // SvgPicture.asset(
            //   _image,
            //   height: size.height * 0.15,
            // ),
            // const SizedBox(height: 10),
            Text(
              content,
              style: AppStyle.regular(size: 17).copyWith(
                    color: AppColors.white,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Icon(
              Icons.refresh,
              size: SizeConfig.h(5)*SizeConfig.w(5),
              color: AppColors.white,
            ),
          ],
        ),
      ),
    );
  }
}
