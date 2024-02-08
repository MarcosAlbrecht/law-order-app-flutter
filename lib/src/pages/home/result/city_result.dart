import 'package:freezed_annotation/freezed_annotation.dart';

part 'city_result.freezed.dart';

@freezed
class CityResult<T> with _$CityResult<T> {
  factory CityResult.success(List<T> data) = Success;
  factory CityResult.error(String message) = Error;
}
