import 'dart:async';
import 'package:eas_test_flutter_barcode_scanner/models/user.dart';
import 'package:eas_test_flutter_barcode_scanner/helpers/dbhelperuser.dart';

class RegisterRequest {
  DbHelperUser con = new DbHelperUser();
  Future<int?> register(String username, String password) async {
    User newUser = User(username, password);
    var result = await con.insert(newUser);
    return result;
  }
}
