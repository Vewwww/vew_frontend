import 'package:dio/dio.dart';
import 'name.dart';


class SignImage{
  Name? name;
  Name? description;
  Name? solution;
  MultipartFile? image;

  SignImage(
      {this.name,
      this.description,
      this.solution,
      this.image,});

  SignImage.fromJson(Map<String, dynamic> json) {
    name = json['name'] != null ? Name.fromJson(json['name']) : null;
    description = json['description'] != null
        ? Name.fromJson(json['description'])
        : null;
    solution =
        json['solution'] != null ? Name.fromJson(json['solution']) : null;
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (name != null) {
      data['name'] = name!.toJson();
    }
    if (description != null) {
      data['description'] = description!.toJson();
    }
    if (solution != null) {
      data['solution'] = solution!.toJson();
    }
    data['image'] = image;
    return data;
  }
}