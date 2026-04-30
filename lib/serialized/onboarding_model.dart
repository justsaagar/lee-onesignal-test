import 'package:json_annotation/json_annotation.dart';

part 'onboarding_model.g.dart';

@JsonSerializable()
class OnBoardingModel {
  @JsonKey(name: 'image')
  final String? image;

  @JsonKey(name: 'headerLine')
  final String? headerLine;

  @JsonKey(name: 'subHeaderLine')
  final String? subHeaderLine;

  @JsonKey(name: 'isShow')
  final bool isShow;

  OnBoardingModel({
    this.image,
    this.headerLine,
    this.subHeaderLine,
    this.isShow = false,
  });

  factory OnBoardingModel.fromJson(Map<String, dynamic> json) =>
      _$OnBoardingModelFromJson(json);

  Map<String, dynamic> toJson() => _$OnBoardingModelToJson(this);
}
