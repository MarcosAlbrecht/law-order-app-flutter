import 'package:app_law_order/src/models/metadata_recommendations_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'recommendation_result.freezed.dart';

@freezed
class RecommendationResult<T> with _$RecommendationResult<T> {
  factory RecommendationResult.success(MetadataRecommendationsModel data) = Success;
  factory RecommendationResult.error(String message) = Error;
}
