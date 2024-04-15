// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:quikhyr_worker/models/location_model.dart';

class BookingModel extends Equatable {
  final String clientId;
  final DateTime dateTime;
  final LocationModel location;
  final String? locationName;
  final num ratePerUnit;
  final String status;
  final String unit;
  final String subserviceId;
  final String workerId;
  const BookingModel({
    required this.clientId,
    required this.dateTime,
    required this.location,
    required this.subserviceId,
    this.locationName,
    required this.ratePerUnit,
    required this.status,
    required this.unit,
    required this.workerId,
  });

  BookingModel copyWith({
    String? subserviceId,
    String? clientId,
    DateTime? dateTime,
    LocationModel? location,
    String? locationName,
    num? ratePerUnit,
    String? status,
    String? unit,
    String? workerId,
  }) {
    return BookingModel(
      subserviceId: subserviceId ?? this.subserviceId,
      clientId: clientId ?? this.clientId,
      dateTime: dateTime ?? this.dateTime,
      location: location ?? this.location,
      locationName: locationName ?? this.locationName,
      ratePerUnit: ratePerUnit ?? this.ratePerUnit,
      status: status ?? this.status,
      unit: unit ?? this.unit,
      workerId: workerId ?? this.workerId,
    );
  }

  String get formattedDate {
    final DateFormat formatter = DateFormat('dd/MM/yyyy HH:mm:ss');
    return formatter.format(dateTime);
  }

  static DateTime parseDateTime(String dateString) {
    return DateFormat('dd/MM/yyyy HH:mm:ss').parse(dateString);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'subserviceId': subserviceId,
      'clientId': clientId,
      'dateTime': formattedDate,
      'location': location.toMap(),
      'locationName': locationName,
      'ratePerUnit': ratePerUnit,
      'status': status,
      'unit': unit,
      'workerId': workerId,
    };
  }

  factory BookingModel.fromMap(Map<String, dynamic> map) {
    return BookingModel(
      subserviceId: map['subserviceId'] as String,
      clientId: map['clientId'] as String,
      dateTime: parseDateTime(map['dateTime']),
      location: map['location']
          .LocationModel
          .fromMap(map['location'] as Map<String, dynamic>),
      locationName: map['locationName'] as String,
      ratePerUnit: map['ratePerUnit'] as num,
      status: map['status'] as String,
      unit: map['unit'] as String,
      workerId: map['workerId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory BookingModel.fromJson(String source) =>
      BookingModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      subserviceId,
      clientId,
      dateTime,
      location,
      locationName,
      ratePerUnit,
      status,
      unit,
      workerId,
    ];
  }
}
