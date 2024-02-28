// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'wallet_model.g.dart';

@JsonSerializable()
class WalletModel {
  double? total;
  double? realizado;
  @JsonKey(name: 'saque_pendente')
  double? saquePendente;
  double? bloqueado;
  double? taxa;
  WalletModel({
    this.total,
    this.realizado,
    this.saquePendente,
    this.bloqueado,
    this.taxa,
  });

  factory WalletModel.fromJson(Map<String, dynamic> json) => _$WalletModelFromJson(json);

  Map<String, dynamic> toJson() => _$WalletModelToJson(this);
}
