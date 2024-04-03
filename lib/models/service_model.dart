// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class ServiceModel extends Equatable {
  final String image;
  final String name;
  final String description;
  final String avatar;
  final String id;
  const ServiceModel({
    required this.image,
    required this.name,
    required this.description,
    required this.avatar,
    required this.id,
  });

  ServiceModel copyWith({
    String? image,
    String? name,
    String? description,
    String? avatar,
    String? id,
  }) {
    return ServiceModel(
      image: image ?? this.image,
      name: name ?? this.name,
      description: description ?? this.description,
      avatar: avatar ?? this.avatar,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'image': image,
      'name': name,
      'description': description,
      'avatar': avatar,
      'id': id,
    };
  }

  factory ServiceModel.fromMap(Map<String, dynamic> map) {
    return ServiceModel(
      image: map['image'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      avatar: map['avatar'] as String,
      id: map['id'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ServiceModel.fromJson(String source) => ServiceModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      image,
      name,
      description,
      avatar,
      id,
    ];
  }
}
