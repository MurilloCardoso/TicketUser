import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;


class teste extends StatefulWidget {
  @override
  _testeState createState() => _testeState();
}

class _testeState extends State<teste> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  String _token = "";

  @override
  void initState() {
    super.initState();
    _getToken();
  }

  // Função para obter o token de autenticação
  Future<void> _getToken() async {
    User? user = _auth.currentUser;
    if (user != null) {
      String? token = await user.getIdToken();
      setState(() {
        _token = token!;
      });
    }
  }

  // Função para fazer uma chamada autenticada ao Firebase
  Future<void> _fetchData() async {
    final url = 'https://web2-teste-default-rtdb.firebaseio.com/users';
    final headers = {
      'Authorization': 'Bearer $_token',
    };

    final response = await http.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      // Dados recebidos com sucesso
      print(response.body);
    } else {
      // Trate erros
      print('Erro: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exemplo de Chamada Autenticada'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Token de Autenticação: $_token'),
            ElevatedButton(
              onPressed: _fetchData,
              child: Text('Fazer Chamada Autenticada'),
            ),
          ],
        ),
      ),
    );
  }
}
