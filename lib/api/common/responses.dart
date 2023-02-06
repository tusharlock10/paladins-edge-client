import "package:json_annotation/json_annotation.dart";
import "package:paladinsedge/models/index.dart"
    show Essentials, BountyStore, Item, FAQ, Feedback;

part "responses.g.dart";

@JsonSerializable()
class EssentialsResponse {
  final bool success;
  final String? error;
  final Essentials? data;

  EssentialsResponse({
    this.success = false,
    this.error,
    this.data,
  });

  factory EssentialsResponse.fromJson(Map<String, dynamic> json) =>
      _$EssentialsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$EssentialsResponseToJson(this);
}

@JsonSerializable()
class BountyStoreResponse {
  final bool success;
  final String? error;
  final List<BountyStore>? data;

  BountyStoreResponse({
    this.success = false,
    this.error,
    this.data,
  });

  factory BountyStoreResponse.fromJson(Map<String, dynamic> json) =>
      _$BountyStoreResponseFromJson(json);
  Map<String, dynamic> toJson() => _$BountyStoreResponseToJson(this);
}

@JsonSerializable()
class ItemsResponse {
  final bool success;
  final String? error;
  final List<Item>? data;

  ItemsResponse({
    this.success = false,
    this.error,
    this.data,
  });

  factory ItemsResponse.fromJson(Map<String, dynamic> json) =>
      _$ItemsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ItemsResponseToJson(this);
}

@JsonSerializable()
class FaqsResponse {
  final bool success;
  final String? error;
  final List<FAQ>? data;

  FaqsResponse({
    this.success = false,
    this.error,
    this.data,
  });

  factory FaqsResponse.fromJson(Map<String, dynamic> json) =>
      _$FaqsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$FaqsResponseToJson(this);
}

@JsonSerializable()
class SubmitFeedbackResponse {
  final bool success;
  final String? error;
  final Feedback? data;

  SubmitFeedbackResponse({
    this.success = false,
    this.error,
    this.data,
  });

  factory SubmitFeedbackResponse.fromJson(Map<String, dynamic> json) =>
      _$SubmitFeedbackResponseFromJson(json);
  Map<String, dynamic> toJson() => _$SubmitFeedbackResponseToJson(this);
}
