
import 'package:websockets_with_getx/models/parents/model.dart';

class Message extends Model {
  int? id;
  int? userId;
  String? userName;
  String? companyName;
  String? userAvatar;
  String? image;
  int? roomId;
  String? roomName;
  String? message;
  DateTime? timeStamp;

  Message({
    this.id,
    this.userId,
    this.userName,
    this.companyName,
    this.userAvatar,
    this.roomId,
    this.roomName,
    this.message,
    this.timeStamp,
    this.image,
  });

  factory Message.fromJson(Map<String, dynamic> json,
      {bool isFromChatModel = false}) {
    return Message(
      id: Model.intFromJson(json, 'messageId'),
      userId: Model.intFromJson(json, 'userId'),
      userName: Model.stringFromJson(json, 'name'),
      companyName: Model.stringFromJson(json, 'companyName'),
      userAvatar: Model.stringFromJson(json, 'userLogo'),
      roomId: Model.intFromJson(json, 'roomId'),
      roomName: Model.stringFromJson(json, 'roomName'),
      message: Model.stringFromJson(json, 'message'),
      image: Model.stringFromJson(json, 'img'),
      timeStamp: isFromChatModel
          ? Model.dateFromJson(json, 'createdAt')
          : Model.dateFromJson(json, 'timeStamp'),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'messageId': id,
      'userId': userId,
      'name': userName,
      'companyName': companyName,
      'userLogo': userAvatar,
      'roomId': roomId,
      'roomName': roomName,
      'img': image,
      'message': message,
      'timeStamp': timeStamp?.toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'Message(userId: $userId, roomId: $roomId, userName: $userName, roomName: $roomName, message: $message, timeStamp: $timeStamp, img: $image)';
  }
}
