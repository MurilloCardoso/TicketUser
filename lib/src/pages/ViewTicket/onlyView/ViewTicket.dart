import 'package:flutter/material.dart';
import 'package:taskuse/src/DB/models/ChatUser.dart';
import 'package:taskuse/src/DB/models/chamados.dart';
import 'package:taskuse/src/DB/models/message.dart';
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
    final _formKey = GlobalKey<FormState>();
    String textMessage = "";
    ChatUser user = context.watch<ManagerCache>().GetUserCache();
    Color color = Colors.grey;
    IconData? icone = Icons.abc;
    if (widget.ticket.status == "Pendent") {
      color = Color.fromARGB(255, 237, 200, 98);
      icone = Icons.timer;
    } else {
      if (widget.ticket.status == "Processing") {
        icone = Icons.work_history_rounded;
        color = const Color.fromARGB(255, 82, 86, 163);
      } else if (widget.ticket.status == "Concluded") {
        color = Color.fromARGB(255, 96, 188, 136);
        icone = Icons.done_outlined;
      } else {
        icone = Icons.do_not_disturb_on;
        color = Color.fromARGB(255, 224, 98, 98);
      }
    }

    return Scaffold(
      backgroundColor: ColorsPalette.smoke,
      appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: color,
          actions: []),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.white,
              child: ListTile(
                leading: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: color, borderRadius: BorderRadius.circular(10)),
                  child: Icon(
                    icone,
                    color: Colors.white,
                    shadows: const [
                      Shadow(
                          blurRadius: 1.0,
                          color: Colors.grey,
                          offset: Offset(1, 2))
                    ],
                  ),
                ),
                title: Text(
                  widget.ticket.title,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w500),
                ),
                subtitle: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Divider(),
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
            ),
            SizedBox(
              child: Container(
                width: MediaQuery.of(context).size.width * 1,
                color: ColorsPalette.smoke,
                child: Container(
                  margin: const EdgeInsets.all(15),
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
                              backgroundColor: color,
                              child: const Icon(
                                Icons.analytics_outlined,
                                color: Colors.white,
                              )),
                          title: Text(widget.ticket.status),
                          subtitle: const Text(
                              "Aguarde a resposta de um responsável "),
                          trailing: const Icon(
                            Icons.info,
                            color: Colors.grey,
                          ),
                          isThreeLine: true,
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: widget.ticket.message.length,
                        itemBuilder: (context, index) {
                          var message = widget.ticket.message[index];
                          var isUsuarioLogado = message.speaker.id == user.id;

                          // Define a margem e a cor de fundo com base no remetente da mensagem
                          var margin = isUsuarioLogado
                              ? const EdgeInsets.only(top: 10, left: 70)
                              : const EdgeInsets.only(top: 10, right: 70);
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
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600)),
                              isThreeLine: true,
                            ),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      )),
      persistentFooterButtons: [
        Form(
          key: _formKey,
          child: Container(
            color: Colors.grey[200], // Cor de fundo da barra de navegação
            padding: EdgeInsets.only(bottom: 2, top: 2, left: 2),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    key: const ValueKey('message'),
                    onChanged: (name) => textMessage = name,
                    decoration: const InputDecoration(
                      hintText: 'Digite sua mensagem...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  color: ColorsPalette.orangeMedium,
                  icon: Icon(Icons.send),
                  onPressed: () {
                    if (textMessage.isNotEmpty) {
                      setState(() {
                        widget.ticket.message.add(Message(
                            id: widget.ticket.message.length,
                            speaker: user,
                            message: textMessage.toString()));
                      });
                      textMessage = "";
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}



















































