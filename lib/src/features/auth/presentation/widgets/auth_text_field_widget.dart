/*
 * Created by Yamen Abdulrahman on 08/09/2022.
 * Connection email: yamen.abd98@gmail.com
*/

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nft_deaa/src/core/core.dart';

class AuthTextFieldWidget extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final TextStyle? hintStyle;
  final TextStyle? style;
  final OutlineInputBorder? border;
  final String? Function(String?)? validator;
  final Color? filled;
  final EdgeInsets? contentPadding;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool? isPassword;
  final FocusNode? focusNode;
  final bool? enabled;
  final Function(String vlaue)? onChanged;
  final List<TextInputFormatter>? inputFormatters;

  final Function(String vlaue)? onFieldSubmitted;

  final TextInputAction? textInputAction ;
  const AuthTextFieldWidget(
      {Key? key,
        required this.controller,
        required this.hintText,
        this.hintStyle,
        this.style,
        this.border,
        this.validator,
        this.filled,
        this.contentPadding,
        this.keyboardType,
        this.suffixIcon,
        this.prefixIcon,
        this.isPassword,
        this.focusNode,
        this.onChanged,
        this.inputFormatters,
        this.enabled = true,

        this.textInputAction = TextInputAction.next,
        this.onFieldSubmitted,})
      : super(key: key);

  @override
  State<AuthTextFieldWidget> createState() => _AuthTextFieldWidgetState();
}

class _AuthTextFieldWidgetState extends State<AuthTextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    var defaultBorder = OutlineInputBorder(
        borderRadius: BorderRadius.circular(7),
        borderSide: const BorderSide(
          color: AppColors.secondaryColor,
        ));
    return TextFormField(
      enabled: widget.enabled,
      inputFormatters: widget.inputFormatters,

      onFieldSubmitted: widget.onFieldSubmitted,
      onChanged: widget.onChanged,
      focusNode: widget.focusNode,
      controller: widget.controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: widget.validator,
      textInputAction:  widget.textInputAction,
      keyboardType: widget.keyboardType ?? TextInputType.text,
      style: widget.style ?? AppStyle.regular(size: 14),
      obscureText: widget.isPassword ?? false,

      decoration: InputDecoration(
          contentPadding: widget.contentPadding ?? EdgeInsets.symmetric(vertical: SizeConfig.h(10), horizontal: SizeConfig.w(20)),
          hintText: widget.hintText,
          hintStyle: widget.hintStyle ?? AppStyle.bold(size: 14).copyWith(color: AppColors.primaryGrey, fontWeight: FontWeight.normal),
          border: widget.border ?? defaultBorder,
          enabledBorder: widget.border ?? defaultBorder,
          focusedBorder: widget.border ?? defaultBorder,
          fillColor: widget.filled ?? AppColors.white,
          filled: widget.filled == null ? false : true,
          suffixIcon: widget.suffixIcon,
          prefixIcon: widget.prefixIcon,
          errorMaxLines: 20
      ),
    );
  }
}
