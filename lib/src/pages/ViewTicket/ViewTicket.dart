import 'package:flutter/material.dart';
import 'package:taskuse/src/DB/models/chamados.dart';
import 'package:taskuse/src/utils/ColorPallete.dart';

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
      appBar: AppBar(backgroundColor: ColorsPalette.orangeMedium, actions: []),
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          ListTile(
            leading: Column(
              children: [
                const CircleAvatar(
                    child: Icon(
                  Icons.timer,
                  color: Colors.white,
                )),
                Text(
                  widget.ticket.status.toUpperCase(),
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
            title: Text(
              widget.ticket.title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            subtitle: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(),
                Column(
                  children: [
                    Text(
                      "Item:",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    Text(widget.ticket.problemItem),
                  ],
                ),
                Divider(),
                Text(
                  "Descrição:",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                Text(widget.ticket.problemDescription),
              ],
            ),
            isThreeLine: true,
          ),
          Expanded(
              child: Container(
                  width: MediaQuery.of(context).size.width * 1,
                  color: ColorsPalette.smoke,
                  child: Container(
                      margin: EdgeInsets.all(15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(25)),
                            child: ListTile(
                              leading: CircleAvatar(
                                  child: Icon(
                                Icons.analytics_outlined,
                                color: Colors.white,
                              )),
                              title: Text('Esperando análise'),
                              subtitle:
                                  Text("Aguarde a resposta de um responsável "),
                              trailing: Icon(
                                Icons.info,
                                color: Colors.grey,
                              ),
                              isThreeLine: true,
                            ),
                          ),
                        ],
                      )))),
        ],
      )),
    );
  }
}
