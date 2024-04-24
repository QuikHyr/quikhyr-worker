// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:quikhyr_worker/common/enums/work_alert_type.dart';
import 'package:quikhyr_worker/models/booking_model.dart';
import 'package:quikhyr_worker/models/location_model.dart';

class NotificationModel extends Equatable {
  final String? subserviceId;
  final List<String>? receiverIds;
  final LocationModel? location;
  final String? description;
  final List<String>? images;
  final String? senderId;
  final String? locationName;
  final String? workAlertId;
  final Timestamps? timestamps;
  final WorkAlertType? type;
  const NotificationModel({
    this.receiverIds,
    this.timestamps,
    this.type,
    this.workAlertId,
    this.locationName,
    this.subserviceId,
    this.location,
    this.description,
    this.images,
    this.senderId,
  });

  NotificationModel copyWith({
    List<String>? receiverIds,
    Timestamps? timestamps,
    WorkAlertType? type,
    String? workAlertId,
    String? locationName,
    String? subserviceId,
    LocationModel? location,
    String? description,
    List<String>? images,
    String? senderId,
  }) {
    return NotificationModel(
      receiverIds: receiverIds ?? this.receiverIds,
      timestamps: timestamps ?? this.timestamps,
      type: type ?? this.type,
      workAlertId: workAlertId ?? this.workAlertId,
      locationName: locationName ?? this.locationName,
      subserviceId: subserviceId ?? this.subserviceId,
      location: location ?? this.location,
      description: description ?? this.description,
      images: images ?? this.images,
      senderId: senderId ?? this.senderId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'timestamps': timestamps?.toJson(),
      'locationName': locationName,
      'location': location?.toMap(),
      'description': description,
      'images': images,
      'type': type?.toJson(),
      'receiverIds': receiverIds,
      'workAlertId': workAlertId,
      'subserviceId': subserviceId,
      'senderId': senderId,
    };
  }

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      type: WorkAlertType.fromJson(map['type'] as String),
      receiverIds: List<String>.from(map['receiverIds']),
      timestamps: Timestamps.fromMap(map['timestamps'] as Map<String, dynamic>),
      workAlertId: map['workAlertId'] as String,
      locationName: map['locationName'] as String,
      subserviceId: map['subserviceId'] as String,
      location: LocationModel.fromMap(map['location'] as Map<String, dynamic>),
      description: map['description'] as String,
      images: List<String>.from(map['images']),
      senderId: map['senderId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory NotificationModel.fromJson(String source) =>
      NotificationModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      receiverIds,
      timestamps,
      type,
      workAlertId,
      locationName,
      subserviceId,
      location,
      description,
      images,
      senderId,
    ];
  }
}
