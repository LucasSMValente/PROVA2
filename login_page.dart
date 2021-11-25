import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String usuario = '';
  String senha = '';

  Future<List> _login() async {
    final response =
        await http.post(Uri.parse("http://localhost/login/login.php"), body: {
      "username": usuario,
      "password": senha,
    });
    print(response.body);
    var datauser = json.decode(response.body);

    AlertDialog alert2 = AlertDialog(
      title: Text("Sucesso!"),
      content: Text("Login Efetuado!"),
    );
    AlertDialog alert1 = AlertDialog(
      title: Text("Erro!"),
      content: Text("Usuario ou senha Incorreto!"),
    );

    if (datauser.length == 0) {
      print("Login Fail");
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert1;
        },
      );
    } else {
      print("Login Sucess");
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert2;
        },
      );
    }

    return datauser;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                onChanged: (text) {
                  usuario = text;
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Usuário'),
              ),
              SizedBox(height: 15),
              TextField(
                onChanged: (text) {
                  senha = text;
                },
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Senha'),
              ),
              SizedBox(height: 20),
              RaisedButton(
                onPressed: () {
                  _login();
                },
                child: Text('Entrar'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
