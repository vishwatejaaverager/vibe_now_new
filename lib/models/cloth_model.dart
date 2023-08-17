// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class ClothsModel {
  final String id;
  final List images;
  final String gender;
  final List likedPpl;
  final String about;
  final List links;
  final String type;
  ClothsModel({
    required this.id,
    required this.images,
    required this.gender,
    required this.likedPpl,
    required this.about,
    required this.links,
    required this.type,
  });

  ClothsModel copyWith({
    String? id,
    List? images,
    String? gender,
    List? likedPpl,
    String? about,
    List? links,
    String? type,
  }) {
    return ClothsModel(
      id: id ?? this.id,
      images: images ?? this.images,
      gender: gender ?? this.gender,
      likedPpl: likedPpl ?? this.likedPpl,
      about: about ?? this.about,
      links: links ?? this.links,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'images': images,
      'gender': gender,
      'likedPpl': likedPpl,
      'about': about,
      'links': links,
      'type': type,
    };
  }

  factory ClothsModel.fromMap(Map<String, dynamic> map) {
    return ClothsModel(
      id: map['id'] as String,
      images: List.from((map['images'] as List)),
      gender: map['gender'] as String,
      likedPpl: List.from((map['likedPpl'] as List)),
      about: map['about'] as String,
      links: List.from((map['links'] as List)),
      type: map['type'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ClothsModel.fromJson(String source) =>
      ClothsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ClothsModel(id: $id, images: $images, gender: $gender, likedPpl: $likedPpl, about: $about, links: $links, type: $type)';
  }

  @override
  bool operator ==(covariant ClothsModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      listEquals(other.images, images) &&
      other.gender == gender &&
      listEquals(other.likedPpl, likedPpl) &&
      other.about == about &&
      listEquals(other.links, links) &&
      other.type == type;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      images.hashCode ^
      gender.hashCode ^
      likedPpl.hashCode ^
      about.hashCode ^
      links.hashCode ^
      type.hashCode;
  }
}
