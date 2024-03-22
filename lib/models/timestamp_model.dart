// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class TimestampsModel extends Equatable {
  final Timestamp createdAt;
  final Timestamp updatedAt;

  const TimestampsModel({required this.createdAt, required this.updatedAt});
  
  @override
  List<Object?> get props => [createdAt, updatedAt];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'createdAt': createdAt.toDate().toIso8601String(),
      'updatedAt': updatedAt.toDate().toIso8601String(),
    };
  }

  factory TimestampsModel.fromMap(Map<String, dynamic> map) {
    return TimestampsModel(
      createdAt: Timestamp.fromDate(DateTime.parse(map['createdAt'] as String)),
      updatedAt: Timestamp.fromDate(DateTime.parse(map['updatedAt'] as String)),
    );
  }

  String toJson() => json.encode(toMap());

  factory TimestampsModel.fromJson(String source) => TimestampsModel.fromMap(json.decode(source) as Map<String, dynamic>);
}