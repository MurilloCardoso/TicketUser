import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:taskuse/src/DB/models/chamados.dart';
import 'package:taskuse/src/DB/provider/ManagerCache.dart';
import 'package:provider/provider.dart';
import 'package:taskuse/src/components/SnackBar.dart';
import 'package:taskuse/src/pages/home/homePage.dart';
import 'package:taskuse/src/utils/ColorPallete.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CreateTicketPage extends StatefulWidget {
  const CreateTicketPage({super.key});

  @override
  State<CreateTicketPage> createState() => _CreateTicketPageState();
}

class _CreateTicketPageState extends State<CreateTicketPage> {
  final _formKey = GlobalKey<FormState>();

  List<String>? _selectedImagePath = [];

  @override
  void initState() {
    super.initState();
    // Configura o MethodChannel para receber a URI da imagem
    const platform = MethodChannel('samples.flutter.dev/gallery');
    platform.setMethodCallHandler(_handleImageSelected);
  }
  // Função para lidar com a URI da imagem selecionada

  Future<void> _handleImageSelected(MethodCall call) async {
    if (call.method == 'imageSelected') {
      setState(() {
        _selectedImagePath!.add(call.arguments);
      });
    }
  }

  Ticket prod = Ticket(
      title: "",
      problemDescription: "",
      problemItem: "",
      status: "",
      message: []);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: ColorsPalette.orangeMedium,
        title: const Text(
          'Ticket',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: const Text(
                        "Title",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: ColorsPalette.smoke,
                      ),
                      child: TextFormField(
                          key: const ValueKey('titulo'),
                          validator: (titleForm) {
                            final form = titleForm ?? '';
                            if (form.isEmpty) {
                              return 'Enter a valid title.';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            contentPadding:
                                EdgeInsets.fromLTRB(10.0, 5.0, 5.0, 5.0),
                            hintText: "Enter a title",
                            border: InputBorder.none, // Remove a borda padrão
                          ),
                          onChanged: (value) => prod.title = value),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      child: const Text(
                        "Item",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: ColorsPalette.smoke,
                      ),
                      child: TextFormField(
                        key: const ValueKey('item'),
                        decoration: const InputDecoration(
                            contentPadding:
                                EdgeInsets.fromLTRB(10.0, 5.0, 5.0, 5.0),
                            border: InputBorder.none,
                            hintText: "Enter an item name"
                            // Remove a borda padrão
                            ),
                        validator: (localEmail) {
                          final email = localEmail ?? '';
                          if (email.isEmpty) {
                            return 'Enter the item for the ticket.';
                          }
                          return null;
                        },
                        onChanged: (value) => prod.problemItem = value,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: const Text(
                        "Description",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: ColorsPalette.smoke,
                      ),
                      padding: const EdgeInsets.all(5),
                      child: TextFormField(
                        key: const ValueKey('descricao'),
                        decoration: const InputDecoration(
                          contentPadding:
                              EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
                          hintText: "Describe a story for the so-called",
                          border: InputBorder.none, // Remove a borda padrão
                        ),
                        validator: (descricaoForm) {
                          final form = descricaoForm ?? '';
                          if (form.isEmpty) {
                            return 'Enter a valid description.';
                          }
                          return null;
                        },
                        maxLines: 7,
                        onChanged: (value) => prod.problemDescription = value,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text("(Optional)"),
                    const Text(
                      "Take a photo for better viewing",
                      style: TextStyle(fontSize: 12),
                    ),
                    GestureDetector(
                      onTap: () async {
                        const platform =
                            MethodChannel('samples.flutter.dev/gallery');
                        await platform.invokeMethod('openGallery');
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 1,
                        height: MediaQuery.of(context).size.height * 0.070,
                        margin: EdgeInsets.symmetric(vertical: 20),
                        child: Container(
                          color: ColorsPalette.smoke,
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.photo, size: 27),
                              Text(
                                "Insert a photo",
                                style: TextStyle(fontSize: 17),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 1,
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.070,
                        child: ElevatedButton(
                            onPressed: () {
                              final isValid =
                                  _formKey.currentState?.validate() ?? false;
                              if (!isValid) return;

                              Ticket ticket = Ticket(
                                  title: prod.title,
                                  problemDescription: prod.problemDescription,
                                  problemItem: prod.problemItem,
                                  status: "Pendent",
                                  message: []);
                              context
                                  .read<ManagerCache>()
                                  .addTicketCache(ticket)
                                  .then((value) => {
                                        if (value)
                                          {
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  content: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 15),
                                                    child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          const Text(
                                                            "Ticket Created Successfully",
                                                            style: TextStyle(
                                                              fontSize: 21,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            height: 15,
                                                          ),
                                                          SizedBox(
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.1,
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                1,
                                                            child:
                                                                ElevatedButton(
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                    child: const Text(
                                                                        "Make new ticket")),
                                                          ),
                                                          SvgPicture.asset(
                                                            "undraw_no_data_re_kwbl.svg",
                                                            semanticsLabel:
                                                                'Acme Logo',
                                                          ),
                                                          const SizedBox(
                                                            height: 15,
                                                          ),
                                                          SizedBox(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                1,
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.1,
                                                            child:
                                                                ElevatedButton(
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.pop(
                                                                          context);
                                                                      Navigator
                                                                          .push(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                            builder: (context) =>
                                                                                MyHomePage()),
                                                                      );
                                                                    },
                                                                    child: const Text(
                                                                        "Finish creation")),
                                                          )
                                                        ]),
                                                  ),
                                                );
                                              },
                                            )
                                          }
                                        else
                                          {
                                            Snackbar.error(
                                                context, "Operation error")
                                          }
                                      });
                            },
                            child: const Text("Register call")),
                      ),
                    )
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}