import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  var _controllerCep = TextEditingController();
  String _logradouro = "";
  String _bairro = "";
  String _complemento = "";
  String _localidade = "";
  String _uf = "";
  String _mensagemUsuario = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Buscar CEP"),
        backgroundColor: Colors.indigo,
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 16),
              child: TextField(
                controller: _controllerCep,
                keyboardType: TextInputType.number,
                maxLength: 8,
                decoration: InputDecoration(
                  labelText: "Informe o numero do cep que deseja pesquisar"
                ),
              ),
            ),
            RaisedButton(
              child: Text("Consultar CEP"),
              color: Colors.blue,
              textColor: Colors.white,
              onPressed: _recuperarCep,
            ),
            Padding(
              padding: EdgeInsets.only(top: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(bottom: 16),
                    child: Row(
                      children: <Widget>[
                        Text("Estado: ", style: TextStyle(
                          fontWeight: FontWeight.bold
                        ),),
                        Text(_uf)
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 16),
                    child: Row(
                      children: <Widget>[
                        Text("Cidade: ", style: TextStyle(
                          fontWeight: FontWeight.bold
                        ),),
                        Text(_localidade),
                      ],
                    )
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 16),
                    child: Row(
                      children: <Widget>[
                        Text("Bairro: ", style: TextStyle(
                          fontWeight: FontWeight.bold
                        ),),
                        Text(_bairro),
                      ],
                    )
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 16),
                    child: Row(
                      children: <Widget>[
                        Text("Complemento: ", style: TextStyle(
                          fontWeight: FontWeight.bold
                        ),),
                        Text(_complemento),
                      ],
                    )
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 32),
                    child: Row(
                      children: <Widget>[
                        Text("Logradouro: ", style: TextStyle(
                          fontWeight: FontWeight.bold
                        ),),
                        Text(_logradouro),
                      ],
                    )
                  ),
                  Text(_mensagemUsuario,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold
                  ),)

                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _recuperarCep() async{
    String urlRequisicao = "http://viacep.com.br/ws/__CEP__/json/";
    var cep = _controllerCep.text;


    http.Response response;
    response = await http.get(urlRequisicao.replaceAll("__CEP__", cep));

    if(!response.body.contains("erro")){
      Map<String, dynamic> retorno = jsonDecode(response.body);
      _uf = retorno["uf"];
      _localidade = retorno["localidade"];
      _bairro = retorno["bairro"];
      _complemento = retorno["complemento"];
      _logradouro = retorno["logradouro"];
      _mensagemUsuario = "";
    }
    else{
      _mensagemUsuario = "O cep não foi encontrado ou ocorreu um erro durante a busca";
      _uf = "";
      _localidade = "";
      _bairro = "";
      _complemento = "";
      _logradouro = "";
      }


    setState(() {});


  }
}
