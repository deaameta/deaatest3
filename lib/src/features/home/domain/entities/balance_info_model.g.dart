// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'balance_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BalanceInfoModel _$BalanceInfoModelFromJson(Map<String, dynamic> json) =>
    BalanceInfoModel(
      id: json['id'] as int,
      stackingBalance: json['stacking_balance'] as int,
      remainingAmount: json['remaining_amount'] as int,
      startedAt: json['started_at'] as String,
      status: json['status'] as String,
      withdrewAt: json['withdrew_at'] as String?,
      withdrawAmount: json['withdraw_amount'] as String?,
      userId: json['user_id'] as int,
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
    );

Map<String, dynamic> _$BalanceInfoModelToJson(BalanceInfoModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'stacking_balance': instance.stackingBalance,
      'remaining_amount': instance.remainingAmount,
      'started_at': instance.startedAt,
      'status': instance.status,
      'withdrew_at': instance.withdrewAt,
      'withdraw_amount': instance.withdrawAmount,
      'user_id': instance.userId,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
