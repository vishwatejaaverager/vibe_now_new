// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  final String uid;
  final String photoUrl;
  final String name;
  final String email;
  final String height;
  final String weight;

  final String faceShape;
  final String gender;
  final bool beard;
  final String complexity;

  UserModel({
    required this.uid,
    required this.photoUrl,
    required this.name,
    required this.email,
    required this.height,
    required this.weight,
    required this.faceShape,
    required this.gender,
    required this.beard,
    required this.complexity,
  });

  UserModel copyWith({
    String? uid,
    String? photoUrl,
    String? name,
    String? email,
    String? height,
    String? weight,
    String? faceShape,
    String? gender,
    bool? beard,
    String? complexity,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      photoUrl: photoUrl ?? this.photoUrl,
      name: name ?? this.name,
      email: email ?? this.email,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      faceShape: faceShape ?? this.faceShape,
      gender: gender ?? this.gender,
      beard: beard ?? this.beard,
      complexity: complexity ?? this.complexity,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'photoUrl': photoUrl,
      'name': name,
      'email': email,
      'height': height,
      'weight': weight,
      'faceShape': faceShape,
      'gender': gender,
      'beard': beard,
      'complexity': complexity,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] as String,
      photoUrl: map['photoUrl'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      height: map['height'] as String,
      weight: map['weight'] as String,
      faceShape: map['faceShape'] as String,
      gender: map['gender'] as String,
      beard: map['beard'] as bool,
      complexity: map['complexity'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(uid: $uid, photoUrl: $photoUrl, name: $name, email: $email, height: $height, weight: $weight, faceShape: $faceShape, gender: $gender, beard: $beard, complexity: $complexity)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.uid == uid &&
        other.photoUrl == photoUrl &&
        other.name == name &&
        other.email == email &&
        other.height == height &&
        other.weight == weight &&
        other.faceShape == faceShape &&
        other.gender == gender &&
        other.beard == beard &&
        other.complexity == complexity;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        photoUrl.hashCode ^
        name.hashCode ^
        email.hashCode ^
        height.hashCode ^
        weight.hashCode ^
        faceShape.hashCode ^
        gender.hashCode ^
        beard.hashCode ^
        complexity.hashCode;
  }
}
