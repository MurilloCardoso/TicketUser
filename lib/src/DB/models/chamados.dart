
class Ticket {
   int? id;
   String title;
   String problemDescription;
   String problemItem;
   String status;
   Ticket({
      this.id,
    required this. title,
    required this.problemDescription,
    required this.problemItem,
    required this.status,
  });
}