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
      appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: ColorsPalette.orangeMedium,
          actions: []),
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
                CircleAvatar(
                    child: Icon(
                  Icons.timer,
                  color: Colors.white,
                )),
                Text(
                  widget.ticket.status.toUpperCase(),
                  style: const TextStyle(
                    color: Colors.grey,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            title: Text(
              widget.ticket.title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            subtitle: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Item:",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    Text(widget.ticket.problemItem),
                  ],
                ),
                const Divider(),
                const Text(
                  "Descrição:",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                Text(widget.ticket.problemDescription),
              ],
            ),
            isThreeLine: true,
          ),
          Container(
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
                      child: const ListTile(
                        leading: CircleAvatar(
                            child: Icon(
                          Icons.analytics_outlined,
                          color: Colors.white,
                        )),
                        title: Text('Esperando análise'),
                        subtitle: Text("Aguarde a resposta de um responsável "),
                        trailing: Icon(
                          Icons.info,
                          color: Colors.grey,
                        ),
                        isThreeLine: true,
                      ),
                    ),
                    ListView.builder(
                      itemCount: widget.ticket.message.length,
                      itemBuilder: (context, index) {
                        return ListTile(
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
                        );
                      },
                    ),
                    TextField()
                  ],
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
