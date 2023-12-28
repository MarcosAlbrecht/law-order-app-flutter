// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

import 'package:app_law_order/src/models/user_model.dart';

part 'follows_model.g.dart';

@JsonSerializable()
class FollowsModel {
  @JsonKey(name: '_id')
  String? id;
  @JsonKey(name: 'followerId')
  String? followerId;
  @JsonKey(name: 'followedId')
  String? followedId;
  @JsonKey(name: 'followed')
  UserModel? followed;
  FollowsModel({
    this.id,
    this.followerId,
    this.followedId,
    this.followed,
  });

  factory FollowsModel.fromJson(Map<String, dynamic> json) =>
      _$FollowsModelFromJson(json);

  Map<String, dynamic> toJson() => _$FollowsModelToJson(this);

  @override
  String toString() {
    return 'FollowsModel(id: $id, followerId: $followerId, followedId: $followedId, followed: $followed)';
  }
}
