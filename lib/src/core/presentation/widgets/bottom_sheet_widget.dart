/*
 * Created by Yamen Abdulrahman on 06/07/2022.
 * Connection email: yamen.abd98@gmail.com
*/

import 'package:flutter/material.dart';
import 'package:nft_deaa/src/core/core.dart';

Future<dynamic> showModalBottomSheetWidget(BuildContext context, Widget child) {


  return showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.backgroundColor,
      elevation: 0,
      clipBehavior: Clip.hardEdge,
      isScrollControlled: true,
      useRootNavigator: true,
      isDismissible: true,
      shape: const RoundedRectangleBorder(
        // borderRadius: BorderRadius.circular(40),
        borderRadius: BorderRadius.only(topLeft: Radius.circular(32), topRight: Radius.circular(32)),
      ),
      builder: (context) {
        return  Material(
          borderRadius: BorderRadius.circular(40),
          color: AppColors.backgroundColor,

          clipBehavior: Clip.hardEdge,
          child: SingleChildScrollView(
            padding: MediaQuery
                .of(context)
                .viewInsets,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: SizeConfig.h(8),
                ),

                child
              ],
            ),
          ),
        );
      });
}
