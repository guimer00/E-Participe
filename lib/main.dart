import 'package:e_participe/ui/propostasListView.dart';
import 'package:flutter/material.dart';

void main() async {
  runApp(new EParticipe());
}

class EParticipe extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'e-Participe',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PropostaListView(title: 'e-Participe'),
    );
  }
}
