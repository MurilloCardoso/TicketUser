import 'package:taskuse/src/DB/models/ChatUser.dart';

class Message {
  int? id;
  ChatUser speaker;
  String message;
  Message({
    this.id,
    required this.speaker,
    required this.message,
  });
}
