import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:nft_deaa/src/core/data/entities/user.dart';
import 'package:nft_deaa/src/core/injections.dart';
import 'package:nft_deaa/src/core/util/util.dart';
import 'package:nft_deaa/src/features/auth/data/data_sources/auth_shared_prefs.dart';
import 'package:nft_deaa/src/features/auth/domain/usecases/check_verified_user_usecase.dart';
import 'package:nft_deaa/src/features/auth/domain/usecases/code_check.dart';
import 'package:nft_deaa/src/features/auth/domain/usecases/delete_account_usecase.dart';
import 'package:nft_deaa/src/features/auth/domain/usecases/forget_password.dart';
import 'package:nft_deaa/src/features/auth/domain/usecases/login_usecase.dart';
import 'package:nft_deaa/src/features/auth/domain/usecases/logout_usecase.dart';
import 'package:nft_deaa/src/features/auth/domain/usecases/password_change.dart';
import 'package:nft_deaa/src/features/auth/domain/usecases/signup_usecase.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  late LoginUseCase loginUseCase;
  late SignupUseCase signupUseCase;
  late LogoutUseCase logoutUseCase;
  late ForgetPassword forgetPasswordUseCase;
  late CodeCheck codeCheckUseCase;
  late PasswordChange passwordChangeUseCase;
  late DeleteAccountUseCase deleteAccountUseCase;
  late CheckVerifiedUserUseCase checkVerifiedUserUseCase;

  // Email
  TextEditingController loginEmailController = TextEditingController();
  bool loginEmailValidator = true;

  // Password
  TextEditingController loginPasswordController = TextEditingController();
  bool loginPasswordValidator = true;

  // Show/Hide password
  bool loginIsPassword = true;

  /// Signup variables
  final GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();

  // First name
  TextEditingController signupFirstNameController = TextEditingController();
  bool signupFirstNameValidator = true;

  TextEditingController signupUserNameController = TextEditingController();
  bool signupUserNameValidator = true;

  // Last name
  TextEditingController signupLastNameController = TextEditingController();
  bool signupLastNameValidator = true;

  // Phone number
  // bool signupPhoneNumberValidator = true;
  PhoneNumber number = PhoneNumber(isoCode: 'AE', dialCode: "+971");
   // Email
  TextEditingController signupEmailController = TextEditingController();
  bool signupEmailValidator = true;

  // Password
  TextEditingController signupPasswordController = TextEditingController();
  bool signupPasswordValidator = true;

  TextEditingController confirmPasswordController = TextEditingController();

  // Show/Hide password
  bool signupIsPassword = true;

  AuthBloc() : super(AuthInitial()) {
    loginUseCase = sl<LoginUseCase>();
    signupUseCase = sl<SignupUseCase>();
    logoutUseCase = sl<LogoutUseCase>();
    forgetPasswordUseCase = sl<ForgetPassword>();
    codeCheckUseCase = sl<CodeCheck>();
    passwordChangeUseCase = sl<PasswordChange>();
    checkVerifiedUserUseCase = sl<CheckVerifiedUserUseCase>();
    deleteAccountUseCase = sl<DeleteAccountUseCase>();

    on<LoginEvent>(_onLoginEvent);
    on<LogoutEvent>(_onLogoutEvent);
    on<CheckIfLoggedEvent>(_onCheckingUser);
    on<VerifiedUser>(_onCheckingUserVerified);
    on<RegisterEvent>(_onRegisterEvent);
    on<ForgetPasswordEvent>(_forgetPasswordEvent);
    on<CodeCheckEvent>(_codeCheckEvent);
    on<UpdatePasswordEvent>(_updatePasswordEvent);
    on<DeleteAccountEvent>(_onDeleteAccount);
  }

  /// Event to login user
  _onLoginEvent(LoginEvent event, Emitter<AuthState> emitter) async {
    emitter(LoadingLogin());
    String email = loginEmailController.text.trim();
    String password = loginPasswordController.text.trim();
    final result = await loginUseCase.call(LoginParams(email: email, password: password));
    result.fold((l) {
      emitter(LoginError(l.errorMessage, (l is ServerFailure) ? l.statusCode : null));
    }, (r) {
      sl<AuthSharedPrefs>().saveUser(r);
      emitter(LoginSuccess(user: r));

    });
  }

  /// Event to register user
  _onRegisterEvent(RegisterEvent event, Emitter<AuthState> emitter) async {
    emitter(LoadingRegister());
    String userName = signupUserNameController.text.trim();
    String firstName = signupFirstNameController.text.trim();
    String lastName = signupLastNameController.text.trim();
    String? phoneNumber = (number.phoneNumber ?? "").replaceAll(number.dialCode.toString(), "").isEmpty?null:number.phoneNumber;
    String email = signupEmailController.text.trim();
    String password = signupPasswordController.text.trim();
    final result = await signupUseCase
        .call(SignUpParams(username: userName, email: email, firstName: firstName, lastName: lastName, password: password, phoneNumber: phoneNumber));
    result.fold((l) {
      emitter(RegisterError(l.errorMessage));
    }, (r) {
      sl<AuthSharedPrefs>().saveUser(r);

      emitter(RegisterSuccess(email));
    });
  }

  /// Event to login to home page
  _onCheckingUser(CheckIfLoggedEvent event, Emitter<AuthState> emitter) async {
    if (await sl<AuthSharedPrefs>().hasToken()) {
      emitter(AuthUserLoggedInState());
    } else if ((sl<AuthSharedPrefs>().getUser().id ?? -1) != -1) {
      emitter(VerifyEmailLoggedInState());
    } else {
      emitter(AuthUserNotLoggedInState());
    }
  }

  /// Event to check if user verified
  _onCheckingUserVerified(VerifiedUser event, Emitter<AuthState> emitter) async {
    final result = await checkVerifiedUserUseCase
        .call(CheckVerifiedUserParams(verificationCode: event.verifiedString,email: event.email));
    result.fold((l) {
      emitter(CheckVerifiedError(l.errorMessage));
    }, (r) {
      if (r == true){
        emitter(VerifiedUserSuccess());
      }else{
        emitter(VerifiedUserError());
      }
    });
  }

  /// Event to log out user
  _onLogoutEvent(LogoutEvent event, Emitter<AuthState> emitter) async {
    final result = await logoutUseCase.call(LogoutParams());
    result.fold((l) {
      emitter(ErrorInLogOut(l.errorMessage));
    }, (r) {
      emitter(const UserLoggedOut());
    });
  }

  /// Clear signup text fields
  void clearSignupTextField() {
    signupUserNameController.clear();
    signupFirstNameController.clear();
    signupLastNameController.clear();
    signupEmailController.clear();
    confirmPasswordController.clear();
    number = PhoneNumber(isoCode: 'AE', dialCode: "+971");
    signupPasswordController.clear();
  }

  /// Clear signup text fields
  void clearLoginTextField() {
    loginEmailController.clear();
    loginPasswordController.clear();
  }

  _forgetPasswordEvent(ForgetPasswordEvent event, Emitter<AuthState> emitter) async {
    emitter(ForgetPasswordLoading());
    final result = await forgetPasswordUseCase.call(event.params);
    result.fold((l) {
      emitter(ForgetPasswordError(l.errorMessage, (l is ServerFailure) ? l.statusCode : null));
    }, (r) {
      emitter(ForgetPasswordSuccess());
    });
  }

  _codeCheckEvent(CodeCheckEvent event, Emitter<AuthState> emitter) async {
    emitter(CodeCheckLoading());
    final result = await codeCheckUseCase.call(event.params);
    result.fold((l) {
      emitter(CodeCheckError(l.errorMessage, (l is ServerFailure) ? l.statusCode : null));
    }, (r) {
      emitter(CodeCheckSuccess());
    });
  }

  _updatePasswordEvent(UpdatePasswordEvent event, Emitter<AuthState> emitter) async {
    emitter(UpdatePasswordLoading());
    final result = await passwordChangeUseCase.call(event.params);
    result.fold((l) {
      emitter(UpdatePasswordError(l.errorMessage, (l is ServerFailure) ? l.statusCode : null));
    }, (r) {
      emitter(UpdatePasswordSuccess());
    });
  }


  /// Event to login to home page
  _onDeleteAccount(DeleteAccountEvent event, Emitter<AuthState> emitter) async {
    emitter(LoadingDeleteAccountState());
    final result = await deleteAccountUseCase.call(DeleteAccountParams());
    result.fold((l) {
      emitter(ErrorDeleteAccountState(l));
    }, (r) {
      emitter(SuccessDeleteAccountState());
    });
  }
}
