import 'dart:convert';

import 'package:cep/cepResponse.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'CustomListTile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  TextEditingController cep = TextEditingController();

  CepResponse? result;

  Future<CepResponse> convertJson(String cep) async {
    Uri url = Uri.https('viacep.com.br/ws/$cep/json/');
    Response response = await get(url);
    dynamic responseJson = jsonDecode(response.body);
    dynamic formattedJson = CepResponse.fromJson(responseJson);
    return formattedJson;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Insira o CEP que deseja buscar:',
            ),
            TextField(
              controller: cep,
            ),
            ElevatedButton(
              onPressed: () {
                setState(() async {
                  result = await convertJson(cep.text);
                });
              },
              child: const Row(
                children: [
                  Icon(
                      Icons.search
                  ),
                  Text(
                      'Buscar'
                  ),
                ],
              ),
            ),
            result == null ?
              Container() :
              ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: <Widget>[
                      CustomListTile('Cep', result?.cep ?? ''),
                      const Divider(
                        height: 2.0,
                      ),
                      CustomListTile('Logradouro', result?.logradouro ?? ''),
                      const Divider(
                        height: 2.0,
                      ),
                      CustomListTile('Complemento', result?.complemento ?? ''),
                      const Divider(
                        height: 2.0,
                      ),
                      CustomListTile('Unidade', result?.unidade ?? ''),
                      const Divider(
                        height: 2.0,
                      ),
                      CustomListTile('Bairro', result?.bairro ?? ''),
                      const Divider(
                        height: 2.0,
                      ),
                      CustomListTile('Localidade', result?.localidade ?? ''),
                      const Divider(
                        height: 2.0,
                      ),
                      CustomListTile('UF', result?.uf ?? ''),
                      const Divider(
                        height: 2.0,
                      ),
                      CustomListTile('Estado', result?.estado ?? ''),
                      const Divider(
                        height: 2.0,
                      ),
                      CustomListTile('Região', result?.regiao ?? ''),
                      const Divider(
                        height: 2.0,
                      ),
                      CustomListTile('IBGE', result?.ibge ?? ''),
                      const Divider(
                        height: 2.0,
                      ),
                      CustomListTile('GIA', result?.gia ?? ''),
                      const Divider(
                        height: 2.0,
                      ),
                      CustomListTile('DDD', result?.ddd ?? ''),
                      const Divider(
                        height: 2.0,
                      ),
                      CustomListTile('Siafi', result?.siafi ?? ''),
                    ],
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}
