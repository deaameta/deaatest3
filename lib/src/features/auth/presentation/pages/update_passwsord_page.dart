import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:nft_deaa/main.dart';
import 'package:nft_deaa/src/core/core.dart';
import 'package:nft_deaa/src/core/data/entities/user.dart';
import 'package:nft_deaa/src/core/presentation/widgets/app_loader.dart';
import 'package:nft_deaa/src/core/presentation/widgets/main_button.dart';
import 'package:nft_deaa/src/core/translations/l10n.dart';
import 'package:nft_deaa/src/core/util/AppSnackBar.dart';
import 'package:nft_deaa/src/core/util/helper.dart';
import 'package:nft_deaa/src/core/util/validators/base_validator.dart';
import 'package:nft_deaa/src/core/util/validators/email_validator.dart';
import 'package:nft_deaa/src/core/util/validators/password_validator.dart';
import 'package:nft_deaa/src/core/util/validators/required_validator.dart';
import 'package:nft_deaa/src/features/auth/data/data_sources/auth_shared_prefs.dart';
import 'package:nft_deaa/src/features/auth/domain/usecases/code_check.dart';
import 'package:nft_deaa/src/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:nft_deaa/src/features/auth/presentation/widgets/auth_text_field_widget.dart';

import '../../domain/usecases/password_change.dart';
import '../widgets/auth_text_field_widget.dart';

class UpdatePasswordPage extends StatefulWidget {
  final String email;
  final String code;
  const UpdatePasswordPage({Key? key, required this.email, required this.code}) : super(key: key);

  @override
  _UpdatePasswordState createState() => _UpdatePasswordState();
}

class _UpdatePasswordState extends State<UpdatePasswordPage> {
  late AuthBloc _bloc;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController passwordController = TextEditingController();
  bool passwordValidation = true;
  bool isObscurePassword = true;

  TextEditingController confirmPasswordController = TextEditingController();
  bool confirmPasswordValidation = true;
  bool isObscureConfirmPassword = true;
  @override
  void initState() {
    _bloc = BlocProvider.of(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Center(
          child: BlocConsumer<AuthBloc, AuthState>(
            bloc: _bloc,
            listener: (context, state) {
              if (state is UpdatePasswordError) {
                AppSnackBar.show(context, state.error, ToastType.error);
              } else if (state is UpdatePasswordSuccess) {
                if (navigatorKey.currentContext != null) {
                  WidgetsBinding.instance.addPostFrameCallback((_) => Helper.showSnackBar(
                      navigatorKey.currentContext!, S.of(navigatorKey.currentContext!).password_changed_successfully,
                      type: ToastType.success));
                }

                navigatorKey.currentState?.popUntil((route) => route.isFirst);
                navigatorKey.currentState?.pushReplacementNamed("/home");
                navigatorKey.currentState?.pushNamed("/login");
              }
            },
            builder: (context, state) {
              return SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: SizeConfig.w(20)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Logo
                      SvgPicture.asset(
                        Helper.getSvgImage("logo.svg"),
                        alignment: Alignment.center,
                        fit: BoxFit.cover,
                        color: AppColors.primaryColor,
                        width: SizeConfig.w(200),
                        height: SizeConfig.w(200),
                      ),

                      // Update password welcome
                      SizedBox(
                        width: SizeConfig.w(200),
                        child: Center(
                          child: Text(
                            S.of(context).please_update_password,
                            style: AppStyle.bold(size: 14).copyWith(
                              color: AppColors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.h(30),
                      ),

                      SizedBox(
                        height: SizeConfig.h(30),
                      ),

                      // Form
                      Form(
                        key: formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            // Password
                            AuthTextFieldWidget(
                              validator: (value) {
                                return BaseValidator.validateValue(
                                  context,
                                  value!,
                                  [RequiredValidator(), PasswordValidator()],
                                  _bloc.signupPasswordValidator,
                                );
                              },
                              controller: passwordController,
                              hintText: S.of(context).new_password,
                              filled: AppColors.black,
                              keyboardType: TextInputType.visiblePassword,
                              style: AppStyle.regular(size: 14).copyWith(
                                color: AppColors.white,
                              ),
                              isPassword: isObscurePassword,
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  isObscurePassword = !isObscurePassword;
                                  setState(() {});
                                },
                                child: Icon(isObscurePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined, color: AppColors.white),
                              ),
                            ),

                            const Divider(),

                            // Confirm password
                            AuthTextFieldWidget(
                              validator: (v) {
                                if (v != null && v.length > 6 && passwordController.text.trim() == confirmPasswordController.text.trim()) {
                                  return null;
                                }
                                if (v!.isEmpty) {
                                  return S.of(context).required_field;
                                }
                                if (passwordController.text.trim() != confirmPasswordController.text.trim()) {
                                  return S.of(context).password_not_match;
                                }
                                return S.of(context).password_not_valid;
                              },
                              controller: confirmPasswordController,
                              hintText: S.of(context).confirm_password,
                              filled: AppColors.black,
                              keyboardType: TextInputType.visiblePassword,
                              style: AppStyle.regular(size: 14).copyWith(
                                color: AppColors.white,
                              ),
                              isPassword: isObscureConfirmPassword,
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  isObscureConfirmPassword = !isObscureConfirmPassword;
                                  setState(() {});
                                },
                                child: Icon(isObscureConfirmPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                                    color: AppColors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: SizeConfig.h(33)),

                      // Verify button
                      BlocBuilder<AuthBloc, AuthState>(
                        builder: (context, state) {
                          if (state is UpdatePasswordLoading) {
                            return const AppLoader();
                          }
                          return MainButton(
                            icon: Icon(
                              Icons.arrow_forward_outlined,
                              color: AppColors.white,
                              size: SizeConfig.h(4) * SizeConfig.w(4),
                            ),
                            backgroundColor: AppColors.white.withOpacity(0.1),
                            hasBorder: true,
                            // borderRadius: BorderRadius.circular(7),
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                _bloc.add(UpdatePasswordEvent(PasswordChangeParams(
                                  code: widget.code,
                                  email: widget.email,
                                  password: passwordController.text.trim(),
                                )));
                              }
                            },
                            label: S.of(context).confirm,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
