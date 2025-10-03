import 'package:flutter/material.dart';
import '../../domain/entities/chat_entities.dart';
import '../../domain/usecases/chat/create_room_chat.dart';
import '../../domain/usecases/chat/get_rooms_chat.dart';
import '../../domain/usecases/chat/get_recent_chat.dart';
import '../../domain/usecases/chat/get_room_messages.dart';
import '../../domain/usecases/chat/post_message_chat.dart';

class ChatProvider extends ChangeNotifier {
  final CreateRoomChat createRoomChatUsecase;
  final GetRoomsChat getRoomsChatUsecase;
  final GetRecentChat getRecentChatUsecase;
  final GetRoomMessages getRoomMessagesUsecase;
  final PostMessageChat postMessageChatUsecase;

  List<RoomChatEntity> rooms = [];
  List<RecentChatEntity> recentChats = [];
  List<MessageChatEntity> messages = [];
  RoomChatEntity? createdRoom;
  MessageChatEntity? sentMessage;
  bool isLoading = false;
  String? error;

  ChatProvider({
    required this.createRoomChatUsecase,
    required this.getRoomsChatUsecase,
    required this.getRecentChatUsecase,
    required this.getRoomMessagesUsecase,
    required this.postMessageChatUsecase,
  });

  Future<void> createRoom({
    required String token,
    required String category,
    required bool visible,
    required String targetId,
  }) async {
    isLoading = true;
    error = null;
    notifyListeners();
    try {
      createdRoom = await createRoomChatUsecase(
        token: token,
        category: category,
        visible: visible,
        targetId: targetId,
      );
      error = null;
    } catch (e) {
      error = e.toString();
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> fetchRooms({required String token}) async {
    isLoading = true;
    error = null;
    notifyListeners();
    try {
      rooms = await getRoomsChatUsecase(token: token);
      error = null;
    } catch (e) {
      error = e.toString();
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> fetchRecentChats({required String token}) async {
    isLoading = true;
    error = null;
    notifyListeners();
    try {
      recentChats = await getRecentChatUsecase(token: token);
      error = null;
    } catch (e) {
      error = e.toString();
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> fetchRoomMessages({
    required String token,
    required String roomId,
  }) async {
    isLoading = true;
    error = null;
    notifyListeners();
    try {
      messages = await getRoomMessagesUsecase(token: token, roomId: roomId);
      error = null;
    } catch (e) {
      error = e.toString();
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> sendMessage({
    required String token,
    required String roomId,
    required String text,
  }) async {
    isLoading = true;
    error = null;
    notifyListeners();
    try {
      sentMessage = await postMessageChatUsecase(
        token: token,
        roomId: roomId,
        text: text,
      );
      error = null;
    } catch (e) {
      error = e.toString();
    }
    isLoading = false;
    notifyListeners();
  }
}
