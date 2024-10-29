import 'package:get/get.dart';
import 'package:websockets_with_getx/models/parents/model.dart';

class User extends Model {
  int? userId;
  String? userName;
  bool? isFirstTimeLogin;
  String? firstName;
  String? lastName;
  String? avatarURL;

  User({
    this.userId,
    this.userName,
    this.isFirstTimeLogin = false,
    this.avatarURL,
  });
}
