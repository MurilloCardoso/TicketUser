// ignore_for_file: public_member_api_docs, lines_longer_than_80_chars

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:taskuse/src/DB/models/ChatUser.dart';
import 'package:taskuse/src/DB/models/chamados.dart';

class ManagerCache with ChangeNotifier, DiagnosticableTreeMixin {
  List<Ticket> listaCart = [];
  ChatUser userLogged = ChatUser(
      id:  0, name: "", email: "", password: "", type: 1);

  void addUserCache(ChatUser prod) {
    userLogged = prod;
    notifyListeners();
  }

  Future<bool> addTicketCache(Ticket ticket) async {
    try {
      listaCart.add(ticket);
      notifyListeners();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  List<Ticket> GetTicketCache() {
    return listaCart;
  }

  ChatUser GetUserCache() {
    return userLogged;
  }
}
