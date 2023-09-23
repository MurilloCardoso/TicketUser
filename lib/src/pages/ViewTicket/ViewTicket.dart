import 'package:flutter/material.dart';
import 'package:taskuse/src/DB/models/chamados.dart';

class ViewTicket extends StatefulWidget {
  ViewTicket({super.key, required this.ticket});
  Ticket ticket;
  @override
  State<ViewTicket> createState() => _ViewTicketState();
}

class _ViewTicketState extends State<ViewTicket> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: []),
      body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.ticket.title),
          Text(widget.ticket.problemItem),
          Text(widget.ticket.problemDescription),
          Text(widget.ticket.status,style: TextStyle(color: Colors.green),),
        ],
      )),
    );
  }
}
