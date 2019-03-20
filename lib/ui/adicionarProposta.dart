import 'package:e_participe/service/firestoreService.dart';
import 'package:flutter/material.dart';
import 'package:e_participe/model/proposta.dart';
import 'package:date_format/date_format.dart';



class AdicionarProposta extends StatefulWidget {

  final Proposta proposta;
  AdicionarProposta({this.proposta});

  @override
  _AdicionarPropostaState createState() => _AdicionarPropostaState();
}

class _AdicionarPropostaState extends State<AdicionarProposta> {
  bool _userEdited = false;

  final _tituloController = TextEditingController();
  final _temaController = TextEditingController();
  final _regiaoController = TextEditingController();
  final _autorController = TextEditingController();
  final _descricaoController = TextEditingController();

  final _tituloFocus = FocusNode();
  final _temaFocus = FocusNode();
  final _regiaoFocus = FocusNode();
  final _autorFocus = FocusNode();
  final _descricaoFocus = FocusNode();

  final snackBar = SnackBar(content: Text('Proposta adicionada'));

  FirestoreService<Proposta> _propostaDB = new FirestoreService<Proposta>('propostas');

  Proposta _editedProposta;

  @override
  void initState() {
    super.initState();
    _editedProposta = Proposta();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _requestPop,
      child: Scaffold(
        appBar: AppBar(
          title: new Text('Adicionar Proposta'),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _editedProposta.vContra = 0;
            _editedProposta.vPositivo = 0;
            _editedProposta.dataCriacao =
            (formatDate(DateTime.now(), [dd, '/', mm, '/', yyyy]).toString());
            _editedProposta.situacao = 'Em votação';
            _propostaDB.createObject(_editedProposta).then((result) {
              Scaffold.of(context).showSnackBar(snackBar);
              print('Sucesso!');
            }).catchError((e) {
              print(e);
            });
            Navigator.pop(context, _editedProposta);
          },
            child:  Icon(Icons.save),
            backgroundColor: Colors.lightBlueAccent,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              TextField(
                autofocus: true,
                maxLength: 30,
                controller: _tituloController,
                focusNode: _tituloFocus,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Titulo do Projeto"
                ),
                onChanged: (text){
                  _editedProposta.titulo = text;
                  _userEdited = true;
                },
              ),
              TextField(
                maxLength: 15,
                controller: _temaController,
                focusNode: _temaFocus,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Tema"
                ),
                onChanged: (text){
                  _editedProposta.tema = text;
                  _userEdited = true;
                  },
              ),
              TextField(
                maxLength: 15,
                controller: _regiaoController,
                focusNode: _regiaoFocus,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Região"
                ),
                onChanged: (text){
                  _editedProposta.regiao = text;
                  _userEdited = true;
                },
              ),
              TextField(
                maxLength: 40,
                controller: _autorController,
                focusNode: _autorFocus,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Nome do Autor"
                ),
                onChanged: (text){
                  _editedProposta.autor = text;
                  _userEdited = true;
                },
              ),
              TextField(
                maxLines: 10,
                controller: _descricaoController,
                focusNode: _descricaoFocus,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Descrição do Projeto",
                    hintText: "Descreva o seu projeto"
                ),
                onChanged: (text){
                  _editedProposta.descricao = text;
                  _userEdited = true;
                },

              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _requestPop(){
    if(_userEdited){
      showDialog(context: context,
          builder: (context){
            return AlertDialog(
              title: Text("Descartar Alterações?"),
              content: Text("Se sair as alterações serão perdidas."),
              actions: <Widget>[
                FlatButton(
                  child: Text("Cancelar"),
                  onPressed: (){
                    Navigator.pop(context);
                  },
                ),
                FlatButton(
                  child: Text("Sim"),
                  onPressed: (){
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          }
      );
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }
}
