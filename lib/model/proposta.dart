import 'package:e_participe/model/baseModel.dart';

class Proposta extends BaseModel {
  String _titulo;
  String _tema;
  String _regiao;
  String _dataCriacao;
  String _autor;
  List<String> _vPositivo;
  List<String> _vContra;
  String _situacao;
  String _descricao;

  Proposta();

  Proposta.fromValues(
      this._titulo,
      this._tema,
      this._regiao,
      this._dataCriacao,
      this._autor,
      this._vPositivo,
      this._vContra,
      this._situacao,
      this._descricao
  );

  Proposta.fromValuesWithId(
      String id,
      this._titulo,
      this._tema,
      this._regiao,
      this._dataCriacao,
      this._autor,
      this._vPositivo,
      this._vContra,
      this._situacao,
      this._descricao) {
    super.id = id;
  }

  String get titulo => _titulo;

  String get tema => _tema;

  String get regiao => _regiao;

  String get dataCriacao => _dataCriacao;

  String get autor => _autor;

  List<String> get vPositivo => _vPositivo;

  List<String> get vContra => _vContra;

  String get situacao => _situacao;

  String get descricao => _descricao;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (id != null) {
      map['id'] = id;
    }
    map['titulo'] = _titulo;
    map['tema'] = _tema;
    map['regiao'] = _regiao;
    map['dataCriacao'] = _dataCriacao;
    map['autor'] = _autor;
    map['vPositivo'] = _vPositivo;
    map['vContra'] = _vContra;
    map['situacao'] = _situacao;
    map['descricao'] = _descricao;
    return map;
  }

  Proposta.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this._titulo = map['titulo'];
    this._tema = map['tema'];
    this._regiao = map['regiao'];
    this._dataCriacao = map['dataCriacao'];
    this._autor = map['autor'];
    this._vPositivo = map['vPositivo'];
    this._vContra = map['vContra'];
    this._situacao = map['situacao'];
    this._descricao = map['descricao'];
  }

  Proposta fromMap(Map<String, dynamic> map) {
    return Proposta.fromMap(map);
  }

  Proposta createNew() {
    return Proposta();
  }

  set titulo(String value) {
    _titulo = value;
  }
  set tema(String value) {
    _tema = value;
  }

  set regiao(String value) {
    _regiao = value;
  }

  set dataCriacao(String value) {
    _dataCriacao = value;
  }

  set autor(String value) {
    _autor = value;
  }

  set vPositivo(List<String> value) {
    _vPositivo = value;
  }

  set vContra(List<String> value) {
    _vContra = value;
  }

  set situacao(String value) {
    _situacao = value;
  }

  set descricao(String value) {
    _descricao = value;
  }

}