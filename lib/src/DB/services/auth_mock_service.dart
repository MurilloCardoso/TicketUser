import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:taskuse/src/DB/models/ChatUser.dart';
import 'package:taskuse/src/DB/models/auth_form_data.dart';
import 'package:taskuse/src/components/SnackBar.dart';

class AuthMockService {
  static const BaseUrl =
      'https://web2-teste-default-rtdb.firebaseio.com/users';
 
  Future<bool> cadastroService(AuthFormData form,BuildContext context,String _token) async {
    print("token: "+_token);
    try {
          final headers = {
      'Authorization': 'Bearer $_token',
    };
      final response = await http.post(
        Uri.parse('$BaseUrl.json'),
        body: jsonEncode(
          {
            "email": form.email,
            "name": form.name,
            "password": form.password,
          },
        ), headers: headers
      );
      print(response.body);
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

 
  Future<bool> loginService(AuthFormData form,BuildContext context,String _token) async {
    try {
       final headers = {
      'Authorization': 'Bearer $_token',
    };
      final response = await http.get(Uri.parse('$BaseUrl.json'), headers: headers);
      
      print(response.body);
      Map<String, dynamic> data = jsonDecode(response.body);
      data.forEach((productId, productData) {
        final newUser = ChatUser(
          id:  int.parse(productId),
          name: productData['name'],
          email: productData['email'],
          password: productData['password'],
          type: productData["type"]
        );

        if (form.email == newUser.email && form.password == newUser.password) {
          print("Entrou");
         return ;
        }
      });
    } catch (e) {
      print(e);
         Snackbars.error(context, "Falha na conexão com o servidor ");
      return false;
    }
    return false;
  }
}
