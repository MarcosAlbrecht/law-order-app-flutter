import 'package:app_law_order/src/models/cep_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'cep_result.freezed.dart';

@freezed
class CepResult with _$CepResult {
  factory CepResult.success(CepModel data) = Success;
  factory CepResult.error(String message) = Error;
}
