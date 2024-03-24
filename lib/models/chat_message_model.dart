// ignore_for_file: public_member_api_docs, sort_constructors_first
class ChatMessageModel {
  final String senderId;
  final String receiverId;
  final String content;
  final DateTime sentTime;
  final MessageType messageType;

  const ChatMessageModel({
    required this.senderId,
    required this.receiverId,
    required this.sentTime,
    required this.content,
    required this.messageType,
  });

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) =>
      ChatMessageModel(
        receiverId: json['receiverId'],
        senderId: json['senderId'],
        sentTime: json['sentTime'].toDate(),
        content: json['content'],
        messageType:
            MessageType.fromJson(json['messageType']),
      );

  Map<String, dynamic> toJson() => {
        'receiverId': receiverId,
        'senderId': senderId,
        'sentTime': sentTime,
        'content': content,
        'messageType': messageType.toJson(),
      };

  @override
  String toString() {
    return 'ChatMessageModel(senderId: $senderId, receiverId: $receiverId, content: $content, sentTime: $sentTime, messageType: $messageType)';
  }
}

enum MessageType {
  text,
  image;

  String toJson() => name;

  factory MessageType.fromJson(String json) =>
      values.byName(json);
}
