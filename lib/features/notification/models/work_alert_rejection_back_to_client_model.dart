import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:quikhyr_worker/common/enums/work_alert_type.dart';

class WorkAlertRejectionBackToClientModel extends Equatable {
  final List<String> receiverIds;
  final String senderId;
  final String workAlertId;
  final WorkAlertType type;
  const WorkAlertRejectionBackToClientModel({
    required this.receiverIds,
    required this.type,
    required this.workAlertId,
    required this.senderId,
  });

  WorkAlertRejectionBackToClientModel copyWith({
    List<String>? receiverIds,
    WorkAlertType? type,
    String? workAlertId,
    String? senderId,
  }) {
    return WorkAlertRejectionBackToClientModel(

      receiverIds: receiverIds ?? this.receiverIds,
      type: type ?? this.type,
      workAlertId: workAlertId ?? this.workAlertId,
      senderId: senderId ?? this.senderId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'type': type.toJson(),
      'receiverIds': receiverIds,
      'workAlertId': workAlertId,
      'senderId': senderId,
    };
  }

  factory WorkAlertRejectionBackToClientModel.fromMap(Map<String, dynamic> map) {
    return WorkAlertRejectionBackToClientModel(
      type: WorkAlertType.fromJson(map['type'] as String),
      receiverIds: List<String>.from(map['receiverIds']),
      workAlertId: map['workAlertId'] as String,
      senderId: map['senderId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory WorkAlertRejectionBackToClientModel.fromJson(String source) =>
      WorkAlertRejectionBackToClientModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      receiverIds,
      type,
      workAlertId,
      senderId,
    ];
  }
}
