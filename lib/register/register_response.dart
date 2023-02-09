import 'package:eas_test_flutter_barcode_scanner/register/register_request.dart';
import 'package:eas_test_flutter_barcode_scanner/models/user.dart';

abstract class RegisterCallBack {
  void onRegisterSuccess(int user);
  void onRegisterError(String error);
}

class RegisterResponse {
  RegisterCallBack _callBack;
  RegisterRequest registerRequest = new RegisterRequest();
  RegisterResponse(this._callBack);
  doRegister(String username, String password) {
    registerRequest
        .register(username, password)
        .then((user) => _callBack.onRegisterSuccess(user!))
        .catchError(
            (onError) => {_callBack.onRegisterError("Register Gagal!")});
  }
}
