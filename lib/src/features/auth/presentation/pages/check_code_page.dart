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

class CheckCodePage extends StatefulWidget {
  final String email;
  const CheckCodePage({Key? key, required this.email}) : super(key: key);

  @override
  _CheckCodeState createState() => _CheckCodeState();
}

class _CheckCodeState extends State<CheckCodePage> {
  late AuthBloc _bloc;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController codeController = TextEditingController();
  StreamController<ErrorAnimationType>? errorController = StreamController<ErrorAnimationType>();

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
        child:  BlocConsumer<AuthBloc, AuthState>(
          bloc: _bloc,
          listener: (context, state) {
            if (state is CodeCheckError) {
              AppSnackBar.show(context, state.error, ToastType.error);
            } else if (state is CodeCheckSuccess) {
              navigatorKey.currentState!.pushNamed("/update-password", arguments: [widget.email, codeController.text.trim()]);
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
                      height: SizeConfig.h(20),
                    ),
                    // Logo
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
                      height: SizeConfig.h(96),
                    ),
                    // L
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
                          S.of(context).please_enter_code_to_verify,
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

                    // Login form
                    Form(
                      key: formKey,
                      child:  Directionality(
                        textDirection: TextDirection.ltr,
                        child: PinCodeTextField(
                          keyboardType: TextInputType.number,
                          appContext: context,
                          length: 6,
                          obscureText: false,
                          animationType: AnimationType.fade,
                          validator: (value) {
                            if (value!.isNotEmpty && value.length == 6) {
                              return null;
                            }
                            return S.of(context).required_field;
                          },
                          errorTextDirection: Helper.getLang() == "en" ? TextDirection.ltr : TextDirection.rtl,
                          errorTextSpace: SizeConfig.h(30),
                          pinTheme: PinTheme(
                            shape: PinCodeFieldShape.box,
                            borderRadius: BorderRadius.circular(10),
                            fieldHeight: SizeConfig.w(50),
                            fieldWidth: SizeConfig.w(50),
                            activeFillColor: Colors.white,
                            borderWidth: 0,
                            inactiveColor: AppColors.white,
                            activeColor: AppColors.white,
                            inactiveFillColor: AppColors.white,
                            selectedColor: AppColors.white,
                            selectedFillColor: AppColors.white,
                          ),
                          cursorColor: AppColors.black,
                          animationDuration: const Duration(milliseconds: 300),
                          enableActiveFill: true,
                          errorAnimationController: errorController,
                          controller: codeController,
                          onCompleted: (v) {
                            print("Completed");
                            if (formKey.currentState!.validate()) {
                              _bloc.add(CodeCheckEvent(CodeCheckParams(
                                code: codeController.text.trim(),
                                email: widget.email,
                              )));
                            }
                          },
                          onChanged: (value) {},
                          beforeTextPaste: (text) {
                            print("Allowing to paste $text");
                            //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                            //but you can show anything you want here, like your pop up saying wrong paste format or etc
                            return true;
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: SizeConfig.h(33)),

                    // Verify button
                    BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        if (state is CodeCheckLoading) {
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
                              _bloc.add(CodeCheckEvent(CodeCheckParams(
                                code: codeController.text.trim(),
                                email: widget.email,
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
    );
  }
}
