import 'package:flutter/material.dart';
import 'package:taskuse/src/DB/models/auth_form_data.dart';
import 'package:taskuse/src/DB/services/auth_mock_service.dart';
import 'package:taskuse/src/components/SnackBar.dart';
import 'package:taskuse/src/pages/home/homePage.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({
    super.key,
  });

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
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

  void _submit() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    if (_formData.email == "eu@g" || _formData.password == "123456") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const MyHomePage()),
      );
    } else {
      Snackbars.error(context, "Erro no login");
    }
    /*  _formData.isLogin ? 
    auth.loginService(_formData).then((value) => {
          if (value)
            {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MyHomePage(
                          title: "awdwaed",
                        )),
              )
            }
          else
            {print("deu ruim")}
        }): auth.cadastroService(_formData).then((value) => {
          if (value)
            {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MyHomePage(
                          title: "awdwaed",
                        )),
              )
            }
          else
            {print("deu ruim")}
        });*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Text(
                  _formData.isLogin ? 'Login' : 'Cadastro',
                ),
                if (_formData.isSignup)
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    child: TextFormField(
                      key: const ValueKey('name'),
                      onChanged: (name) => _formData.name = name,
                      decoration: InputDecoration(
                          icon: new Icon(Icons.person,
                              color: Color.fromARGB(255, 0, 0, 0)),
                          hintText: 'Email',
                          fillColor: Color.fromARGB(255, 255, 255, 255),
                          filled: true,
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 0, 0, 0), width: 1),
                          )),
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
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: TextFormField(
                    key: const ValueKey('email'),
                    onChanged: (email) => _formData.email = email,
                    decoration: InputDecoration(
                        icon: new Icon(Icons.email,
                            color: Color.fromARGB(255, 0, 0, 0)),
                        hintText: 'Email',
                        fillColor: Color.fromARGB(255, 255, 255, 255),
                        filled: true,
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 0, 0, 0), width: 1),
                        )),
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.blue,
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
                    decoration: InputDecoration(
                        icon: new Icon(Icons.lock,
                            color: Color.fromARGB(255, 0, 0, 0)),
                        hintText: 'Password',
                        fillColor: Color.fromARGB(255, 255, 255, 255),
                        filled: true,
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(
                              color: const Color.fromARGB(255, 0, 0, 0),
                              width: 1),
                        )),
                    style: const TextStyle(
                      fontSize: 20,
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
                      primary: Color.fromARGB(255, 239, 181, 35),
                      padding:
                          EdgeInsets.symmetric(horizontal: 100, vertical: 10),
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      )),
                  onPressed: _submit,
                  child: Text(_formData.isLogin ? 'Entrar' : 'Cadastrar'),
                ),
                const SizedBox(height: 20),
                Column(
                  children: [
                    Container(
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
