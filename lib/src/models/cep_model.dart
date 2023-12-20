// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'cep_model.g.dart';

@JsonSerializable()
class CepModel {
  @JsonKey(name: 'cep')
  String? cep;
  @JsonKey(name: 'logradouro')
  String? logradouro;
  @JsonKey(name: 'complemento')
  String? complemento;
  @JsonKey(name: 'bairro')
  String? bairro;
  @JsonKey(name: 'localidade')
  String? localidade;
  @JsonKey(name: 'uf')
  String? uf;
  @JsonKey(name: 'ibge')
  String? ibge;
  @JsonKey(name: 'gia')
  String? gia;
  @JsonKey(name: 'ddd')
  String? ddd;
  @JsonKey(name: 'siafi')
  String? siafi;
  CepModel({
    this.cep,
    this.logradouro,
    this.complemento,
    this.bairro,
    this.localidade,
    this.uf,
    this.ibge,
    this.gia,
    this.ddd,
    this.siafi,
  });

  factory CepModel.fromJson(Map<String, dynamic> json) =>
      _$CepModelFromJson(json);

  Map<String, dynamic> toJson() => _$CepModelToJson(this);
}
