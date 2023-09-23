import 'package:flutter/material.dart';
import 'package:flutter/src/scheduler/ticker.dart';
import 'package:taskuse/src/DB/models/ChatUser.dart';
import 'package:taskuse/src/DB/models/chamados.dart';
import 'package:provider/provider.dart';
import 'package:taskuse/src/DB/provider/ManagerCache.dart';
import 'package:taskuse/src/pages/ViewTicket/ViewTicket.dart';
import 'package:taskuse/src/pages/createTicket/CreateTicket.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    List<Ticket> listaTicket = context.watch<ManagerCache>().GetTicketCache();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("HOME"),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width * 1,
              child: Column(
                children: [
                  const Text(
                    'Bem-vindo',
                  ),
                  Text(
                    'Todal de Chamados: ' + listaTicket.length.toString(),
                  ),
                  ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CreateTicketPage()),
                        );
                      },
                      icon: Icon(Icons.call_to_action_rounded),
                      label: Text("Abrir Chamado")),
                ],
              ),
            ),
            Divider(),
            Expanded(
              child: listaTicket.isEmpty
                  ? Center(
                      child: Opacity(
                        opacity: 0.7,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: SvgPicture.asset(
                            "assets/imgs/svg/undraw_no_data_re_kwbl.svg",
                            semanticsLabel: 'Acme Logo',
                          ),
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: listaTicket.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          color: listaTicket[index].status == "pendent"
                              ? Colors.green[100]
                              : Colors.yellow[100],
                          child: ListTile(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ViewTicket(
                                          ticket: listaTicket[index],
                                        )),
                              );
                            },
                            title: Text(listaTicket[index].title),
                            subtitle: Text(listaTicket[index].status),
                          ),
                        );
                      },
                    ),
            )
          ],
        ),
      ),
    );
  }
}
