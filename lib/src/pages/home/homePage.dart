import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:taskuse/src/DB/models/ChatUser.dart';
import 'package:taskuse/src/DB/models/chamados.dart';
import 'package:provider/provider.dart';
import 'package:taskuse/src/DB/provider/ManagerCache.dart';
import 'package:taskuse/src/DB/services/database.dart';
import 'package:taskuse/src/pages/Responsible/ResponsibleView.dart';
import 'package:taskuse/src/pages/ViewTicket/List/ViewListTicket.dart';
import 'package:taskuse/src/pages/ViewTicket/onlyView/ViewTicket.dart';
import 'package:taskuse/src/pages/createTicket/CreateTicket.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:taskuse/src/pages/session/auth_formPage.dart';
import 'package:taskuse/src/utils/ColorPallete.dart';
import "package:taskuse/src/DB/dum/db_services.dart";

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
    ChatUser user = context.watch<ManagerCache>().GetUserCache();
    List<Ticket> listOrganize = context.watch<ManagerCache>().GetTicketCache();
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 236, 234, 230),
      appBar: AppBar(
        leading: const Icon(
          Icons.notifications,
          color: Colors.white,
        ),
        backgroundColor: ColorsPalette.orangeMedium,
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.person,
                color: Colors.white,
              )),
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AuthForm()),
                );
              },
              icon: const Icon(
                Icons.exit_to_app,
                color: Colors.white,
              )),
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              width: MediaQuery.of(context).size.width * 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white),
                    padding: EdgeInsets.all(10),
                    margin: const EdgeInsets.all(10),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                child:
                                  Container(width: MediaQuery.of(context).size.width *0.6,
                                  
                                    child: Text(
                                      'Welcome ${user.name}',
                                      style: const TextStyle(
                                        fontSize: 20,overflow: TextOverflow.ellipsis
                                      ),
                                    ),
                                  ),
                                
                              ),
                              Text(
                                'All Tickets: ${listOrganize.length}',
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  TextButton.icon(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.notifications_sharp,
                                        color: ColorsPalette.orangeMedium,
                                        shadows: [
                                          Shadow(
                                              color: Colors.grey,
                                              offset: Offset(1, 1),
                                              blurRadius: 1)
                                        ],
                                      ),
                                      label: const Text(
                                        "You have notification",
                                        style: TextStyle(
                                            color: ColorsPalette.orangeMedium),
                                      ))
                                ],
                              ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 20),
                            width: MediaQuery.of(context).size.width *0.15,
                            height: MediaQuery.of(context).size.height *0.10,
                            decoration: BoxDecoration(
                              boxShadow: const [
                                BoxShadow(
                                    blurRadius: 1,
                                    offset: Offset(2, 1),
                                    color: Colors.grey)
                              ],
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                "https://avatars.githubusercontent.com/u/111089912?v=4",
                                fit: BoxFit.cover, // Defina o BoxFit para cover
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 20),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CreateTicketPage()),
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 20),
                            width: MediaQuery.of(context).size.width * 0.25,
                            height: MediaQuery.of(context).size.height * 0.13,
                            decoration: BoxDecoration(
                              color: ColorsPalette.orangeMedium,
                              boxShadow: const [
                                BoxShadow(
                                    blurRadius: 1,
                                    offset: Offset(2, 1),
                                    color: Colors.grey)
                              ],
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: const Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.receipt_long,
                                      size: 27,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      "Create log",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          overflow: TextOverflow.clip),
                                    ),
                                  ],
                                )),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ViewListTicket()),
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: 20),
                            width: MediaQuery.of(context).size.width * 0.25,
                            height: MediaQuery.of(context).size.height * 0.13,
                            decoration: BoxDecoration(
                              color: ColorsPalette.orangeMedium,
                              boxShadow: const [
                                BoxShadow(
                                    blurRadius: 1,
                                    offset: Offset(2, 1),
                                    color: Colors.grey)
                              ],
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: const Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.list_alt,
                                      size: 27,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      "List logs",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          overflow: TextOverflow.clip),
                                    ),
                                  ],
                                )),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const ViewResponsible()),
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 20),
                            width: MediaQuery.of(context).size.width * 0.25,
                            height: MediaQuery.of(context).size.height * 0.13,
                            decoration: BoxDecoration(
                              color: ColorsPalette.orangeMedium,
                              boxShadow: const [
                                BoxShadow(
                                    blurRadius: 1,
                                    offset: Offset(2, 1),
                                    color: Colors.grey)
                              ],
                              borderRadius: BorderRadius.circular(20),
                              child: const Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.settings,
                                    size: 27,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    "Settings",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        overflow: TextOverflow.clip),
                                  ),
                                ],
                              )),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Divider(
                    height: 0,
                    color: Color.fromARGB(31, 109, 109, 109),
                  ),
                  listOrganize.isNotEmpty
                      ? Container(
                          padding: const EdgeInsets.all(5),
                          margin: const EdgeInsets.symmetric(horizontal: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                "Tickets",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 106, 106, 106),
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "Poppins"),
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.grey[100]),
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
                                          (String value) =>
                                              DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value),
                                              ))
                                      .toList(),
                                ),
                              )
                            ],
                          ),
                        )
                      : Container(),
                  const SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
            listOrganize.isEmpty
                ? Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Opacity(
                            opacity: 1,
                            child: SvgPicture.asset(
                              "imgs/svg/undraw_no_data_re_kwbl.svg",
                              semanticsLabel: 'Acme Logo',
                              width: MediaQuery.of(context).size.width * 0.2,
                              height: MediaQuery.of(context).size.height *
                                  0.2, // Ajuste o tamanho conforme necessário
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            "No data found",
                            style: TextStyle(
                                color: Color.fromARGB(255, 106, 106, 106),
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                fontFamily: "Poppins"),
                          )
                        ],
                      ),
                    ),
                  )
                : Expanded(child: Consumer<ManagerCache>(
                    builder: (context, managerCache, child) {
                    List<Ticket> listOrganize = managerCache.GetTicketCache();
                    return ListView.builder(
                      itemCount: listOrganize.length,
                      itemBuilder: (context, index) {
                        Color color = Colors.grey;
                        IconData? icone = Icons.abc;
                        if (listOrganize[index].status == "Pendent") {
                          color = Color.fromARGB(255, 237, 200, 98);
                          icone = Icons.timer;
                        } else {
                          if (listOrganize[index].status == "Processing") {
                            icone = Icons.work_history_rounded;
                            color = const Color.fromARGB(255, 82, 86, 163);
                          } else if (listOrganize[index].status ==
                              "Concluded") {
                            color = Color.fromARGB(255, 96, 188, 136);
                            icone = Icons.done_outlined;
                          } else {
                            icone = Icons.do_not_disturb_on;
                            color = Color.fromARGB(255, 224, 98, 98);
                          }
                        }

                        return dropdownValue == "All" ||
                                (dropdownValue == listOrganize[index].status)
                            ? Column(
                                children: [
                                  const Divider(
                                    height: 0,
                                    color: Color.fromARGB(31, 109, 109, 109),
                                  ),
                                  Container(
                                    color: Colors.white,
                                    child: ListTile(
                                      trailing: const Icon(
                                        Icons.arrow_right_sharp,
                                        color: ColorsPalette.orangeMedium,
                                      ),
                                      leading: Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                            color: color,
                                            borderRadius:
                                                BorderRadius.circular(10)),
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
                                                    ticket: listOrganize[index],
                                                  )),
                                        );
                                      },
                                      title: Text(
                                        listOrganize[index].title,
                                        style: const TextStyle(
                                            color:
                                                Color.fromARGB(255, 64, 63, 63),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      subtitle: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            listOrganize[index].status,
                                            style: const TextStyle(
                                                color: Colors.grey,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : const SizedBox.shrink();
                      },
                    );
                  }))
          ],
        ),
      ),
    );
  }

  List<Ticket> organize(List<Ticket> status) {
    status.sort((a, b) {
      // Se a é "Pendent" e b não é, coloque a em cima
      if (a.status == "Pendent" && b.status != "Pendent") {
        return -1;
      }
      // Se b é "Pendent" e a não é, coloque b em cima
      if (b.status == "Pendent" && a.status != "Pendent") {
        return 1;
      }
      // Caso contrário, não mude a ordem
      return 0;
    });
    return status;
  }
}
