import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:websockets_with_getx/controllers/chat_controller.dart';
import 'package:websockets_with_getx/widgets/message_input_field.dart';
import 'package:websockets_with_getx/widgets/other_message_bubble.dart';
import 'package:websockets_with_getx/widgets/own_message_bubble.dart';
import 'package:websockets_with_getx/widgets/shimmer_loading_chat.dart';

class ChatView extends GetView<ChatController> {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Chat Screen',
          style: TextStyle(color: Colors.white), // Title style
        ),
        centerTitle: true, // Centers the title
        backgroundColor: Colors.blue, // AppBar background color
      ),
      body: Obx(() => Stack(
        children: [
          SafeArea(
            child: !controller.socketService.isInitialMessagesFetched.value
            // Show loading animation while initial messages are being fetched
                ? const ShimmerLoadingChat()
                : ListView.builder(
              controller: controller.scrollController,
              itemCount: controller.chatMessages.length,
              padding: const EdgeInsets.only(top: 16),
              itemBuilder: (context, index) {
                final message = controller.chatMessages[index];
                final isOwnMessage =
                    message.userId == controller.currentUser.userId; // Check if the message is sent by the current user

                return Padding(
                  padding: const EdgeInsets.only(
                      bottom: 24, left: 12, right: 12),
                  child: isOwnMessage
                      ? OwnMessageBubble(message: message) // Display user's own message
                      : OtherMessageBubble(message: message), // Display message from others
                );
              },
            ).marginOnly(top: 16),
          ),
        ],
      )),
      // Bottom navigation bar for message input
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  /// Builds the bottom navigation bar containing the message input field.
  Widget _buildBottomNavigationBar(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: MediaQuery.of(context).viewInsets, // Adjusts padding for the keyboard
        child: MessageInputField(
          sendMessageCallback: controller.sendMessage, // Callback to send a message
          messageController: controller.messageController, // Controller for the message input field
        ),
      ),
    );
  }
}