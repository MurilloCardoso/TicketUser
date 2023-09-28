import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:taskuse/src/DB/models/chamados.dart';

class database with ChangeNotifier {
  static const baseUrl =
      'https://shopgames-193cb-default-rtdb.firebaseio.com/games.json';
  static const baseUrlPerfil =
      'https://shopgames-193cb-default-rtdb.firebaseio.com/sexo.json';

  final List<Ticket> _items = [];
  List<Ticket> getitems() {
    return _items;
  }

  Future<void> loadProducts() async {
    if (_items.isNotEmpty) {
      _items.clear();
    }
    print("Procurou os games");
    final response = await http.get(Uri.parse(baseUrl));
    if (response.body == 'null') return null;

    Map<String, dynamic> data = jsonDecode(response.body);

    data.forEach((productId, productData) {
      _items.add(
        Ticket(
          title: productData['title'],
          problemDescription: productData['descricao'],
          problemItem: productData['item'],
          status: productData['status'],
          id: productData['ID'],
        ),
      );
    });

    notifyListeners();
  }

  List<Ticket> listaHorarios() {
    return _items;
  }

  List<Ticket> FiltroCategoria(String status) {
    List<Ticket> _filtro = [];

    final response = http.get(Uri.parse(baseUrl));

    _items.forEach((element) {
      if (status == element.status) {
        _filtro.add(
          Ticket(
            id: element.id,
            title: element.title,
            problemDescription: element.problemDescription,
            problemItem: element.problemItem,
            status: element.status,
          ),
        );
      }
    });

    return _filtro;
  }
}
