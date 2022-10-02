/*
 * Created by Yamen Abdulrahman on 11/09/2022.
 * Connection email: yamen.abd98@gmail.com
*/

import 'package:json_annotation/json_annotation.dart';
part 'balance_info_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class BalanceInfoModel {
  BalanceInfoModel({
    required this.id,
    required this.stackingBalance,
    required this.remainingAmount,
    required this.startedAt,
    required this.status,
    this.withdrewAt,
    this.withdrawAmount,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
  });
  late final int id;
  late final int stackingBalance;
  late final int remainingAmount;
  late final String startedAt;
  late final String status;
  late final String? withdrewAt;
  late final String? withdrawAmount;
  late final int userId;
  late final String createdAt;
  late final String updatedAt;

  factory BalanceInfoModel.fromJson(json) => _$BalanceInfoModelFromJson(json);

  toJson() => _$BalanceInfoModelToJson(this);
}