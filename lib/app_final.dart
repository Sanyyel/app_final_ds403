import 'dart:ffi';
import 'package:flutter/material.dart';
import 'dart.io';
import 'dart.convert';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import "package:http/http.dart" as http;

class app_final extends StatefulWidget {
  const app_final({Key? key}) : super(key: key);

  @override
  _app_finalState createState() => _app_finalState();
}

class _app_finalState extends State<app_final> {
  DateTime agora = DateTime.now();
  String hora_atual = TimeOfDay.now() as String;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Aplicativo final 21420")),
        body: Container(
          child: FloatingActionButton(
            onPressed: () async {
              var datareal = Text(DateFormat("dd/MM//yyyy").format(agora) +
                  hora_atual); // data + horário exato de agora

              Map data = {"nome": "seu marquinhos", "data": datareal};

              var baseUrl = Uri.parse("www.slmm.com.br/CTC/insere.php");
              
              var body = json.encode(data);

              http.Response response = await http.post(baseUrl,
                      headers: {"Content-Type": "application/json"},
                      body: body);

              print(response.statusCode);
              //botão para post
            },
          ),
        ));
  }
}
