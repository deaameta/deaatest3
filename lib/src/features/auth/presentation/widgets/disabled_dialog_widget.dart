/*
 * Created by Yamen Abdulrahman on 11/09/2022.
 * Connection email: yamen.abd98@gmail.com
*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nft_deaa/src/core/core.dart';
import 'package:nft_deaa/src/features/auth/presentation/bloc/auth_bloc.dart';

import '../../../../../main.dart';
import '../../../../core/translations/l10n.dart';

class DisableDialogWidget extends StatefulWidget {
  final String title;
  final String description;
  const DisableDialogWidget({required this.title,required this.description,  Key? key}) : super(key: key);

  @override
  State<DisableDialogWidget> createState() => _DisableDialogWidgetState();
}

class _DisableDialogWidgetState extends State<DisableDialogWidget> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        widget.title,
        textAlign: TextAlign.center,
        style: AppStyle.bold(size: 20).copyWith(color: AppColors.primaryColor),
      ),
      content:     Text(
        widget.description,
        style: AppStyle.regular(size: 17).copyWith(color: AppColors.white, height: SizeConfig.h(1.5)),
      ),
      backgroundColor: AppColors.backgroundColor,
      actions: [
        TextButton(
          onPressed: () {
            // openStore(isAutoUpdate);
            Navigator.pop(context);
          },
          child: Text(
            S.of(context).ok,
            style: AppStyle.regular(size: 14).copyWith(color: AppColors.white, height: SizeConfig.h(1.5)),
          ),
        ),

      ],
    );
  }
}
