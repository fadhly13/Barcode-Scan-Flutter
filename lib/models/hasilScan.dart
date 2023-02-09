class HasilScan {
  int? _id;
  int? _iduser;
  String? _idscan;
  int? _created;

  HasilScan(this._idscan, this._iduser, this._created);

  HasilScan.fromMap(Map<String, dynamic> map) {
    _id = map['id'];
    _iduser = map['iduser'];
    _idscan = map['idscan'];
    _created = map['created'];
  }

  //getter
  int? get id => _id;
  int? get iduser => _iduser;
  String? get idscan => _idscan;
  int? get created => _created;

  //setter
  set iduser(int? value) {
    _iduser = value;
  }

  set idscan(String? value) {
    _idscan = value;
  }

  set created(int? value) {
    _created = value;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['id'] = this._id;
    map['iduser'] = iduser;
    map['idscan'] = idscan;
    map['created'] = created;
    return map;
  }
}
