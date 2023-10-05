import 'dart:math';

import 'package:flutter/material.dart';
import 'package:taskuse/src/DB/dum/db_services.dart';
import 'package:taskuse/src/DB/models/ChatUser.dart';
import 'package:taskuse/src/DB/models/auth_form_data.dart';
import 'package:taskuse/src/DB/models/chamados.dart';
import 'package:taskuse/src/DB/provider/ManagerCache.dart';
import 'package:taskuse/src/DB/services/auth_mock_service.dart';
import 'package:taskuse/src/pages/Master/resolution/resolutionPage.dart';
import 'package:taskuse/src/pages/home/homePage.dart';
import 'package:provider/provider.dart';
import 'package:taskuse/src/utils/ColorPallete.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({
    super.key,
  });

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
//    FirebaseAuth _auth = FirebaseAuth.instance;
//  String _token = "";
//    @override
//  void initState() {
//    super.initState();
//    _getToken();
//  }

  // Função para obter o token de autenticação
  // Future<void> _getToken() async {
  //   User? user = _auth.currentUser;
  //   if (user != null) {
  //     String? token = await user.getIdToken();
  //     setState(() {
  //       _token = token!;
  //     });
  //   }
  // }

  final _formKey = GlobalKey<FormState>();
  final _formData = AuthFormData();
  final auth = AuthMockService();

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: Theme.of(context).errorColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Future<void> _submit() async {
      final isValid = _formKey.currentState?.validate() ?? false;
      if (!isValid) return;
      //    User? user = _auth.currentUser;
      // var _tokena = await FirebaseAuth.instance.currentUser?.getIdToken();
      bool login = false;
      ChatUser chat = const ChatUser(
          id: 0, name: "name", email: "email", password: "password", type: 0);
      if (_formData.isLogin) {
        for (ChatUser user in db_user) {
         
          if (_formData.email == user.email &&
              _formData.password == user.password.toString()) {
            login = true;
            chat = user;
          }
        }

        if (login) {
          if (chat.id != 0) {
            if (chat.type == 2) {
              context.read<ManagerCache>().addUserCache(chat);

              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ResolutionPage()),
              );
            } else {
              context.read<ManagerCache>().addUserCache(chat);

              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyHomePage()),
              );
            }
          } else {
            _showError("Erro Login");
          }
        } else {
          print("deu ruim");
        }
      } else {
        db_user.add(ChatUser(
            id: db_user.length,
            name: _formData.name,
            email: _formData.email,
            password: _formData.password,
            type: 1));
        chat = ChatUser(
            id: db_user.length,
            name: _formData.name,
            email: _formData.email,
            password: _formData.password,
            type: 1);
        context.read<ManagerCache>().addUserCache(chat);

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MyHomePage()),
        );
      }
    }
    // Future<void> _submit() async {
    //   final isValid = _formKey.currentState?.validate() ?? false;
    //   if (!isValid) return;
    //   //    User? user = _auth.currentUser;
    //   // var _tokena = await FirebaseAuth.instance.currentUser?.getIdToken();

    //   _formData.isLogin
    //       ? auth.loginService(_formData, context, _tokena!).then((value) => {
    //             if (value)
    //               {
    //                 Navigator.push(
    //                   context,
    //                   MaterialPageRoute(builder: (context) => MyHomePage()),
    //                 )
    //               }
    //             else
    //               {print("deu ruim")}
    //           })
    //       : auth.cadastroService(_formData, context, _tokena!).then((value) => {
    //             if (value)
    //               {
    //                 Navigator.push(
    //                   context,
    //                   MaterialPageRoute(builder: (context) => MyHomePage()),
    //                 )
    //               }
    //             else
    //               {print("deu ruim")}
    //           });
    // }

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: ColorsPalette.orangeMedium,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                    width: MediaQuery.of(context).size.width * 0.2,
                    height: MediaQuery.of(context).size.height * 0.2,
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: Image.asset("assets/imgs/tasks-icon-19.jpg")),
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 0),
                      child: Text(
                        _formData.isLogin ? 'Login' : 'Cadastro',
                        style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                            fontFamily: "Poppins"),
                      ),
                    ),
                  ],
                ),
                if (_formData.isSignup)
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
                    child: TextFormField(
                      key: const ValueKey('name'),
                      onChanged: (name) => _formData.name = name,
                      decoration: const InputDecoration(
                        hintText: 'Name',
                        fillColor: Color.fromARGB(255, 255, 255, 255),
                        filled: true,
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 0, 0, 0), width: 1)),
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 5, 20.0, 10.0),
                      ),
                      style: const TextStyle(
                        fontSize: 15,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                      textInputAction: TextInputAction.next,
                      validator: (localName) {
                        final name = localName ?? '';
                        if (name.trim().length < 5) {
                          return 'Nome deve ter no mínimo 5 caracteres.';
                        }
                        return null;
                      },
                    ),
                  ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: TextFormField(
                    key: const ValueKey('email'),
                    onChanged: (email) => _formData.email = email,
                    decoration: const InputDecoration(
                      hintText: 'Email',
                      fillColor: Color.fromARGB(255, 255, 255, 255),
                      filled: true,
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 0, 0, 0), width: 1)),
                      contentPadding: EdgeInsets.fromLTRB(20.0, 5, 20.0, 10.0),
                    ),
                    style: const TextStyle(
                      fontSize: 15,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                    textInputAction: TextInputAction.next,
                    validator: (localEmail) {
                      final email = localEmail ?? '';
                      if (!email.contains('@')) {
                        return 'E-mail nformado não é válido.';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: TextFormField(
                    key: const ValueKey('password'),
                    onChanged: (password) => _formData.password = password,
                    obscureText: true,
                    autofocus: false,
                    decoration: const InputDecoration(
                      hintText: 'Password',
                      fillColor: Color.fromARGB(255, 255, 255, 255),
                      filled: true,
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 0, 0, 0), width: 1)),
                      contentPadding: EdgeInsets.fromLTRB(20.0, 5, 20.0, 10.0),
                    ),
                    style: const TextStyle(
                      fontSize: 15,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                    validator: (localPassword) {
                      final password = localPassword ?? '';
                      if (password.length < 6) {
                        return 'Nome deve ter no mínimo 6 caracteres.';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            0), // Ajuste o valor do raio conforme necessário
                      ),
                      foregroundColor: Colors.white,
                      primary: ColorsPalette.orangeMedium,
                      padding:
                          EdgeInsets.symmetric(horizontal: 100, vertical: 10),
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      )),
                  onPressed: _submit,
                  child: Text(_formData.isLogin ? 'Entrar' : 'Cadastrar'),
                ),
                Column(
                  children: [
                    SizedBox(
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            _formData.toggleAuthMode();
                          });
                        },
                        child: Text(
                          _formData.isLogin
                              ? 'Criar uma nova conta?'
                              : 'Já possui conta?',
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
