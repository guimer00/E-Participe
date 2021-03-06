import 'package:e_participe/model/proposta.dart';
import 'package:e_participe/service/firestoreService.dart';
import 'package:flutter/material.dart';
import 'package:e_participe/service/auth.dart';


var _colorUp = Colors.black38;
var _colorDown = Colors.black38;
FirestoreService<Proposta> _propostaDB = new FirestoreService<Proposta>('propostas');

class VisualizarProposta extends StatelessWidget {
  final Proposta proposta;


  //Exige Proposta no construtor
  VisualizarProposta({Key key, @required this.proposta}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(proposta.titulo),
        ),
        body: SingleChildScrollView(
            child: new VisualizarDados(proposta: proposta))
    );
  }
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
          title: Text("Descrição:", textAlign: TextAlign.left,
              style: TextStyle(fontSize: 18.0)),
          subtitle: Text(
              proposta.descricao ?? "Não informado", textAlign: TextAlign.left,
              style: TextStyle(fontSize: 16.0)),
        ),
        ListTile(
            title: Text("Tema:", textAlign: TextAlign.left,
                style: TextStyle(fontSize: 18.0)),
            subtitle: Text(
                proposta.tema ?? "Não informado", textAlign: TextAlign.left,
                style: TextStyle(fontSize: 16.0))
        ),
        ListTile(
            title: Text("Região:", textAlign: TextAlign.left,
                style: TextStyle(fontSize: 18.0)),
            subtitle: Text(
                proposta.regiao ?? "Não informado", textAlign: TextAlign.left,
                style: TextStyle(fontSize: 16.0))
        ),
        ListTile(
            title: Text("Data de Criação:", textAlign: TextAlign.left,
                style: TextStyle(fontSize: 18.0)),
            subtitle: Text(proposta.dataCriacao ?? "Não informado",
                textAlign: TextAlign.left, style: TextStyle(fontSize: 16.0))
        ),
        ListTile(
            title: Text("Autor:", textAlign: TextAlign.left,
                style: TextStyle(fontSize: 18.0)),
            subtitle: Text(
                proposta.autor ?? "Não informado", textAlign: TextAlign.left,
                style: TextStyle(fontSize: 16.0))
        ),
        Text('Votação', textAlign: TextAlign.center,
            style: TextStyle(fontSize: 25.0, color: Colors.blue)),
        Container(
          child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                new Column(
                  children: <Widget>[
                    new Text('Votos a Favor', style: TextStyle(
                        fontSize: 18.0, fontWeight: FontWeight.w600)),
                    new Text(proposta.vPositivo.length.toString(),
                        style: TextStyle(fontSize: 18.0)),
                    SizedBox(height: 10.0),
                    new FlatButton(
                        onPressed: () {
                          authService.getCurrentUser().then((user) {
                            if (user == null) {
                              authService.googleSignIn().then((_) {
                                if (proposta.vPositivo.contains(user.uid)) {
                                  proposta.vPositivo.remove(user.uid);
                                  _propostaDB.updateObject(proposta).then((result) {
                                    print('Sucesso!');
                                    Navigator.pop(context, );
                                  }).catchError((e) {
                                    print('error: $e');
                                  });
                                  _colorUp = Colors.black38;
                                } else {
                                  proposta.vPositivo.add(user.uid);
                                  if(proposta.vContra.contains(user.uid)){
                                    proposta.vContra.remove(user.uid);
                                    _propostaDB.updateObject(proposta).then((result) {
                                      print('Sucesso!');
                                      Navigator.pop(context, );
                                    }).catchError((e) {
                                      print('error: $e');
                                    });
                                    _colorDown = Colors.black38;
                                  }
                                  _colorUp = Colors.green;
                                };
                              });
                            } else {
                              if (proposta.vPositivo.contains(user.uid)) {
                                proposta.vPositivo.remove(user.uid);
                                _propostaDB.updateObject(proposta).then((result) {
                                  print('Sucesso!');
                                  Navigator.pop(context, );
                                }).catchError((e) {
                                  print('error: $e');
                                });
                                _colorUp = Colors.black38;
                              } else {
                            proposta.vPositivo.add(user.uid);
                            if(proposta.vContra.contains(user.uid)){
                            proposta.vContra.remove(user.uid);
                            _propostaDB.updateObject(proposta).then((result) {
                            print('Sucesso!');
                            Navigator.pop(context, );
                            }).catchError((e) {
                            print('error: $e');
                            });
                            _colorDown = Colors.black38;
                            }
                            _colorUp = Colors.green;
                            };
                            }
                          });
                        },
                        child: Column(
                          children: <Widget>[
                            Icon(Icons.thumb_up, size: 50.0, color: _colorUp)
                          ],
                        ))
                  ],
                ),
                new Column(
                  children: <Widget>[
                    new Text('Votos Contra', style: TextStyle(
                        fontSize: 18.0, fontWeight: FontWeight.w600)),
                    new Text(proposta.vContra.length.toString(),
                        style: TextStyle(fontSize: 18.0)),
                    SizedBox(height: 10.0),
                    new FlatButton(
                        onPressed: () {
                          authService.getCurrentUser().then((user) {
                            if(user == null) {
                              authService.googleSignIn().then((_) {
                                if (proposta.vContra.contains(user.uid)) {
                                  proposta.vContra.remove(user.uid);
                                  _colorDown = Colors.black38;
                                } else {
                                  proposta.vContra.add(user.uid);
                                  if(proposta.vPositivo.contains(user.uid)){
                                    proposta.vPositivo.remove(user.uid);
                                    _colorDown = Colors.black38;
                                  }
                                  _colorDown = Colors.red;
                                };
                              });
                            } else {
                              if (proposta.vContra.contains(user.uid)) {
                                proposta.vContra.remove(user.uid);
                                _colorDown = Colors.black38;
                              } else {
                                proposta.vContra.add(user.uid);
                                if(proposta.vPositivo.contains(user.uid)){
                                  proposta.vPositivo.remove(user.uid);
                                  _colorDown = Colors.black38;
                                }
                                _colorDown = Colors.red;
                              };
                            }
                          });
                        },
                        child: Column(
                          children: <Widget>[
                            Icon(Icons.thumb_down, size: 50.0, color: _colorDown)
                          ],
                        ))
                  ],
                ),
              ]
          ),
        ),
        SizedBox(height: 25.0),
      ],
    );
  }
}
