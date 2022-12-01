import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';

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
  TimeOfDay hora_atual = TimeOfDay.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Aplicativo final 21420")),
      body: Column(
        children: [
          TextButton(
            // GET REQUEST
              onPressed: () async {
                final url =
                    Uri.parse("https://www.slmm.com.br/CTC/getLista.php");

                final response = await http.get(url);
                if (response.statusCode == 200) {
                  print(response.body);
                } else {
                  print("cod: 0, status: problemas com a lista");
                }
              },
              child: Text("GET Lista")),
          TextButton(
            // POST REQUEST
            onPressed: () async {
              final baseUrl =
                  Uri.parse("https://www.slmm.com.br/CTC/insere.php");
              var datareal = (DateFormat("dd/MM/yy HH:mm:ss").format(agora));
              //hora_atual.toString()); // data + horário exato de agora

              print(datareal);

              Map data = {"nome": "seu marquinhos", "data": datareal};
              final body = json.encode(data);

              final insere = {"cod": 1, "status": "inserido"};
              final naoinsere = {"cod": 0, "status": "nao inserido"};

              final response = await http.post(baseUrl,
                  headers: {"Content-Type": "application/json"}, body: body);

              if (response.statusCode == 200) {
                print(insere);
                print(response.body);
              } else {
                print(naoinsere);
              }
            },
            child: Text("Post"),
          ),
          TextButton(
            // GET PARAMETER REQUEST
              onPressed: () async {
                var dio = Dio();
                final url = Uri.parse(
                    "https://www.slmm.com.br/CTC/getDetalhe.php?id=1");

                final response = await dio
                    .get("https://www.slmm.com.br/CTC/getDetalhe.php?id=102");

                if (response.statusCode == 200) {
                  print("cod: 1, status: lido, detalhe: ${response.data}");
                } else {
                  print("cod: 0, status: não existe esse id");
                }
              },
              child: Text("GET Detalhe")),
          TextButton(
            // DELETE REQUEST
              onPressed: () async {
                final response = await http.delete(
                    Uri.parse("https://www.slmm.com.br/CTC/delete.php?id=102"),
                    headers: {"Content-Type": "application/json"});

                if (response.statusCode == 200) {
                  print("cod: 1, status: apagado");
                } else {
                  print("cod: 0, status: não apagado");
                }
              },
              child: Text("Delete")),
        ],
      ),
    );
  }
}
