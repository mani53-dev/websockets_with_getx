import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:websockets_with_getx/models/message.dart';
import 'package:websockets_with_getx/models/private_chat_model.dart';
import 'package:websockets_with_getx/models/user_model.dart';
import 'package:websockets_with_getx/services/socket_service.dart';

/// Controller for managing chat functionalities, including
/// message sending, receiving, and error handling.
class ChatController extends GetxController {

  // The current user involved in the chat
  final User currentUser = User();

  // Controller for scrolling the chat view
  final ScrollController scrollController = ScrollController();

  // Reactive boolean to confirm if initial messages are fetched
  final isInitialMessagesFetched = false.obs;

  // List of chat messages displayed in the UI
  final chatMessages = <Message>[].obs;

  // Controller for the message input field
  final TextEditingController messageController = TextEditingController();

  // Reference to socket service for WebSocket handling
  final socketService = Get.find<SocketService>();

  // Model to track the currently selected private chat
  PrivateChatModel selectedChat = PrivateChatModel();

  @override
  void onInit() async {
    super.onInit();
    _initializeSocketListeners();
    _isChatRoomExists();
  }

  /// Checks if a private chat room exists between the current user
  /// and another specified user.
  void _isChatRoomExists() {
    socketService.isPrivateRoomExists(
      userId: 1, // Enter the current user ID here
      toUserId: 2, // Enter the other user ID here
    );
  }

  /// Sets up WebSocket listeners to handle incoming messages
  /// and various chat events like errors and message fetch status.
  void _initializeSocketListeners() {
    // Listen to the initial messages from the server and load them into chatMessages
    socketService.initialMessages.listen((initialMessages) async {
      chatMessages.assignAll(initialMessages);
      // Automatically scrolls to the bottom after messages are loaded
      _scrollToBottom();
    });

    // Listen to the event indicating if initial messages were fetched successfully
    socketService.isInitialMessagesFetched.listen(_handleInitialMessagesFetch);

    // Listen for errors related to joining the chat
    socketService.isErrorJoiningChat.listen(_handleJoinChatError);

    // Listen for errors related to sending messages
    socketService.isErrorSendingMessage.listen(_handleSendMessageError);
  }

  /// Callback to handle actions upon successful fetching of initial messages.
  /// Marks unread messages as read if necessary.
  void _handleInitialMessagesFetch(bool isFetched) async {
    if (isFetched && selectedChat.unreadCount != null && selectedChat.unreadCount! > 0) {
      // Placeholder for marking messages as read
      // await nodeApiClient.readMessages(currentUser, chatMessages.last.id!);
    }
  }

  /// Handles errors when joining a chat room.
  /// Displays an error message and resets the error state.
  void _handleJoinChatError(bool isError) {
    if (isError) {
      // Uncomment the below line to display error message
      // Get.showSnackbar(Ui.ErrorSnackBar(message: 'error-joining-chat'.tr));
      socketService.isErrorJoiningChat.value = false;
    }
  }

  /// Handles errors occurring during message sending.
  /// Displays an error message and resets the error state.
  void _handleSendMessageError(bool isError) {
    if (isError) {
      // Uncomment the below line to display error message
      // Get.showSnackbar(Ui.ErrorSnackBar(message: "error-sending-message".tr));
      socketService.isErrorSendingMessage.value = false;
    }
  }

  /// Sends a message to the server. If the message input is empty,
  /// it returns early. Clears the message field and scrolls the chat view.
  void sendMessage() async {
    final messageText = messageController.text.trim();
    if (messageText.isEmpty) return;

    // Sends the message through socket service
    socketService.sendMessage(
      userId: 1,
      toUserId: 1,
      message: messageText,
      roomId: 1,
    );

    // Clears the message input field and scrolls to the bottom
    messageController.clear();
    _scrollToBottom(shouldAnimate: true);
  }

  /// Scrolls to the bottom of the chat view.
  /// Optionally animates the scroll if specified.
  void _scrollToBottom({bool shouldAnimate = false}) {
    if (scrollController.hasClients) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final double position = scrollController.position.maxScrollExtent;
        if (shouldAnimate) {
          // Checks if the user is not scrolling, then animates
          if (scrollController.position.userScrollDirection ==
              ScrollDirection.idle) {
            scrollController.animateTo(
              position,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          }
        } else {
          scrollController.jumpTo(position);
        }
      });
    }
  }

  /// Releases resources when the controller is closed.
  /// Cleans up controllers, leaves the chat room, and clears data.
  void _cleanUpResources() {
    messageController.dispose();
    scrollController.dispose();
    socketService.leaveRoom(
      selectedChat.id!,
      currentUser.userId!,
    );
    socketService.isInitialMessagesFetched.value = false;
    selectedChat = PrivateChatModel();
    chatMessages.clear();
  }

  @override
  void onClose() {
    _cleanUpResources();
    super.onClose();
  }
}