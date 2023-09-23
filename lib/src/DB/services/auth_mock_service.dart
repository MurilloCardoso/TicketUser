import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:taskuse/src/DB/models/ChatUser.dart';
import 'package:taskuse/src/DB/models/auth_form_data.dart';
import 'package:taskuse/src/components/SnackBar.dart';

class AuthMockService {
  static const BaseUrl =
      'https://testes-714cc-default-rtdb.firebaseio.com/perfil';
 
  Future<bool> cadastroService(AuthFormData form,BuildContext context) async {
    try {
      final response = await http.post(
        Uri.parse('$BaseUrl.json'),
        body: jsonEncode(
          {
            "email": form.email,
            "name": form.name,
            "password": form.password,
          },
        ),
      );
      if (response.statusCode == 201) {
        return true;
      } else {
        // If the server did not return a 201 CREATED response,
        // then throw an exception.
         Snackbars.error(context, "Falha no conexão com servidor ");
        throw Exception('Failed to create album.');
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

 
  Future<bool> loginService(AuthFormData form,BuildContext context) async {
    try {
      final response = await http.get(Uri.parse('$BaseUrl.json'));
   
      Map<String, dynamic> data = jsonDecode(response.body);
      data.forEach((productId, productData) {
        final newUser = ChatUser(
          id:  productId,
          name: productData['name'],
          email: productData['email'],
          password: productData['password'],
        );

        if (form.email == newUser.email && form.password == newUser.password) {
          print("Entrou");
         return ;
        }
      });
    } catch (e) {
      print(e);
         Snackbars.error(context, "Falha no conexão com servidor ");
      return false;
    }
    return false;
  }
}
