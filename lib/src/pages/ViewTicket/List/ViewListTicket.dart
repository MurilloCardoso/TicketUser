import 'package:flutter/material.dart';
import 'package:taskuse/src/DB/models/chamados.dart';
import 'package:taskuse/src/DB/provider/ManagerCache.dart';
import 'package:provider/provider.dart';
import 'package:taskuse/src/pages/ViewTicket/onlyView/ViewTicket.dart';
import 'package:taskuse/src/utils/ColorPallete.dart';

class ViewListTicket extends StatefulWidget {
  const ViewListTicket({super.key});

  @override
  State<ViewListTicket> createState() => _ViewListTicketState();
}

class _ViewListTicketState extends State<ViewListTicket> {
  String dropdownValue = "All";
  List<String> items = [
    "All",
    "Pendent",
    "Processing",
    "Concluded",
    "Inconclusive"
  ];
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
            SizedBox(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      child: DropdownButton<String>(
                        underline: Container(
                          height: 0,
                          width: 0,
                        ),
                        icon: Icon(Icons.filter_list),
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                        value: dropdownValue,
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownValue = newValue!;
                          });
                        },
                        items: items
                            .map<DropdownMenuItem<String>>(
                                (String value) => DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    ))
                            .toList(),
                      ),
                    )
                  ]),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: listaTicket.length,
                itemBuilder: (context, index) {
                  Color color = Colors.grey;
                  IconData? icone = Icons.abc;
                  if (listaTicket[index].status == "Pendent") {
                    color = ColorsPalette.yellow;
                    icone = Icons.timer;
                  } else {
                    if (listaTicket[index].status == "Processing") {
                      icone = Icons.work_history_rounded;
                      color = ColorsPalette.blue;
                    } else if (listaTicket[index].status == "Concluded") {
                      color = ColorsPalette.green;
                      icone = Icons.done_outlined;
                    } else {
                      icone = Icons.do_not_disturb_on;
                      color = const Color.fromARGB(255, 235, 126, 126);
                    }
                  }
                  return dropdownValue == "All" ||
                          (dropdownValue == listaTicket[index].status)
                      ? Column(
                          children: [
                            Container(
                              color: Colors.white,
                              child: ListTile(
                                leading: Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      color: color,
                                      borderRadius: BorderRadius.circular(10)),
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
                                  listaTicket[index].status,
                                  style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                                subtitle: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      listaTicket[index].title,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      listaTicket[index].problemItem,
                                      style: const TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                      : SizedBox.shrink();
                },
              ),
            )
          ],
        )));
  }
}
