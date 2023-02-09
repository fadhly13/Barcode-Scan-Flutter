import 'dart:async';
import 'package:eas_test_flutter_barcode_scanner/models/user.dart';
import 'package:eas_test_flutter_barcode_scanner/helpers/dbhelperuser.dart';

class LoginRequest {
  DbHelperUser con = new DbHelperUser();
  Future<User?> getLogin(String username, String password) async {
    var result = await con.getLogin(username, password);
    return result;
  }
}
