import 'package:json_annotation/json_annotation.dart';


part 'user.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class User {
  final int? id;
  final String? username;
  final String? lastName;
  final String? firstName;
  final String? email;
  final String? emailVerifiedAt;
  final String? phoneNumber;
  final String? createdAt;
  final String? updatedAt;

  String? token;

  User({
    this.username,
    this.lastName,
    this.firstName,
    this.email,
    this.id,
    this.phoneNumber,
    this.createdAt,
    this.updatedAt,
    this.token,
    this.emailVerifiedAt,
  });

  factory User.fromJson(json) => _$UserFromJson(json);

  toJson() => _$UserToJson(this);

  static List<User> fromJsonList(List json) {
    return json.map((e) => User.fromJson(e)).toList();
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User && other.id == id;
  }

  @override
  int get hashCode {
    return id.hashCode;
  }
}
