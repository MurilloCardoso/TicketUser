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
  String searchField = '';
  String textField = '';
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    textEditingController.addListener(() {
      setState(() {
        searchField = textEditingController.text;
      });
    });
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Ticket> lisaTicket = context.watch<ManagerCache>().GetTicketCache();

    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: ColorsPalette.orangeMedium,
          title: Row(
            children: [
              Expanded(
                child: Container(
                  color: Colors.white,
                  child: TextField(
                    controller: textEditingController,
                    decoration: const InputDecoration(
                      icon: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(Icons.search),
                      ),
                      hintText: 'Search...',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: SafeArea(
            child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                    blurRadius: 5, color: Colors.grey, offset: Offset(2, 4))
              ]),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 30),
                      child: DropdownButton<String>(
                        underline: const SizedBox(
                          height: 0,
                          width: 0,
                        ),
                        icon: const Icon(Icons.filter_list),
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
                itemCount: lisaTicket.length,
                itemBuilder: (context, index) {
                  Color color = Colors.grey;
                  IconData? icon = Icons.abc;
                  if (lisaTicket[index].status == "Pendent") {
                    color = ColorsPalette.yellow;
                    icon = Icons.timer;
                  } else {
                    if (lisaTicket[index].status == "Processing") {
                      icon = Icons.work_history_rounded;
                      color = ColorsPalette.blue;
                    } else if (lisaTicket[index].status == "Concluded") {
                      color = ColorsPalette.green;
                      icon = Icons.done_outlined;
                    } else {
                      icon = Icons.do_not_disturb_on;
                      color = const Color.fromARGB(255, 235, 126, 126);
                    }
                  }
                  // Verifica se o item atende aos critérios de filtro
                  bool meetsSearchCriteria = searchField.isEmpty ||
                      lisaTicket[index].title.contains(searchField) ||
                      lisaTicket[index].status == dropdownValue;
                  if (meetsSearchCriteria) {
                    return Column(
                      children: [
                        const Divider(),
                        Container(
                          color: Colors.white,
                          child: ListTile(
                            leading: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: color,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Icon(
                                icon,
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
                                          ticket: lisaTicket[index],
                                        )),
                              );
                            },
                            title: Text(
                              lisaTicket[index].status,
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
                                  lisaTicket[index].title,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  lisaTicket[index].problemItem,
                                  style: const TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
            )
          ],
        )));
  }
}