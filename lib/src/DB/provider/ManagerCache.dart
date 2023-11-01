// ignore_for_file: public_member_api_docs, lines_longer_than_80_chars

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:taskuse/src/DB/dum/db_services.dart';
import 'package:taskuse/src/DB/models/ChatUser.dart';
import 'package:taskuse/src/DB/models/chamados.dart';

class ManagerCache with ChangeNotifier, DiagnosticableTreeMixin {
  ChatUser userLogged = ChatUser(
      id: 2,
      name: "Junior",
      email: "junior@gmail.com",
      password: "passwor",
      type: 0);

  void addUserCache(ChatUser prod) {
    userLogged = prod;
    notifyListeners();
  }

  void setListaTicket(List<Ticket> tickets) {
    db_services = tickets;
    notifyListeners();
  }

  Future<bool> addTicketCache(Ticket ticket) async {
    try {
      db_services.add(ticket);
      notifyListeners();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  List<Ticket> GetTicketCache() {
    return db_services;
  }

  ChatUser GetUserCache() {
    return userLogged;
  }
}
