// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

import 'package:app_law_order/src/models/user_model.dart';

part 'follower_model.g.dart';

@JsonSerializable()
class FollowerModel {
  @JsonKey(name: '_id')
  String? id;
  @JsonKey(name: 'followerId')
  String? followerId;
  @JsonKey(name: 'followedId')
  String? followedId;
  @JsonKey(name: 'follower')
  UserModel? follower;
  FollowerModel({
    this.id,
    this.followerId,
    this.followedId,
    this.follower,
  });

  factory FollowerModel.fromJson(Map<String, dynamic> json) =>
      _$FollowerModelFromJson(json);

  Map<String, dynamic> toJson() => _$FollowerModelToJson(this);

  @override
  String toString() {
    return 'FollowerModel(id: $id, followerId: $followerId, followedId: $followedId, follower: $follower)';
  }
}
