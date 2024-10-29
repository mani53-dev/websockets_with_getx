import 'package:websockets_with_getx/models/message.dart';

import 'parents/model.dart';

class PrivateChatModel extends Model {
  int? id;
  int? unreadCount;
  String? title;
  DateTime? createdAt;
  List<Message>? privateMessages;

  PrivateChatModel({
    this.id,
    this.title,
    this.createdAt,
    this.unreadCount,
    this.privateMessages,
  });

  factory PrivateChatModel.fromJson(Map<String, dynamic> json) {
    return PrivateChatModel(
      id: Model.intFromJson(json, 'id'),
      unreadCount: Model.intFromJson(json, 'unreadCount'),
      title: Model.stringFromJson(json, 'title'),
      createdAt: Model.dateFromJson(json, 'createdAt'),
      privateMessages: Model.listFromJson(json, 'privateMessages',
          (message) => Message.fromJson(message, isFromChatModel: true)),
    );
  }
}
