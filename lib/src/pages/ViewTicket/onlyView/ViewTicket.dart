import 'package:flutter/material.dart';
import 'package:taskuse/src/DB/models/ChatUser.dart';
import 'package:taskuse/src/DB/models/chamados.dart';
import 'package:taskuse/src/DB/provider/ManagerCache.dart';
import 'package:taskuse/src/utils/ColorPallete.dart';
import 'package:provider/provider.dart';

class ViewTicket extends StatefulWidget {
  ViewTicket({super.key, required this.ticket});
  Ticket ticket;
  @override
  State<ViewTicket> createState() => _ViewTicketState();
}

class _ViewTicketState extends State<ViewTicket> {
  @override
  Widget build(BuildContext context) {
    ChatUser user = context.watch<ManagerCache>().GetUserCache();
    void enviarMensagem() {}
    return Scaffold(
      appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: ColorsPalette.orangeMedium,
          actions: []),
      body: SafeArea(
          child: SingleChildScrollView(
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
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
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
                        child: ListTile(
                          leading: CircleAvatar(
                              child: Icon(
                            Icons.analytics_outlined,
                            color: Colors.white,
                          )),
                          title: Text(widget.ticket.status),
                          subtitle:
                              Text("Aguarde a resposta de um responsável "),
                          trailing: Icon(
                            Icons.info,
                            color: Colors.grey,
                          ),
                          isThreeLine: true,
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 1,
                        child: ListView.builder(
                          reverse: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: widget.ticket.message.length,
                          itemBuilder: (context, index) {
                            var message = widget.ticket.message[index];
                            var isUsuarioLogado = message.speaker.id == user.id;

                            // Define a margem e a cor de fundo com base no remetente da mensagem
                            var margin = isUsuarioLogado
                                ? EdgeInsets.only(top: 10, left: 70)
                                : EdgeInsets.only(top: 10, right: 70);
                            var backgroundColor = isUsuarioLogado
                                ? const Color.fromARGB(255, 140, 203, 255)
                                : Colors.white;

                            return Container(
                              margin: margin,
                              decoration: BoxDecoration(
                                  boxShadow: const [
                                    BoxShadow(
                                        blurRadius: 2,
                                        blurStyle: BlurStyle.outer,
                                        offset: Offset(1, 1),
                                        color: Colors.grey)
                                  ],
                                  color: backgroundColor,
                                  borderRadius: BorderRadius.circular(25)),
                              child: ListTile(
                                leading: const CircleAvatar(
                                    child: Icon(
                                  Icons.person,
                                  color: Colors.white,
                                )),
                                title: Text(
                                    widget.ticket.message[index].speaker.name),
                                subtitle: Text(message.message.toString(),
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600)),
                                isThreeLine: true,
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              key: const ValueKey('name'),
                              onChanged: (name) => () {},
                              decoration: InputDecoration(
                                  filled: true,
                                 suffix: TextButton(onPressed: (){}, child:Text("Send",style: TextStyle(color: ColorsPalette.orangeMedium,fontSize: 18),)),
                                  hintText: 'Message',
                                  fillColor: Color.fromARGB(255, 229, 229, 229),
                                  contentPadding: const EdgeInsets.fromLTRB(
                                      20.0, 10.0, 20.0, 10.0),
                                  ),
                            ),
                          ),
                       
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
