import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
import 'package:nft_deaa/src/features/auth/domain/usecases/forget_password.dart';
import 'package:nft_deaa/src/features/auth/presentation/bloc/auth_bloc.dart';

import '../widgets/auth_text_field_widget.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({Key? key}) : super(key: key);

  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPasswordPage> {
  late AuthBloc _bloc;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  bool emailValidation = true;

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
        child: BlocConsumer<AuthBloc, AuthState>(
          bloc: _bloc,
          listener: (context, state) {
            if (state is ForgetPasswordError) {
              AppSnackBar.show(context, state.error, ToastType.error);
            } else if (state is ForgetPasswordSuccess) {
               if (navigatorKey.currentContext != null) {
                 WidgetsBinding.instance.addPostFrameCallback((_) =>
                    Helper.showSnackBar(navigatorKey.currentContext!, S.of(navigatorKey.currentContext!).verification_sent_email, type: ToastType.success));
              }
              navigatorKey.currentState?.pop();

              // navigatorKey.currentState!.pushNamed("/check-code", arguments: emailController.text.trim());
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: SizeConfig.w(20)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: SizeConfig.h(15),
                    ),
                    Align(
                      alignment: Helper.getLang() == "en" ? Alignment.centerRight : Alignment.centerLeft,
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.arrow_forward_outlined,
                          color: AppColors.secondaryColor,
                          size: SizeConfig.w(5) * SizeConfig.h(5),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.h(100),
                    ),
                    // Logo
                    SvgPicture.asset(
                      Helper.getSvgImage("logo.svg"),
                      alignment: Alignment.center,
                      fit: BoxFit.cover,
                      color: AppColors.primaryColor,
                      width: SizeConfig.w(200),
                      height: SizeConfig.w(200),
                    ),

                    // Login welcome msg
                    SizedBox(
                      width: SizeConfig.w(200),
                      child: Center(
                        child: Text(
                          S.of(context).please_enter_email_to_send_code_it,
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

                    // Forget password form
                    Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // Email
                          AuthTextFieldWidget(
                            validator: (value) {
                              return BaseValidator.validateValue(
                                context,
                                value!,
                                [
                                  RequiredValidator(),
                                  EmailValidator(),
                                ],
                                emailValidation,
                              );
                            },
                            controller: emailController,
                            hintText: S.of(context).your_email,
                            filled: AppColors.black,
                            keyboardType: TextInputType.emailAddress,
                            style: AppStyle.regular(size: 14).copyWith(
                              color: AppColors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: SizeConfig.h(33)),

                    // Verify button

                    if (state is ForgetPasswordLoading) ...{const AppLoader()} else
                      MainButton(
                        icon: Icon(
                          Icons.arrow_forward_outlined,
                          color: AppColors.white,
                          size: SizeConfig.h(4) * SizeConfig.w(4),
                        ),
                        backgroundColor: AppColors.white.withOpacity(0.1),
                        hasBorder: true,
                        // borderRadius: BorderRadius.circular(7),
                        onPressed: () {
                          emailValidation = true;
                          if (formKey.currentState!.validate()) {
                            _bloc.add(ForgetPasswordEvent(ForgetPasswordParams(
                              email: emailController.text.trim(),
                            )));
                          }
                        },
                        label: S.of(context).the_verify,
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
