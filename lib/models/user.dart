class User {
  int? _id;
  String? _username;
  String? _password;

  User(this._username, this._password);

  User.fromMap(Map<String, dynamic> map) {
    _id = map['id'];
    _username = map['username'];
    _password = map['password'];
  }

  //getter
  int? get id => _id;
  String? get username => _username;
  String? get password => _password;

  //setter
  set username(String? value) {
    _username = value;
  }

  set password(String? value) {
    _password = value;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['id'] = this._id;
    map['username'] = username;
    map['password'] = password;
    return map;
  }
}
