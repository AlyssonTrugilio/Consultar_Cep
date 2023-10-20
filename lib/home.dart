import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _controllerCep = TextEditingController();
  String _resultado = "Resultado vai aparecer aqui";

  _recuperarCep() async {
     String valorCep = _controllerCep.text;
    String url = "https://viacep.com.br/ws/${valorCep}/json/";
    http.Response response;
    response = await http.get(Uri.parse(url));
    print("Resposta do SV: " + response.statusCode.toString());
    print("Respota do body: " + response.body);

    Map<String, dynamic> retornoApi = json.decode(response.body);
    print("Resultado do CEP: " + retornoApi["cep"]);

    String cep = retornoApi["cep"];
    String logradouro = retornoApi["logradouro"];
    String bairro = retornoApi["bairro"];
    String ddd = retornoApi["ddd"];

    print('CEP: ${cep}\n' +
        'Logradouro: ${logradouro}\n' +
        'Bairro: ${bairro}\n' +
        'DDD: ${ddd}');

    setState(() {
      _resultado = 'CEP: ${cep}\n' +
          'Logradouro: ${logradouro}\n' +
          'Bairro: ${bairro}\n' +
          'DDD: ${ddd}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Consumo de serviços web'),
      ),
      body: Container(
        padding: EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _controllerCep,
              keyboardType: TextInputType.number,
              maxLength: 8,
              decoration: InputDecoration(labelText: "Digite o CEP"),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: ElevatedButton(
                  onPressed: _recuperarCep, child: Text('Clique aqui')),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                _resultado,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }
}
