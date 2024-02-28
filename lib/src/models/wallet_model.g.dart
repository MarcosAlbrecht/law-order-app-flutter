// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WalletModel _$WalletModelFromJson(Map<String, dynamic> json) => WalletModel(
      total: (json['total'] as num?)?.toDouble(),
      realizado: (json['realizado'] as num?)?.toDouble(),
      saquePendente: (json['saque_pendente'] as num?)?.toDouble(),
      bloqueado: (json['bloqueado'] as num?)?.toDouble(),
      taxa: (json['taxa'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$WalletModelToJson(WalletModel instance) =>
    <String, dynamic>{
      'total': instance.total,
      'realizado': instance.realizado,
      'saque_pendente': instance.saquePendente,
      'bloqueado': instance.bloqueado,
      'taxa': instance.taxa,
    };
