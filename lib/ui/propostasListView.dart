import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_participe/ui/visualizarProposta.dart';

import 'package:flutter/material.dart';
import 'package:e_participe/service/firestoreService.dart';

import 'package:e_participe/model/proposta.dart';

class PropostaListView extends StatefulWidget {
  PropostaListView({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _PropostaListViewState createState() => _PropostaListViewState();
}

class _PropostaListViewState extends State<PropostaListView> {
  List<Proposta> items;
  FirestoreService<Proposta> propostaDB = new FirestoreService<Proposta>('propostas');

  StreamSubscription<QuerySnapshot> propostaSub;

  @override
  void initState() {
    super.initState();

    items = new List();

    propostaSub?.cancel();
    propostaSub = propostaDB.getList().listen((QuerySnapshot snapshot) {
      final List<Proposta> propostas = snapshot.documents
          .map((documentSnapshot) => Proposta.fromMap(documentSnapshot.data))
          .toList();

      setState(() {
        this.items = propostas;
      });
    });
  }

  @override
  void dispose() {
    propostaSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {},
        ),
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {}
          )
        ],
      ),
      body: Center(
        child: ListView.builder(
          itemCount: items.length,
          padding: const EdgeInsets.all(15.0),
          itemBuilder: (context, position) {
            return Column(
              children: <Widget>[
                Divider(height: 5.0),
                ListTile(
                  title: Text(
                    '${items[position].titulo}',
                    style: TextStyle(
                      fontSize: 22.0,
                      color: Colors.deepOrangeAccent,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context, 
                      MaterialPageRoute(
                        builder: (context) => VisualizarProposta(proposta: items[position])
                      )
                    );
                  },
                  subtitle: Text(
                    '${items[position].descricao}',
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: new TextStyle(
                      fontSize: 18.0,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                )
              ],
            );
          } // itemBuilder
        ),
      ),
    );
  }

}