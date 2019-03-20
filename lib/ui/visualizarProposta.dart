import 'package:e_participe/model/proposta.dart';
import 'package:flutter/material.dart';

class VisualizarProposta extends StatelessWidget {
  final Proposta proposta;

  //Exige Proposta no construtor
  VisualizarProposta({Key key, @required this.proposta}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Use the Todo to create our UI
    return Scaffold(
      appBar: AppBar(
        title: Text(proposta.titulo),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: Text("Descrição:", textAlign: TextAlign.left),
            title: Text(proposta.descricao  ?? "Não informado", textAlign: TextAlign.justify)
          ),
          ListTile(
            leading: Text("Tema:", textAlign: TextAlign.left),
            title: Text(proposta.tema  ?? "Não informado", textAlign: TextAlign.justify)
          ),
          ListTile(
            leading: Text("Região:", textAlign: TextAlign.left),
            title: Text(proposta.regiao  ?? "Não informado", textAlign: TextAlign.justify)
          ),
          ListTile(
            leading: Text("Data de Criação:", textAlign: TextAlign.left),
            title: Text(proposta.dataCriacao  ?? "Não informado", textAlign: TextAlign.justify)
          ),
          ListTile(
            leading: Text("Autor:", textAlign: TextAlign.left),
            title: Text(proposta.autor ?? "Não informado", textAlign: TextAlign.justify)
          ),
        ]
      ),
    );
  }
}