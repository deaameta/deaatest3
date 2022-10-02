import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
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
import 'package:nft_deaa/src/core/util/validators/min_length_validator.dart';
import 'package:nft_deaa/src/core/util/validators/name_validator.dart';
import 'package:nft_deaa/src/core/util/validators/password_validator.dart';
import 'package:nft_deaa/src/core/util/validators/phone_number_validator.dart';
import 'package:nft_deaa/src/core/util/validators/required_validator.dart';
import 'package:nft_deaa/src/core/util/validators/username_validator.dart';
import 'package:nft_deaa/src/features/auth/data/data_sources/auth_shared_prefs.dart';
import 'package:nft_deaa/src/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:nft_deaa/src/features/auth/presentation/widgets/auth_text_field_widget.dart';

import '../widgets/auth_text_field_widget.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  late AuthBloc _bloc;
  bool isObscureConfirmPassword = true;

  @override
  void initState() {
    _bloc = BlocProvider.of(context);
    _bloc.clearSignupTextField();
    _bloc.stream.listen((state) {
      if (state is RegisterError) {
        Helper.showSnackBar(context, state.error, type: ToastType.error);
      } else if (state is RegisterSuccess) {
        User user = sl<AuthSharedPrefs>().getUser();
        if ((user.token ?? "") == "") {
          navigatorKey.currentState?.pushReplacementNamed("/verify_email_page");
        } else {
          navigatorKey.currentState?.pushNamedAndRemoveUntil("/home", (route) => false);
        }
        // navigatorKey.currentState?.pushNamedAndRemoveUntil(
        //   "/home",
        //   (route) => false,
        // );
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
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
                  // Logo
                  SvgPicture.asset(
                    Helper.getSvgImage("logo.svg"),
                    alignment: Alignment.center,
                    fit: BoxFit.cover,
                    color: AppColors.primaryColor,
                    width: SizeConfig.w(200),
                    height: SizeConfig.w(200),
                  ),

                  // Signup welcome msg
                  SizedBox(
                    width: SizeConfig.w(200),
                    child: Center(
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(children: [
                          TextSpan(
                            text: "${S.of(context).signup_welcome_msg1} ",
                            style: AppStyle.bold(size: 14).copyWith(
                              color: AppColors.white,
                            ),
                          ),
                          TextSpan(
                            text: S.of(context).signup_welcome_msg2,
                            style: AppStyle.bold(size: 14).copyWith(
                              color: AppColors.white,
                            ),
                          ),
                          TextSpan(
                            text: S.of(context).signup_welcome_msg3,
                            style: AppStyle.bold(size: 14).copyWith(
                              color: AppColors.white,
                            ),
                          ),
                        ]),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.h(30),
                  ),

                  SizedBox(
                    height: SizeConfig.h(30),
                  ),

                  // Signup form
                  Form(
                    key: _bloc.signUpFormKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        // First name
                        AuthTextFieldWidget(
                          validator: (value) {
                            return BaseValidator.validateValue(
                              context,
                              value!,
                              [RequiredValidator(), UserNameValidator()],
                              _bloc.signupUserNameValidator,
                            );
                          },
                          controller: _bloc.signupUserNameController,
                          hintText: S.of(context).user_name,
                          filled: AppColors.black,
                          keyboardType: TextInputType.text,
                          style: AppStyle.regular(size: 14).copyWith(
                            color: AppColors.white,
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.h(20),
                        ),
                        AuthTextFieldWidget(
                          validator: (value) {
                            return BaseValidator.validateValue(
                              context,
                              value!,
                              [RequiredValidator(), NameValidator()],
                              _bloc.signupFirstNameValidator,
                            );
                          },
                          controller: _bloc.signupFirstNameController,
                          hintText: S.of(context).first_name,
                          filled: AppColors.black,
                          keyboardType: TextInputType.emailAddress,
                          style: AppStyle.regular(size: 14).copyWith(
                            color: AppColors.white,
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.h(20),
                        ),

                        // Last name
                        AuthTextFieldWidget(
                          validator: (value) {
                            return BaseValidator.validateValue(
                              context,
                              value!,
                              [RequiredValidator(), NameValidator()],
                              _bloc.signupLastNameValidator,
                            );
                          },
                          controller: _bloc.signupLastNameController,
                          hintText: S.of(context).last_name,
                          filled: AppColors.black,
                          keyboardType: TextInputType.emailAddress,
                          style: AppStyle.regular(size: 14).copyWith(
                            color: AppColors.white,
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.h(20),
                        ),

                        // Phone number
                        InternationalPhoneNumberInput(
                          onInputChanged: (PhoneNumber number) {
                            _bloc.number = number;
                          },
                          searchBoxDecoration: InputDecoration(
                            hintText: S.of(context).search,
                          ),
                          onInputValidated: (bool value) {
                            // _bloc.signupPhoneNumberValidator = value;
                          },
                          // validator: (_bloc.number.phoneNumber ?? "").replaceAll(_bloc.number.dialCode ?? "", "").isEmpty? (v){
                          //   return null;
                          // }:null,
                          selectorConfig: const SelectorConfig(
                              selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                              showFlags: true,
                              setSelectorButtonAsPrefixIcon: true,
                              leadingPadding: 5,
                              trailingSpace: false),
                          hintText: S.of(context).phone_number,
                          textStyle: AppStyle.regular(size: 14).copyWith(
                            color: AppColors.white,
                          ),
                          locale: Helper.getLang(),
                          autoValidateMode: AutovalidateMode.onUserInteraction,
                          errorMessage: S.of(context).incorrect_phone_number,
                          inputDecoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: AppColors.secondaryColor,
                                ),
                                borderRadius: BorderRadius.circular(7)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: AppColors.secondaryColor,
                                ),
                                borderRadius: BorderRadius.circular(7)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: AppColors.secondaryColor,
                                ),
                                borderRadius: BorderRadius.circular(7)),
                            hintText: S.of(context).phone_number,
                            hintStyle: AppStyle.bold(size: 14).copyWith(color: AppColors.primaryGrey, fontWeight: FontWeight.normal),
                            filled: true,
                            fillColor: AppColors.black,
                            contentPadding: EdgeInsets.symmetric(vertical: SizeConfig.h(10), horizontal: SizeConfig.w(20)),
                          ),
                          ignoreBlank: true,
                          selectorTextStyle: TextStyle(color: AppColors.white),
                          initialValue: _bloc.number,
                          formatInput: false,
                          keyboardType: const TextInputType.numberWithOptions(signed: true, decimal: true),
                          onSaved: (PhoneNumber number) {},
                        ),

                        // AuthTextFieldWidget(
                        //   // validator: (value) {
                        //   //   return BaseValidator.validateValue(
                        //   //     context,
                        //   //     value!,
                        //   //     [
                        //   //       RequiredValidator(),
                        //   //       // PhoneNumberValidator(phoneNumber: _bloc.countryCode +  _bloc.signupPhoneNumberController.text.trim()),
                        //   //     ],
                        //   //     _bloc.signupPhoneNumberValidator,
                        //   //   );
                        //   // },
                        //   controller: _bloc.signupPhoneNumberController,
                        //   hintText: S.of(context).phone_number,
                        //   filled: AppColors.black,
                        //   keyboardType: TextInputType.number,
                        //   style: AppStyle.regular(size: 14).copyWith(
                        //     color: AppColors.white,
                        //   ),
                        //   prefixIcon: CountryCodePicker(
                        //     onChanged: (CountryCode code) {
                        //       setState(() {
                        //         _bloc.countryCode = code.dialCode!;
                        //       });
                        //     },
                        //     // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                        //     initialSelection: _bloc.countryCode,
                        //     favorite: ['+971', 'AE'],
                        //     // optional. Shows only country name and flag
                        //     showCountryOnly: false,
                        //     // optional. Shows only country name and flag when popup is closed.
                        //     showOnlyCountryWhenClosed: false,
                        //     // optional. aligns the flag and the Text left
                        //     alignLeft: false,
                        //     textStyle: AppStyle.bold(size: 14),
                        //
                        //   ),
                        // ),
                        SizedBox(
                          height: SizeConfig.h(20),
                        ),

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
                              _bloc.signupEmailValidator,
                            );
                          },
                          controller: _bloc.signupEmailController,
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
                            validator: (value) {
                              return BaseValidator.validateValue(
                                context,
                                value!,
                                [RequiredValidator(), PasswordValidator()],
                                _bloc.signupPasswordValidator,
                              );
                            },
                            onFieldSubmitted: (v) {
                              signup();
                            },
                            controller: _bloc.signupPasswordController,
                            hintText: S.of(context).password,
                            filled: AppColors.black,
                            keyboardType: TextInputType.visiblePassword,
                            style: AppStyle.regular(size: 14).copyWith(
                              color: AppColors.white,
                            ),
                            isPassword: _bloc.signupIsPassword,
                            suffixIcon: InkWell(
                              child: Icon(
                                _bloc.signupIsPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                                color: AppColors.white,
                                // size: 17,
                              ),
                              onTap: () {
                                setState(() {
                                  _bloc.signupIsPassword = !_bloc.signupIsPassword;
                                });
                              },
                            )),
                        SizedBox(
                          height: SizeConfig.h(20),
                        ),
                        // Confirm password
                        AuthTextFieldWidget(
                          validator: (v) {
                            if ((v ?? "").isEmpty) {
                              return S.of(context).required_field;
                            }
                            if (v != null && _bloc.signupPasswordController.text == _bloc.confirmPasswordController.text) {
                              return null;
                            } else {
                              return S.of(context).password_not_match;
                            }
                          },
                          controller: _bloc.confirmPasswordController,
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
                            child: Icon(isObscureConfirmPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined, color: AppColors.white),
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.h(25),
                        ),
                      ],
                    ),
                  ),

                  // Signup button
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      if (state is LoadingRegister) {
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
                          signup();
                        },
                        label: S.of(context).signup,
                      );
                    },
                  ),

                  SizedBox(height: SizeConfig.h(22)),

                  // Already registered
                  GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacementNamed("/login");
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            S.of(context).already_registered,
                            style: AppStyle.regular(size: 14).copyWith(color: AppColors.white),
                          ),
                          Text(
                            S.of(context).login,
                            style: AppStyle.regular(size: 14).copyWith(color: AppColors.primaryColor),
                          ),
                        ],
                      )),
                  SizedBox(
                    height: SizeConfig.h(30),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void signup() {
    _bloc.signupUserNameValidator = true;
    _bloc.signupFirstNameValidator = true;
    _bloc.signupLastNameValidator = true;
    // _bloc.signupPhoneNumberValidator = true;
    _bloc.signupEmailValidator = true;
    _bloc.signupPasswordValidator = true;

    if (_bloc.signUpFormKey.currentState!.validate()) {
      _bloc.add(RegisterEvent());
    }
  }
}
