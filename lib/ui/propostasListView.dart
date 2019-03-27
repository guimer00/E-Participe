import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_participe/ui/adicionarProposta.dart';
import 'package:e_participe/ui/visualizarProposta.dart';

import 'package:flutter/material.dart';
import 'package:e_participe/service/firestoreService.dart';

import 'package:e_participe/model/proposta.dart';
import 'package:e_participe/service/auth.dart';

class PropostaListView extends StatefulWidget {
  PropostaListView({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _PropostaListViewState createState() => _PropostaListViewState();
}

final _scaffoldKey = GlobalKey<ScaffoldState>();

class _PropostaListViewState extends State<PropostaListView> {
  Map<String, dynamic> _profile;  
  bool _loading = false;
  List<Proposta> items;
  FirestoreService<Proposta> propostaDB = new FirestoreService<Proposta>('propostas');

  StreamSubscription<QuerySnapshot> propostaSub;
  String filtro = "";
  @override
  void initState() {
    super.initState();

    authService.signOut();
    authService.profile.listen((state) => setState(() => _profile = state));
    authService.loading.listen((state) => setState(() => _loading = state));

    items = new List();

    propostaSub?.cancel();
    propostaSub = propostaDB.getList().listen((QuerySnapshot snapshot) {
      final List<Proposta> propostas = snapshot.documents
          .where((snapshot) => filtro.isNotEmpty ? snapshot.data.containsValue(filtro) : true)
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
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () { 
              if (_profile.isNotEmpty) {
                print("Tá autenticado");
                print(_profile.toString());
              } else {
                authService.googleSignIn();
                print(_profile.toString());
              }
            },
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
      floatingActionButton: new FloatingActionButton(
          tooltip: 'Adicionar uma nova proposta.',
          child: new Icon(Icons.add),
          onPressed: () { 
              if (_profile.isEmpty) {
                authService.googleSignIn();
              }
              if (_profile.isNotEmpty) {
                _adicionarPropostaPage();
              }
          }
      ),
    );
  }

  _displaySnackBar(BuildContext context) {
    final snackBar = SnackBar(
      content: Text('Proposta adicionada!'),
      duration: Duration(seconds: 2),
      backgroundColor: Colors.blue
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  void _adicionarPropostaPage() async {
    final adicionarNovaProposta = await Navigator.push(context,
      MaterialPageRoute(builder: (context) => AdicionarProposta())
    );
    if (adicionarNovaProposta != null){
      _displaySnackBar(context);
    }
  }
}