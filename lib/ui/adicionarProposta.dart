import 'package:e_participe/service/auth.dart';
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

  FirestoreService<Proposta> _propostaDB = new FirestoreService<Proposta>('propostas');
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  Proposta _editedProposta;

  @override
  void initState() {
    super.initState();
    _editedProposta = Proposta();
  }

  final _tituloFocus = FocusNode();
  final _temaFocus = FocusNode();
  final _descricaoFocus = FocusNode();
  final _regiaoFocus = FocusNode();

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
          onPressed: () async {
            if (_formKey.currentState.validate()) {
              _formKey.currentState.save();
               await authService.getCurrentUser().then((user) {
                 _editedProposta.autor = user.displayName;
               });
              _editedProposta.vContra = [];
              await authService.getCurrentUser().then((user) {
                _editedProposta.vPositivo = [user.uid];
              });
              _editedProposta.dataCriacao =
              (formatDate(DateTime.now(), [dd, '/', mm, '/', yyyy])
                  .toString());
              _editedProposta.situacao = 'Em votação';
              _propostaDB.createObject(_editedProposta).then((result) {
                print('Sucesso!');
                Navigator.pop(context, _editedProposta);
              }).catchError((e) {
                print('error: $e');
              });
            }
          },
          child:  Icon(Icons.save),
          backgroundColor: Colors.lightBlueAccent,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(10.0),
          child: new Form(
            key: this._formKey,
            child: new Column(
            children: <Widget>[
              TextFormField(
                focusNode: _tituloFocus,
                autofocus: true,
                maxLength: 30,
                textCapitalization: TextCapitalization.sentences,
                maxLines: null,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    counterText: "",
                    labelText: "Titulo do Projeto"
                ),
                onSaved: (text){
                  _editedProposta.titulo = text;
                },
                validator: (text) {
                  if (text.isEmpty) {
                    FocusScope.of(context).requestFocus(_tituloFocus);
                    return 'Deve conter um título';
                  }
                },
              ),
              SizedBox(height: 10.0),
              TextFormField(
                focusNode: _temaFocus,
                maxLength: 15,
                textCapitalization: TextCapitalization.sentences,
                maxLines: null,
                decoration: InputDecoration(
                  counterText: "",
                  border: OutlineInputBorder(),
                  labelText: "Tema"
                ),
                onSaved: (text){
                  _editedProposta.tema = text;
                  },
                validator: (text) {
                  if (text.isEmpty) {
                    FocusScope.of(context).requestFocus(_temaFocus);
                    return 'Deve conter um tema';
                  }
                },
              ),
              SizedBox(height: 10.0),
              TextFormField(
                focusNode: _regiaoFocus,
                maxLength: 15,
                textCapitalization: TextCapitalization.sentences,
                maxLines: null,
                decoration: InputDecoration(
                    counterText: "",
                    border: OutlineInputBorder(),
                    labelText: "Região"
                ),
                onSaved: (text){
                  _editedProposta.regiao = text;
                },
                validator: (text) {
                  if (text.isEmpty) {
                    FocusScope.of(context).requestFocus(_regiaoFocus);
                    return 'Deve conter uma região';
                  }
                },
              ),
              SizedBox(height: 10.0),
              TextFormField(
                focusNode: _descricaoFocus,
                maxLines: 10,
                textInputAction: TextInputAction.done,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                    counterText: "",
                    border: OutlineInputBorder(),
                    labelText: "Descrição do Projeto",
                    hintText: "Descreva o seu projeto"
                ),
                onSaved: (text){
                  _editedProposta.descricao = text;
                },
                validator: (text) {
                  if (text.isEmpty) {
                    FocusScope.of(context).requestFocus(_descricaoFocus);
                    return 'Deve conter uma descrição';
                  }
                },
              ),
            ],
          ),
        ),
      ),
    ),
    );
  }

  Future<bool> _requestPop(){
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
  }
}