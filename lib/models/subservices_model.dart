// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class SubserviceModel extends Equatable {
  final String name;
  final String serviceId;
  final String serviceName;
  final List<String> tags;
  final String id;
  const SubserviceModel({
    required this.name,
    required this.serviceId,
    required this.serviceName,
    required this.tags,
    required this.id,
  });

  SubserviceModel copyWith({
    String? name,
    String? serviceId,
    String? serviceName,
    List<String>? tags,
    String? id,
  }) {
    return SubserviceModel(
      name: name ?? this.name,
      serviceId: serviceId ?? this.serviceId,
      serviceName: serviceName ?? this.serviceName,
      tags: tags ?? this.tags,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'serviceId': serviceId,
      'serviceName': serviceName,
      'tags': tags,
      'id': id,
    };
  }

  factory SubserviceModel.fromMap(Map<String, dynamic> map) {
    return SubserviceModel(
      name: map['name'] as String,
      serviceId: map['serviceId'] as String,
      serviceName: map['serviceName'] as String,
      tags: List<String>.from(map['tags']),
      id: map['id'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SubserviceModel.fromJson(String source) => SubserviceModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      name,
      serviceId,
      serviceName,
      tags,
      id,
    ];
  }
}
