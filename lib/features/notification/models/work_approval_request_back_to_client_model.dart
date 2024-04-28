// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:quikhyr_worker/models/location_model.dart';

class WorkApprovalRequestBackToClientModel extends Equatable {
  final num ratePerUnit;
  final String unit;
  final String subserviceId;
  final List<String> receiverIds;
  final LocationModel location;
  final String description;
  final DateTime dateTime;
  final String senderId;
  final String locationName;
  final String workAlertId;
  const WorkApprovalRequestBackToClientModel({
   required this.ratePerUnit,
   required this.unit,
   required this.dateTime,
   required this.receiverIds,
   required this.workAlertId,
   required this.locationName,
   required this.subserviceId,
   required this.location,
   required this.description,
   required this.senderId,
  });

  WorkApprovalRequestBackToClientModel copyWith({
    List<String>? receiverIds,
    String? workAlertId,
    String? locationName,
    String? subserviceId,
    LocationModel? location,
    String? description,
    String? senderId,
  }) {
    return WorkApprovalRequestBackToClientModel(
      ratePerUnit: ratePerUnit,
      unit: unit,
      dateTime: dateTime,
      receiverIds: receiverIds ?? this.receiverIds,
      workAlertId: workAlertId ?? this.workAlertId,
      locationName: locationName ?? this.locationName,
      subserviceId: subserviceId ?? this.subserviceId,
      location: location ?? this.location,
      description: description ?? this.description,
      senderId: senderId ?? this.senderId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'ratePerUnit': ratePerUnit,
      'unit': unit,
      'dateTime': dateTime.toIso8601String(),
      'locationName': locationName,
      'location': location.toMap(),
      'description': description,
      'receiverIds': receiverIds,
      'workAlertId': workAlertId,
      'subserviceId': subserviceId,
      'senderId': senderId,
    };
  }

  // factory WorkApprovalRequestBackToClientModel.fromMap(Map<String, dynamic> map) {
  //   return WorkApprovalRequestBackToClientModel(
  //     ratePerUnit: map['ratePerUnit'] as num,
  //     unit: map['unit'] as String,
  //     dateTime: DateTime.parse(map['dateTime'] as String),
  //     receiverIds: List<String>.from(map['receiverIds']),
  //     workAlertId: map['workAlertId'] as String,
  //     locationName: map['locationName'] as String,
  //     subserviceId: map['subserviceId'] as String,
  //     location: LocationModel.fromMap(map['location'] as Map<String, dynamic>),
  //     description: map['description'] as String,
  //     senderId: map['senderId'] as String,
  //   );
  // }

  String toJson() => json.encode(toMap());

  // factory WorkApprovalRequestBackToClientModel.fromJson(String source) =>
  //     WorkApprovalRequestBackToClientModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      receiverIds,
      workAlertId,
      locationName,
      subserviceId,
      location,
      description,
      senderId,
    ];
  }
}
