import 'dart:io';

import 'package:dio/dio.dart';

import 'name.dart';

// class SignImage{
//   String? imagePath;
//   File? imageFile;

//   SignImage({this.imageFile,this.imagePath});

//   SignImage.fromJson(Map<String, dynamic> json) {
//     imagePath = json['imagePath'];
//     imageFile = json['imageFile'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['imagePath'] = this.imagePath;
//     data['imageFile'] = this.imageFile;
//     return data;
//   }

// }
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
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.name != null) {
      data['name'] = this.name!.toJson();
    }
    if (this.description != null) {
      data['description'] = this.description!.toJson();
    }
    if (this.solution != null) {
      data['solution'] = this.solution!.toJson();
    }
    data['image'] = this.image;
    return data;
  }
}