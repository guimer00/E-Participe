import 'package:e_participe/model/proposta.dart';
import 'package:flutter/material.dart';

var _color = Colors.black38;

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
      body: SingleChildScrollView(child: new VisualizarDados(proposta: proposta))
    );
  }
}

Widget botaoVotacao(IconData icon, String buttonTitle, int votos){
  return new Column(
    children: <Widget>[
      new Text(buttonTitle, style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600)),
      new Text(votos.toString(), style: TextStyle(fontSize: 18.0)),
      SizedBox(height: 10.0),
      new FlatButton(
        onPressed: null,
        child: Column(
          children: <Widget>[
            Icon(icon, size: 50.0, color: _color)
          ],
        ))
    ],
  );
}


class VisualizarDados extends StatelessWidget {
  const VisualizarDados({
    Key key,
    @required this.proposta,
  }) : super(key: key);

  final Proposta proposta;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          contentPadding: const EdgeInsets.all(15.0),
          title: Text("Descrição:", textAlign: TextAlign.left, style: TextStyle(fontSize: 18.0)),
          subtitle: Text(proposta.descricao  ?? "Não informado", textAlign: TextAlign.left, style: TextStyle(fontSize: 16.0)),
          ),
        ListTile(
          title: Text("Tema:", textAlign: TextAlign.left, style: TextStyle(fontSize: 18.0)),
          subtitle: Text(proposta.tema  ?? "Não informado", textAlign: TextAlign.left, style: TextStyle(fontSize: 16.0))
        ),
        ListTile(
          title: Text("Região:", textAlign: TextAlign.left, style: TextStyle(fontSize: 18.0)),
          subtitle: Text(proposta.regiao  ?? "Não informado", textAlign: TextAlign.left, style: TextStyle(fontSize: 16.0))
        ),
        ListTile(
          title: Text("Data de Criação:", textAlign: TextAlign.left, style: TextStyle(fontSize: 18.0)),
          subtitle: Text(proposta.dataCriacao  ?? "Não informado", textAlign: TextAlign.left, style: TextStyle(fontSize: 16.0))
        ),
        ListTile(
          title: Text("Autor:", textAlign: TextAlign.left, style: TextStyle(fontSize: 18.0)),
          subtitle: Text(proposta.autor ?? "Não informado", textAlign: TextAlign.left, style: TextStyle(fontSize: 16.0))
        ),
        Text('Votação', textAlign: TextAlign.center, style: TextStyle(fontSize: 25.0, color: Colors.blue)),
        Container(
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              botaoVotacao(Icons.thumb_up, 'Votos a Favor', proposta.vPositivo ?? 0),
              botaoVotacao(Icons.thumb_down, 'Votos Contra', proposta.vContra ?? 0),
            ]
          ),
        ),
        SizedBox(height: 25.0),
      ],
    );
  }
}
