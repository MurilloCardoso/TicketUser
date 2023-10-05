import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:taskuse/src/DB/models/ChatUser.dart';
import 'package:taskuse/src/DB/models/chamados.dart';
import 'package:provider/provider.dart';
import 'package:taskuse/src/DB/provider/ManagerCache.dart';
import 'package:taskuse/src/DB/services/database.dart';
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
  @override
  Widget build(BuildContext context) {
    if (db_services.length >=
        context.watch<ManagerCache>().GetTicketCache().length) {
      for (int i = 0; i < db_services.length; i++) {
        context.watch<ManagerCache>().addTicketCache(db_services[i]);
      }
    }
    ChatUser user = context.watch<ManagerCache>().GetUserCache();
    List<Ticket> listaTicket = context.watch<ManagerCache>().GetTicketCache();
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
                              Text(
                                'Welcome ${user.name}',
                                style: const TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              Text(
                                'Todal de Chamados: ${listaTicket.length}',
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
                            width: 70,
                            height: 70,
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
              padding: EdgeInsets.only(top: 20),
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
                                      Icons.list_alt_outlined,
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
                        Container(
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
                    height: 10,
                  ),
                  const Center(
                    child: Text(
                      "Call logs",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
            Expanded(
              child: listaTicket.isEmpty
                  ? Center(
                      child: Opacity(
                        opacity: 0.7,
                        child: SizedBox(
                          width: double.maxFinite,
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
                            const Divider(
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
                                  padding: const EdgeInsets.all(8),
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
                                  listaTicket[index].title,
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 64, 63, 63),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                                subtitle: Column(
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
            ),
          ],
        ),
      ),
    );
  }
}
