// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:quikhyr_worker/common/quik_asset_constants.dart';
import 'package:quikhyr_worker/models/location_model.dart';

class WorkerModel extends Equatable {
  final String id;
  final String name;
  final String fcmToken;
  final bool isVerified;
  final bool isActive;
  final num? age;
  final bool available;
  final String avatar;
  final String email;
  final String gender;
  final LocationModel location;
  final String? locationName;
  final String phone;
  final String pincode;
  final List<String> subserviceIds;
  final List<String> serviceIds;

  const WorkerModel({
    this.locationName = "Initial Location",
    required this.fcmToken,
    required this.isVerified,
    required this.isActive,
    required this.id,
    required this.name,
    this.age,
    required this.available,
    this.avatar = QuikAssetConstants.placeholderImage,
    required this.email,
    required this.gender,
    required this.location,
    required this.phone,
    required this.pincode,
    required this.subserviceIds,
    required this.serviceIds,
  });

  WorkerModel copyWith({
    String? locationName,
    String? fcmToken,
    bool? isVerified,
    bool? isActive,
    String? id,
    String? name,
    num? age,
    bool? available,
    String? avatar,
    String? email,
    String? gender,
    LocationModel? location,
    String? phone,
    String? pincode,
    List<String>? subserviceIds,
    List<String>? serviceIds,
  }) {
    return WorkerModel(
      locationName: locationName ?? this.locationName,
      id: id ?? this.id,
      name: name ?? this.name,
      age: age ?? this.age,
      available: available ?? this.available,
      avatar: avatar ?? this.avatar,
      email: email ?? this.email,
      gender: gender ?? this.gender,
      location: location ?? this.location,
      phone: phone ?? this.phone,
      pincode: pincode ?? this.pincode,
      subserviceIds: subserviceIds ?? this.subserviceIds,
      serviceIds: serviceIds ?? this.serviceIds,
      fcmToken: fcmToken ?? this.fcmToken,
      isVerified: isVerified ?? this.isVerified,
      isActive: isActive ?? this.isActive,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'locationName': locationName,
      'id': id,
      'fcmToken': fcmToken,
      'isVerified': isVerified,
      'isActive': isActive,
      'name': name,
      'age': age,
      'available': available,
      'avatar': avatar,
      'email': email,
      'gender': gender,
      'location': location.toMap(),
      'phone': phone,
      'pincode': pincode,
      'subserviceIds': subserviceIds,
      'serviceIds': serviceIds,
    };
  }

  factory WorkerModel.fromMap(Map<String, dynamic> map) {
    return WorkerModel(
      locationName: map['locationName'] != null ? map['locationName'] as String : 'Location not found',
      fcmToken: map['fcmToken'] as String,
      isVerified: map['isVerified'] as bool,
      isActive: map['isActive'] as bool,
      id: map['id'] as String,
      name: map['name'] as String,
      age: map['age'] as num,
      available: map['available'] as bool,
      avatar: map['avatar'] as String,
      email: map['email'] as String,
      gender: map['gender'] as String,
      location: LocationModel.fromMap(map['location'] as Map<String, dynamic>),
      phone: map['phone'] as String,
      pincode: map['pincode'] as String,
      subserviceIds:
          (map['subserviceIds'] as List).map((item) => item as String).toList(),
      serviceIds:
          (map['serviceIds'] as List).map((item) => item as String).toList(),
    );
  }

  String toJson() => json.encode(toMap());

  factory WorkerModel.fromJson(String source) =>
      WorkerModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      locationName,
      id,
      name,
      age,
      available,
      avatar,
      email,
      gender,
      location,
      phone,
      pincode,
      subserviceIds,
      serviceIds,
      fcmToken,
      isVerified,
      isActive,
    ];
  }
}
