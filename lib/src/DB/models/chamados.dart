
import 'package:taskuse/src/DB/models/message.dart';

class Ticket {
   int? id;
   String title;
   String problemDescription;
   String problemItem;
   String status;
   List<Message> message;
   Ticket({
      this.id,
    required this. title,
    required this.problemDescription,
    required this.problemItem,
    required this.status,
    required this.message,
  });
}