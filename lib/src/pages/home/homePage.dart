import 'package:flutter/material.dart';
import 'package:flutter/src/scheduler/ticker.dart';
import 'package:taskuse/src/DB/models/ChatUser.dart';
import 'package:taskuse/src/DB/models/chamados.dart';
import 'package:provider/provider.dart';
import 'package:taskuse/src/DB/provider/ManagerCache.dart';
import 'package:taskuse/src/pages/ViewTicket/ViewTicket.dart';
import 'package:taskuse/src/pages/createTicket/CreateTicket.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:taskuse/src/utils/ColorPallete.dart';

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
              padding: EdgeInsets.symmetric(vertical: 10),
              width: MediaQuery.of(context).size.width * 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Bem-vindo',
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(
                          'Todal de Chamados: ' + listaTicket.length.toString(),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton.icon(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            CreateTicketPage()),
                                  );
                                },
                                icon: Icon(Icons.call_to_action_rounded),
                                label: Text("Abrir Chamado")),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              height: 0,
            ),
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
                        Color color = Colors.grey;
                        if (listaTicket[index].status == "pendent") {
                          color = ColorsPalette.yellow;
                        } else {
                          if (listaTicket[index].status == "processing") {
                            color = ColorsPalette.blue;
                          } else if (listaTicket[index].status == "concluded") {
                            color = ColorsPalette.green;
                          } else {
                            color = const Color.fromARGB(255, 235, 126, 126);
                          }
                        }

                        return Column(
                          children: [
                            Container(
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: color,
                                  child: Icon(
                                    color: Colors.white,
                                    Icons.timer,
                                  ),
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ViewTicket(
                                              ticket: listaTicket[index],
                                            )),
                                  );
                                },
                                title: Text(
                                  listaTicket[index].title,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400),
                                ),
                                subtitle: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      listaTicket[index].status.toUpperCase(),
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w800),
                                    ),
                                    Text(
                                      listaTicket[index].problemDescription,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Divider(
                              height: 0,
                            ),
                          ],
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
