import 'package:flutter/material.dart';
import 'package:taskuse/src/DB/models/chamados.dart';
import 'package:taskuse/src/DB/provider/ManagerCache.dart';
import 'package:taskuse/src/pages/ViewTicket/onlyView/ViewTicket.dart';
import 'package:taskuse/src/utils/ColorPallete.dart';
import 'package:provider/provider.dart';

class ViewListTicket extends StatefulWidget {
  const ViewListTicket({super.key});

  @override
  State<ViewListTicket> createState() => _ViewListTicketState();
}

class _ViewListTicketState extends State<ViewListTicket> {
  @override
  Widget build(BuildContext context) {
    List<Ticket> listaTicket = context.watch<ManagerCache>().GetTicketCache();
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: ColorsPalette.orangeMedium,
      ),
      body: SafeArea(
          child: Column(
        children: [
          Container(
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                  color: const Color.fromARGB(255, 126, 121, 121),
                  blurRadius: 0.2,
                  offset: Offset(1, 1),
                  blurStyle: BlurStyle.outer,
                )
              ]),
              child: ListTile(
                leading: Icon(Icons.filter_alt_rounded),
                title: Text("Filtrar Lista"),
              )),
          Expanded(
            child: ListView.builder(
              itemCount: listaTicket.length,
              itemBuilder: (context, index) {
                Color color = Colors.grey;
                IconData? icone = Icons.abc;
                if (listaTicket[index].status == "Pendent") {
                  color = Color.fromARGB(255, 237, 200, 98);
                  icone = Icons.timer;
                } else {
                  if (listaTicket[index].status == "Processing") {
                    icone = Icons.work_history_rounded;
                    color = const Color.fromARGB(255, 82, 86, 163);
                  } else if (listaTicket[index].status == "Concluded") {
                    color = Color.fromARGB(255, 96, 188, 136);
                    icone = Icons.done_outlined;
                  } else {
                    icone = Icons.do_not_disturb_on;
                    color = Color.fromARGB(255, 224, 98, 98);
                  }
                }
                return Column(
                  children: [
                    Divider(
                      height: 0,
                      color: const Color.fromARGB(31, 109, 109, 109),
                    ),
                    Container(
                      color: Colors.white,
                      child: ListTile(
                        trailing: const Icon(
                          Icons.arrow_right_sharp,
                          color: ColorsPalette.orangeMedium,
                        ),
                        leading: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: color,
                              borderRadius: BorderRadius.circular(10)),
                          child: Icon(
                            icone,
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                  blurRadius: 1.0,
                                  color: Colors.grey,
                                  offset: Offset(1, 2))
                            ],
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
                        subtitle: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              listaTicket[index].title,
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 64, 63, 63),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              "Item: " + listaTicket[index].problemItem,
                              style:
                                  const TextStyle(fontWeight: FontWeight.w600),
                            ),
                            Container(
                                child: Text("Ultima mensagem: " + "Hello ")),
                          ],
                        ),
                        title: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              listaTicket[index].status,
                              style: const TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          )
        ],
      )),
    );
  }
}
