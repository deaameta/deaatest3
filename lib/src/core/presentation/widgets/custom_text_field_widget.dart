import 'package:flutter/material.dart';
import 'package:nft_deaa/src/core/core.dart';

class CustomTextFieldWidget extends StatefulWidget {
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
  final bool? isPassword;
  const CustomTextFieldWidget({
    Key? key,
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
    this.isPassword,
  }) : super(key: key);

  @override
  State<CustomTextFieldWidget> createState() => _CustomTextFieldWidgetState();
}

class _CustomTextFieldWidgetState extends State<CustomTextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    var defaultBorder = OutlineInputBorder(
        borderRadius: BorderRadius.circular(7),
        borderSide: const BorderSide(
          color: AppColors.secondaryColor,
        ));
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
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
      ),
    );
  }
}
