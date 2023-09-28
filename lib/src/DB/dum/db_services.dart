import 'package:taskuse/src/DB/models/chamados.dart';

List<Ticket> db_services = [
  Ticket(
    id: 1,
    title: "PC NOT WORK",
    problemDescription: "MY PC IS NOT WORKING",
    problemItem: "COMPUTER DELL OPTIPLEX",
    status: "Pendent",
  ),
  Ticket(
    id: 2,
    title: "Printer does not print",
    problemDescription:
        "The printer has ink, but it doesn't print, and when I put one in, it's making a noise.",
    problemItem: "PRINTER LENOVO",
    status: "Processing",
  ),
  Ticket(
    id: 3,
    title: "CELLPHONE DOES NOT ON",
    problemDescription: "MY CELL PHONE HAS STOPPED WORKING",
    problemItem: "CELLPHONE SAMSUNG S20fe",
    status: "Concluded",
  ),
  Ticket(
    id: 4,
    title: "Router",
    problemDescription: "THE ROUTER HAS STOPPED WORKING AND HAS A RED LIGHT",
    problemItem: "THE ROUTER TP LINK",
    status: "Inconclusive",
  ),
];
