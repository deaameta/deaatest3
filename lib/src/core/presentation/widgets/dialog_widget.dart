import 'package:flutter/material.dart';
import 'package:nft_deaa/src/core/core.dart';
import '../../translations/l10n.dart';

class DialogWidget extends StatefulWidget {
  final String title;
  final String description;
  final Function()? callBack;
  const DialogWidget({required this.title, required this.description, required this.callBack, Key? key}) : super(key: key);

  @override
  State<DialogWidget> createState() => _DialogWidgetState();
}

class _DialogWidgetState extends State<DialogWidget> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        widget.title,
        textAlign: TextAlign.center,
        style: AppStyle.bold(size: 20).copyWith(color: AppColors.primaryColor2),
      ),
      content: Text(
        widget.description,
        textAlign: TextAlign.center,
        style: AppStyle.regular(size: 17).copyWith(color: AppColors.white, height: SizeConfig.h(1.5)),
      ),
      backgroundColor: AppColors.darkGray,
      actions: [
        TextButton(
          onPressed: () {
            // openStore(isAutoUpdate);
            Navigator.pop(context);
          },
          child: Text(
            S.of(context).cancel,
            style: AppStyle.regular(size: 14).copyWith(color: AppColors.white, height: SizeConfig.h(1.5)),
          ),
        ),
        TextButton(
          onPressed: widget.callBack,
          child: Text(
            S.of(context).confirm,
            style: AppStyle.regular(size: 14).copyWith(color: AppColors.white, height: SizeConfig.h(1.5)),
          ),
        )
      ],
    );
  }
}
