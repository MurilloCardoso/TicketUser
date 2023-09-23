import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:taskuse/src/DB/models/chamados.dart';
import 'package:taskuse/src/DB/provider/ManagerCache.dart';
import 'package:provider/provider.dart';

class CreateTicketPage extends StatefulWidget {
  const CreateTicketPage({super.key});

  @override
  State<CreateTicketPage> createState() => _CreateTicketPageState();
}

class _CreateTicketPageState extends State<CreateTicketPage> {
  Ticket prod = new Ticket(
      title: "", problemDescription: "", problemItem: "", status: "");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Ticket'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                "Titulo do problema",
                style: TextStyle(fontSize: 20),
              ),
              Container(
                margin: EdgeInsetsDirectional.symmetric(horizontal: 10),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.grey[200],
                ),
                child: TextField(onChanged: (value) => prod.title = value),
              ),
              Text("Descrição"),
              TextField(
                onChanged: (value) => prod.problemDescription = value,
              ),
              Text("Item"),
              TextField(
                onChanged: (value) => prod.problemItem = value,
              ),
              ElevatedButton(
                  onPressed: () {
                    Ticket ticket = Ticket(
                        title: prod.title,
                        problemDescription: prod.problemDescription,
                        problemItem: prod.problemItem,
                        status: "pendent");
                    context.read<ManagerCache>().addTicketCache(ticket);
                  },
                  child: Text("Cadastrar chamado"))
            ]),
          ),
        ),
      ),
    );
  }
}
