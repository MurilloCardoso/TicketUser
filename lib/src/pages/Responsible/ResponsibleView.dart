import 'package:flutter/material.dart';

class ViewResponsible extends StatefulWidget {
  const ViewResponsible({super.key});

  @override
  State<ViewResponsible> createState() => _ViewResponsibleState();
}

class _ViewResponsibleState extends State<ViewResponsible> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          const Text("Statistics"),
          Center(child: Text("comming soon"))
        ],
      )),
    );
  }
}
