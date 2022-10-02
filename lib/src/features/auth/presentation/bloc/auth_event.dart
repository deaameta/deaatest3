part of 'auth_bloc.dart';

abstract class AuthEvent {
  const AuthEvent();
}

/// Event to login by email and password
class LoginEvent extends AuthEvent {}

/// Event to register new user
class RegisterEvent extends AuthEvent {}

/// Event for check user if logged in or not
class CheckIfLoggedEvent extends AuthEvent {}

class VerifiedUser extends AuthEvent {
  final String verifiedString;
  final String email;
  VerifiedUser(this.verifiedString,this.email);
}

/// Event for logout
class LogoutEvent extends AuthEvent {}

class ForgetPasswordEvent extends AuthEvent {
  final ForgetPasswordParams params;

  ForgetPasswordEvent(this.params);
}

class CodeCheckEvent extends AuthEvent {
  final CodeCheckParams params;

  CodeCheckEvent(this.params);
}

class UpdatePasswordEvent extends AuthEvent {
  final PasswordChangeParams params;

  UpdatePasswordEvent(this.params);
}


/// Event to delete account
class DeleteAccountEvent  extends AuthEvent{

}