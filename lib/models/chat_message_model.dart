// ignore_for_file: public_member_api_docs, sort_constructors_first
class ChatMessageModel {
  final String? id;
  final bool? hasResponded;
  final String senderId;
  final String receiverId;
  final String content;
  final DateTime sentTime;
  final MessageType messageType;
  final DateTime? timeslot;
  final bool? isAccepted;
  final String? unit;
  final num? pricePerUnit;

  const ChatMessageModel({

    this.hasResponded,
    this.id,
    this.isAccepted,
    this.unit,
    this.pricePerUnit,
    this.timeslot,
    required this.senderId,
    required this.receiverId,
    required this.sentTime,
    required this.content,
    required this.messageType,
  });

  factory ChatMessageModel.fromJson(
          Map<String, dynamic> json, String documentId) =>
      ChatMessageModel(
        hasResponded: json['hasResponded'],
        id: documentId,
        timeslot: json['timeslot']?.toDate(),
        isAccepted: json['isAccepted'],
        unit: json['unit'],
        pricePerUnit: json['pricePerUnit'],
        receiverId: json['receiverId'],
        senderId: json['senderId'],
        sentTime: json['sentTime'].toDate(),
        content: json['content'],
        messageType: MessageType.fromJson(json['messageType']),
      );

  Map<String, dynamic> toJson() => {
        'hasResponded': hasResponded,
        'timeslot': timeslot,
        'isAccepted': isAccepted,
        'unit': unit,
        'pricePerUnit': pricePerUnit,
        'receiverId': receiverId,
        'senderId': senderId,
        'sentTime': sentTime,
        'content': content,
        'messageType': messageType.toJson(),
      };

  @override
  String toString() {
    return 'ChatMessageModel(senderId: $senderId, receiverId: $receiverId, content: $content, sentTime: $sentTime, messageType: $messageType, timeslot: $timeslot, isAccepted: $isAccepted, unit: $unit, pricePerUnit: $pricePerUnit)';
  }
}

enum MessageType {
  booking,
  text,
  image;

  String toJson() => name;

  factory MessageType.fromJson(String json) => values.byName(json);
}
