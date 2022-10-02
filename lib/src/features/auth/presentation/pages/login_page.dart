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
import 'package:nft_deaa/src/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:nft_deaa/src/features/auth/presentation/widgets/auth_text_field_widget.dart';

import '../widgets/auth_text_field_widget.dart';
import '../widgets/disabled_dialog_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late AuthBloc _bloc;
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    _bloc = BlocProvider.of(context);
    _bloc.clearLoginTextField();
    _bloc.stream.listen((state) {
      if (state is LoginError) {
        Helper.showSnackBar(context, state.error, type: ToastType.error);
      } else if (state is LoginSuccess) {
        // navigatorKey.currentState?.pop();
        User user = sl<AuthSharedPrefs>().getUser();
        if ((user.token ?? "") == "") {
          navigatorKey.currentState?.pushReplacementNamed("/verify_email_page");
        } else {
          navigatorKey.currentState?.pushNamedAndRemoveUntil("/home", (route) => false);
        }
      } else if (state is LoginDisabledError) {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return DisableDialogWidget(
                title: S.of(context).disable_title,
                description: S.of(context).disable_description,
              );
            });
      }
    });


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: SizeConfig.w(20)),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
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
                  height: SizeConfig.h(60),
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
                      child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(children: [
                      TextSpan(
                        text: S.of(context).login_welcome_msg1,
                        style: AppStyle.bold(size: 14).copyWith(
                          color: AppColors.white,
                        ),
                      ),
                      TextSpan(
                        text: S.of(context).login_welcome_msg2,
                        style: AppStyle.bold(size: 14).copyWith(
                          color: AppColors.white,
                        ),
                      ),
                      TextSpan(
                        text: S.of(context).login_welcome_msg3,
                        style: AppStyle.bold(size: 14).copyWith(
                          color: AppColors.white,
                        ),
                      ),
                    ]),
                  )),
                ),
                SizedBox(
                  height: SizeConfig.h(30),
                ),

                SizedBox(
                  height: SizeConfig.h(30),
                ),

                // Login form
                Form(
                  key: loginFormKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // Email
                      AuthTextFieldWidget(
                        validator: (value) {
                          return BaseValidator.validateValue(
                            context,
                            value!.trim(),
                            [
                              RequiredValidator(),
                              EmailValidator(),
                            ],
                            _bloc.loginEmailValidator,
                          );
                        },
                        controller: _bloc.loginEmailController,
                        hintText: S.of(context).your_email,
                        filled: AppColors.black,
                        keyboardType: TextInputType.emailAddress,
                        style: AppStyle.regular(size: 14).copyWith(
                          color: AppColors.white,
                        ),
                      ),

                      SizedBox(
                        height: SizeConfig.h(20),
                      ),

                      // Password
                      AuthTextFieldWidget(
                        onFieldSubmitted: (v) {
                          login();
                        },
                        validator: (value) {
                          return BaseValidator.validateValue(
                            context,
                            value!,
                            [
                              RequiredValidator(),
                              // PasswordValidator(),
                            ],
                            _bloc.loginEmailValidator,
                          );
                        },
                        controller: _bloc.loginPasswordController,
                        hintText: S.of(context).password,
                        filled: AppColors.black,
                        keyboardType: TextInputType.visiblePassword,
                        style: AppStyle.regular(size: 14).copyWith(
                          color: AppColors.white,
                        ),
                        isPassword: _bloc.loginIsPassword,
                        suffixIcon: InkWell(
                            onTap: () {
                              setState(() {
                                _bloc.loginIsPassword = !_bloc.loginIsPassword;
                              });
                            },
                            child: Icon(_bloc.loginIsPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                                color: AppColors.white, size: 17)),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: SizeConfig.h(33)),
                // Forget password
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed("/forget_password_page");
                  },
                  child: Text(
                    S.of(context).forget_password,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    style: AppStyle.regular(size: 14),
                  ),
                ),
                SizedBox(height: SizeConfig.h(28)),

                // Login button
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    if (state is LoadingLogin) {
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
                        login();
                      },
                      label: S.of(context).login,
                    );
                  },
                ),

                SizedBox(height: SizeConfig.h(22)),

                // Don't have account
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed("/signup");
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        S.of(context).dont_have_an_account,
                        style: AppStyle.regular(size: 14).copyWith(color: AppColors.white),
                      ),
                      Text(
                        S.of(context).signup,
                        style: AppStyle.regular(size: 14).copyWith(color: AppColors.primaryColor),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void login() {
    _bloc.loginEmailValidator = true;
    _bloc.loginPasswordValidator = true;
    if (loginFormKey.currentState!.validate()) {
      _bloc.add(LoginEvent());
    }
  }
}
