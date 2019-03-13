import 'package:e_participe/model/baseModel.dart';

class Tema extends BaseModel {
  String _tema;

  Tema();

  Tema.fromValues(
      this._tema
  );

  Tema.fromValuesWithId(String id, this._tema) {
    super.id = id;
  }

  String get tema => _tema;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (id != null) {
      map['id'] = id;
    }
    map['tema'] = _tema;
    return map;
  }

  Tema.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this._tema = map['tema'];
  }

  Tema fromMap(Map<String, dynamic> map) {
    return Tema.fromMap(map);
  }

  Tema createNew() {
    return Tema();
  }
}