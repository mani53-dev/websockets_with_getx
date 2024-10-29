import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:websockets_with_getx/controllers/chat_controller.dart';
import 'package:websockets_with_getx/services/socket_service.dart';
import 'package:websockets_with_getx/views/chat_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(SocketService().init());
  Get.put(ChatController());
    runApp(
      const GetMaterialApp(
        title: 'Websockets with GetX',
        debugShowCheckedModeBanner: false,
        defaultTransition: Transition.cupertino,
        home: ChatView(),

      ),
    );
}

