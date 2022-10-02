import 'package:dartz/dartz.dart';
import '../../../../core/core.dart';
import '../../../../core/data/entities/user.dart';
import '../repositories/auth_repository.dart';

class SignupUseCase extends UseCase<User, SignUpParams> {
  final AuthRepository repository;
  SignupUseCase(this.repository);

  @override
  Future<Either<Failure, User>> call(SignUpParams params) async {
    final result = await repository.signup(params);
    return result.fold((l) {
      return Left(l);
    }, (r) async {
      return Right(r);
    });
  }
}

class SignUpParams {
  SignUpParams({
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.phoneNumber,
  });
  late final String username;
  late final String firstName;
  late final String lastName;
  late final String email;
  late final String password;
    String? phoneNumber;

  SignUpParams.fromJson(Map<String, dynamic> json) {
    username = json["username"];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    password = json['password'];
    phoneNumber = json['phone_number'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data["username"] = username;
    _data['first_name'] = firstName;
    _data['last_name'] = lastName;
    _data['email'] = email;
    _data['password'] = password;
    if (phoneNumber != null){
      _data['phone_number'] = phoneNumber;

    }
    return _data;
  }
}
