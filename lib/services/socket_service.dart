import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:socket_io_client/socket_io_client.dart';
import 'package:websockets_with_getx/models/message.dart';

/// SocketService handles all WebSocket connections and communication
/// between the client and server, facilitating real-time messaging.
class SocketService extends GetxService {
  late io.Socket socket; // WebSocket client instance
  final RxBool isErrorSendingMessage = false.obs; // Reactive boolean for message sending errors
  final RxBool isErrorJoiningChat = false.obs; // Reactive boolean for chat joining errors
  final RxBool isMessageSent = false.obs; // Reactive boolean for message sent status
  final RxBool isInitialMessagesFetched = false.obs; // Reactive boolean for initial messages fetch status
  final RxInt roomId = 0.obs; // Reactive integer to track current room ID

  Message sentMessage = Message(); // Stores the last sent message
  RxList<Message> initialMessages = <Message>[].obs; // List of initial messages

  /// Initializes the socket service and connects to the server.
  SocketService init() {
    connectToServer(serverUrl: "Add your server address here"); // Specify your server URL here
    return this;
  }

  /// Connects to the WebSocket server using the provided URL.
  void connectToServer({required String serverUrl}) {
    socket = io.io(
      serverUrl,
    );
    socket.connect(); // Establishes connection to the server

    _registerListeners(); // Registers event listeners for WebSocket messages
  }

  /// Registers event listeners to handle incoming WebSocket events.
  void _registerListeners() {
    // Listener for initial messages from the server
    socket.on('initialMessages', (messages) {
      initialMessages.clear(); // Clears any existing messages
      for (var message in messages) {
        initialMessages.add(Message.fromJson(message)); // Adds new messages to the list
      }
      isInitialMessagesFetched.value = true; // Marks that initial messages have been fetched
    });

    // Listener for when a user joins a private chat room
    socket.on('privateUserJoined', (data) {
      roomId.value = data['roomId']; // Updates the current room ID
    });

    // Listener for receiving a new private message
    socket.on('P_Message', (data) {
      sentMessage = Message.fromJson(data); // Converts the data to a Message object
      initialMessages.add(sentMessage); // Adds the new message to the list
      roomId.value = data['roomId']; // Updates the room ID
    });

    // Listener for errors when sending messages
    socket.on('sendPMessageError', (error) {
      Get.log('Send message error: $error'); // Logs the error
      isErrorSendingMessage.value = true; // Sets the error state
    });

    // Listener for errors when trying to join a room
    socket.on('joinP_RoomError', (error) {
      Get.log('There is an error joining this room: $error'); // Logs the error
    });

    // Listener for when a user leaves a private room
    socket.on('leavePrivateRoom', (error) {
      Get.log('UserLeft: $error'); // Logs the user left event
    });

    // Listener for errors when trying to leave a room
    socket.on('leavePrivateRoomError', (error) {
      Get.log('Error Leaving room: $error'); // Logs the error
    });
  }

  /// Checks if a private room exists between two users by emitting an event.
  void isPrivateRoomExists({
    required int userId,
    required int toUserId,
  }) {
    socket.emit('isP_RoomExist', {
      'userId': userId,
      'toUserId': toUserId,
    }); // Sends an event to check room existence
  }

  /// Sends a private message to the server.
  void sendMessage({
    required int userId,
    required int toUserId,
    required int? roomId,
    required String message,
  }) {
    socket.emit('sendPMessage', {
      'userId': userId,
      'toUserId': toUserId,
      'message': message, // The message to be sent
      if (roomId != null) 'roomId': roomId, // Optional room ID
    });
  }

  /// Sends an event to leave a private chat room.
  void leaveRoom(int roomId, int userId) {
    socket.emit('leavePrivateRoom', {
      'roomId': roomId,
      'userId': userId,
    });
  }

  /// Disconnects the socket and clears all listeners.
  void disconnect() {
    socket.clearListeners(); // Removes all listeners for the socket
    socket.disconnect(); // Disconnects from the server
  }
}