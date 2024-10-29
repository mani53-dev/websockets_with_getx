// * Created by Affine Sol (PVT LTD) on 03/09/2024
// *
// * Website: https://affinesol.com/
// * Email: affinesol@gmail.com
// * Find our services on: https://www.fiverr.com/rehman_777


import 'package:get/get.dart';
import 'package:websockets_with_getx/controllers/chat_controller.dart';

class MessagesBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChatController>(
          () => ChatController(),
    );
  }
}