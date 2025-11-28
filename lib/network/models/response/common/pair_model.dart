
import 'package:json_annotation/json_annotation.dart';

part 'pair_model.g.dart';

@JsonSerializable()
class PairModel {

  PairModel({
    required this.id,
    required this.name,
  });

  factory PairModel.fromJson(Map<String, dynamic> json) => _$PairModelFromJson(json);
  int id;
  String name;

  Map<String, dynamic> toJson() => _$PairModelToJson(this);

}
