part of 'auth_bloc.dart';

abstract class AuthState {
  const AuthState();
}

/// User logged in state
class AuthUserLoggedInState extends AuthState {}

/// User not logged in state
class AuthUserNotLoggedInState extends AuthState {}

class VerifyEmailLoggedInState extends AuthState {}

/// Login state

class AuthInitial extends AuthState {}

class LoginSuccess extends AuthState {
  final User? user;

  const LoginSuccess({this.user});
}

class LoadingLogin extends AuthState {}

class LoginError extends AuthState {
  final String error;
  final int? statusCode;

  const LoginError(this.error, this.statusCode);
}


class LoginDisabledError extends AuthState {
}

/// Register state
class RegisterSuccess extends AuthState {
  final String email;
  const RegisterSuccess(this.email);
}

class LoadingRegister extends AuthState {}

class RegisterError extends AuthState {
  final String error;

  const RegisterError(this.error);
}

class UserExists extends AuthState {
  const UserExists();
}

class NoPrevoiusLoggin extends AuthState {
  const NoPrevoiusLoggin();
}

class UserLoggedOut extends AuthState {
  const UserLoggedOut();
}

class ErrorInLogOut extends AuthState {
  final String error;

  const ErrorInLogOut(this.error);
}

class SetFcmTokenSuccess extends AuthState {
  const SetFcmTokenSuccess();
}

class ErrorInSetFcmToken extends AuthState {
  final String error;

  const ErrorInSetFcmToken(this.error);
}

class LoadingSetFcmToken extends AuthState {}

class TFAConfirmationSuccess extends AuthState {
  const TFAConfirmationSuccess();
}

class ErrorInTFAConfirmation extends AuthState {
  final String error;

  const ErrorInTFAConfirmation(this.error);
}

class ErrorInSetEmailConfirmationCode extends AuthState {
  final String error;

  const ErrorInSetEmailConfirmationCode(this.error);
}

class SetEmailConfirmationCodeSuccess extends AuthState {
  const SetEmailConfirmationCodeSuccess();
}

class DeleteAccountSuccess extends AuthState {
  const DeleteAccountSuccess();
}

class ErrorInDeleteAccount extends AuthState {
  final String error;

  const ErrorInDeleteAccount(this.error);
}

class ForgetPasswordLoading extends AuthState {}

class ForgetPasswordError extends AuthState {
  final String error;
  final int? statusCode;
  const ForgetPasswordError(this.error, this.statusCode);
}

class ForgetPasswordSuccess extends AuthState {}

class CodeCheckLoading extends AuthState {}

class CodeCheckError extends AuthState {
  final String error;
  final int? statusCode;
  const CodeCheckError(this.error, this.statusCode);
}

class CodeCheckSuccess extends AuthState {}

class UpdatePasswordLoading extends AuthState {}

class UpdatePasswordError extends AuthState {
  final String error;
  final int? statusCode;
  const UpdatePasswordError(this.error, this.statusCode);
}

class UpdatePasswordSuccess extends AuthState {}


class CheckVerifiedError extends AuthState {
  final String error;

  const CheckVerifiedError(this.error);
}

class VerifiedUserSuccess extends AuthState {
  const VerifiedUserSuccess();
}
class VerifiedUserError extends AuthState {
  const VerifiedUserError();
}


/// State to delete account
class LoadingDeleteAccountState  extends AuthState{

}

/// State to delete account
class SuccessDeleteAccountState  extends AuthState{

}

/// State to delete account
class ErrorDeleteAccountState  extends AuthState{
  final Failure failure;

  ErrorDeleteAccountState(this.failure);
}