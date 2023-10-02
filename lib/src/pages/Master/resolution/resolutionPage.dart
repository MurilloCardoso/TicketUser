import 'package:flutter/material.dart';
import 'package:taskuse/src/DB/models/ChatUser.dart';
import 'package:taskuse/src/DB/models/chamados.dart';
import 'package:provider/provider.dart';
import 'package:taskuse/src/DB/provider/ManagerCache.dart';
import 'package:taskuse/src/pages/ViewTicket/onlyView/ViewTicket.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:taskuse/src/pages/session/auth_formPage.dart';
import 'package:taskuse/src/utils/ColorPallete.dart';

class ResolutionPage extends StatefulWidget {
  const ResolutionPage({super.key});

  @override
  State<ResolutionPage> createState() => _ResolutionPageState();
}

class _ResolutionPageState extends State<ResolutionPage> {
  @override
  Widget build(BuildContext context) {
    List<Ticket> listaTicket = context.watch<ManagerCache>().GetTicketCache();
    ChatUser user = context.watch<ManagerCache>().GetUserCache();

    return Scaffold(
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              width: MediaQuery.of(context).size.width * 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Bem-vindo ${user.name}',
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(
                          'Todal de Chamados: ${listaTicket.length}',
                        ),
                        const SizedBox(
                          height: 10,
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
                            SizedBox(
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: color,
                                  child: const Icon(
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
                                      style: const TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w800),
                                    ),
                                    Text(
                                      listaTicket[index].problemDescription,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const Divider(
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
