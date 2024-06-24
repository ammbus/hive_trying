
import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:trying_storing/model/handle_model.dart';

part 'bird_model.g.dart';

@HiveType(typeId: 0)
class BirdModel extends ResultModel {
  @HiveField(0)
  String name;
  @HiveField(1)
  String family;
  @HiveField(2)
  String image;

  BirdModel({
    required this.name,
    required this.family,
    required this.image,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'family': family,
      'image': image,
    };
  }

  factory BirdModel.fromMap(Map<String, dynamic> map) {
    return BirdModel(
      name: map['name'],
      family: map['family'],
      image: map['image'],
    );
  }

  String toJson() => json.encode(toMap());

  factory BirdModel.fromJson(String source) => BirdModel.fromMap(json.decode(source));
}
