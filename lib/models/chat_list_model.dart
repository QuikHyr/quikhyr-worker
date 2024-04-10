// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:quikhyr_worker/models/chat_message_model.dart';

String messageTypeToString(MessageType type) {
  switch (type) {
    case MessageType.text:
      return 'text';
    case MessageType.image:
      return 'image';
    default:
      return 'unknown';
  }
}

MessageType stringToMessageType(String type) {
  switch (type) {
    case 'text':
      return MessageType.text;
    case 'image':
      return MessageType.image;
    default:
      return MessageType.text; // default to text if type is not recognized
  }
}

class ChatListModel extends Equatable {
  final String name;
  final String id;
  final bool isVerified;
  final bool isActive;
  final String avatar;
  final String lastMessage;
  final DateTime sentTime;
  final MessageType messageType;
  const ChatListModel({
    required this.name,
    required this.id,
    required this.isVerified,
    required this.isActive,
    required this.lastMessage,
    required this.sentTime,
    required this.messageType,
    required this.avatar,
  });

  ChatListModel copyWith({
    String? name,
    String? id,
    bool? isVerified,
    bool? isActive,
    String? lastMessage,
    DateTime? sentTime,
    MessageType? messageType,
    String? avatar,
  }) {
    return ChatListModel(
      name: name ?? this.name,
      id: id ?? this.id,
      isVerified: isVerified ?? this.isVerified,
      isActive: isActive ?? this.isActive,
      lastMessage: lastMessage ?? this.lastMessage,
      sentTime: sentTime ?? this.sentTime,
      messageType: messageType ?? this.messageType,
      avatar: avatar ?? this.avatar,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'isVerified': isVerified,
      'isActive': isActive,
      'lastMessage': lastMessage,
      'sentTime': sentTime.millisecondsSinceEpoch,
      'messageType': messageTypeToString(messageType),
      'avatar': avatar,
    };
  }

  factory ChatListModel.fromMap(Map<String, dynamic> map) {
    return ChatListModel(
      name: map['name'] as String,
      id: map['id'] as String,
      isVerified: map['isVerified'] as bool,
      isActive: map['isActive'] as bool,
      lastMessage: map['lastMessage'] as String,
      sentTime: DateTime.fromMillisecondsSinceEpoch(map['sentTime'] as int),
      messageType: stringToMessageType(map['messageType'] as String),
      avatar: map['avatar'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatListModel.fromJson(String source) =>
      ChatListModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      name,
      id,
      isVerified,
      isActive,
      lastMessage,
      sentTime,
      messageType,
      avatar,
    ];
  }
}
