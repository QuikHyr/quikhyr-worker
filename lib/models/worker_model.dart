// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:quikhyr_worker/common/quik_asset_constants.dart';
import 'package:quikhyr_worker/models/location_model.dart';

class WorkerModel extends Equatable {
  final String userId;
  final String name;
  final num? age;
  final bool available;
  final String avatar;
  final String email;
  final String gender;
  final LocationModel location;
  final String phone;
  final String pincode;
  final List<String> subservices;
  const WorkerModel({
    required this.userId,
    required this.name,
    this.age,
    required this.available,
    this.avatar = QuikAssetConstants.placeholderImage,
    required this.email,
    required this.gender,
    required this.location,
    required this.phone,
    required this.pincode,
    required this.subservices,
  });

  WorkerModel copyWith({
    String? userId,
    String? name,
    num? age,
    bool? available,
    String? avatar,
    String? email,
    String? gender,
    LocationModel? location,
    String? phone,
    String? pincode,
    List<String>? subservices,
  }) {
    return WorkerModel(
      userId: userId ?? this.userId,
      name: name ?? this.name,
      age: age ?? this.age,
      available: available ?? this.available,
      avatar: avatar ?? this.avatar,
      email: email ?? this.email,
      gender: gender ?? this.gender,
      location: location ?? this.location,
      phone: phone ?? this.phone,
      pincode: pincode ?? this.pincode,
      subservices: subservices ?? this.subservices,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'name': name,
      'age': age,
      'available': available,
      'avatar': avatar,
      'email': email,
      'gender': gender,
      'location': location.toMap(),
      'phone': phone,
      'pincode': pincode,
      'subservices': subservices,
    };
  }

  factory WorkerModel.fromMap(Map<String, dynamic> map) {
    return WorkerModel(
      userId: map['userId'] as String,
      name: map['name'] as String,
      age: map['age'] != null ? map['age'] as num : null,
      available: map['available'] as bool,
      avatar: map['avatar'] as String,
      email: map['email'] as String,
      gender: map['gender'] as String,
      location: LocationModel.fromMap(map['location'] as Map<String,dynamic>),
      phone: map['phone'] as String,
      pincode: map['pincode'] as String,
      subservices: List<String>.from((map['subservices'] as List<String>),)
    );
  }

  String toJson() => json.encode(toMap());

  factory WorkerModel.fromJson(String source) => WorkerModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      userId,
      name,
      age,
      available,
      avatar,
      email,
      gender,
      location,
      phone,
      pincode,
      subservices,
    ];
  }
}
