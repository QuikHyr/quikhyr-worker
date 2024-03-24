// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:quikhyr_worker/common/quik_asset_constants.dart';
import 'package:quikhyr_worker/models/location_model.dart';

class ClientModel extends Equatable {
  final String id;
  final String name;
  final int? age;
  final String avatar;
  final String email;
  final String gender;
  final LocationModel location;
  final String phone;
  final String pincode;
  const ClientModel({
    required this.id,
    required this.name,
    this.age,
    this.avatar = QuikAssetConstants.placeholderImage,
    required this.email,
    required this.gender,
    required this.location,
    required this.phone,
    required this.pincode,
  });

  ClientModel copyWith({
    String? id,
    String? name,
    int? age,
    String? avatar,
    String? email,
    String? gender,
    LocationModel? location,
    String? phone,
    String? pincode,
  }) {
    return ClientModel(
      id: id ?? this.id,
      name: name ?? this.name,
      age: age ?? this.age,
      avatar: avatar ?? this.avatar,
      email: email ?? this.email,
      gender: gender ?? this.gender,
      location: location ?? this.location,
      phone: phone ?? this.phone,
      pincode: pincode ?? this.pincode,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'age': age,
      'avatar': avatar,
      'email': email,
      'gender': gender,
      'location': location.toMap(),
      'phone': phone,
      'pincode': pincode,
    };
  }

  factory ClientModel.fromMap(Map<String, dynamic> map) {
    return ClientModel(
      id: map['id'] as String,
      name: map['name'] as String,
      age: map['age'] != null ? map['age'] as int : null,
      avatar: map['avatar'] as String,
      email: map['email'] as String,
      gender: map['gender'] as String,
      location: LocationModel.fromMap(map['location'] as Map<String, dynamic>),
      phone: map['phone'] as String,
      pincode: map['pincode'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ClientModel.fromJson(String source) =>
      ClientModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'WorkerModel{id: $id, name: $name, age: $age, avatar: $avatar, email: $email, gender: $gender, location: $location, phone: $phone, pincode: $pincode}';
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      id,
      name,
      age,
      avatar,
      email,
      gender,
      location,
      phone,
      pincode,
    ];
  }
}
