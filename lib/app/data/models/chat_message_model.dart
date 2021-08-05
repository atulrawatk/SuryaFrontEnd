class ChatMessageModel {
  bool isMe;
  bool isGroup;
  String name;
  String message;
  String messageType;
  String time;
  String messageSeen;
  ChatMessageModel? repliedMessage;
  ChatMessageModel(
      {required this.name,
      required this.isGroup,
      required this.isMe,
      required this.message,
      required this.messageType,
      required this.time,
      required this.messageSeen,
       this.repliedMessage
      });

}
