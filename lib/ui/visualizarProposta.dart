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
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(proposta.descricao),
      ),
    );
  }
}