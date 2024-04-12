// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:quikhyr_worker/models/location_model.dart';


class NotificationModel extends Equatable {
  final String subserviceId;
  final LocationModel location;
  final String description;
  final List<String>? images;
  final String senderId;
  const NotificationModel({
    required this.subserviceId,
    required this.location,
    required this.description,
    required this.images,
    required this.senderId,
  });

  NotificationModel copyWith({
    String? subserviceId,
    LocationModel? location,
    String? description,
    List<String>? images,
    String? senderId,
  }) {
    return NotificationModel(
      subserviceId: subserviceId ?? this.subserviceId,
      location: location ?? this.location,
      description: description ?? this.description,
      images: images ?? this.images,
      senderId: senderId ?? this.senderId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'subserviceId': subserviceId,
      'location': location.toMap(),
      'description': description,
      'images': images,
      'senderId': senderId,
    };
  }

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      subserviceId: map['subserviceId'] as String,
      location: LocationModel.fromMap(map['location'] as Map<String,dynamic>),
      description: map['description'] as String,
      images: List<String>.from(map['images']),
      senderId: map['senderId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory NotificationModel.fromJson(String source) => NotificationModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      subserviceId,
      location,
      description,
      images,
      senderId,
    ];
  }
}
