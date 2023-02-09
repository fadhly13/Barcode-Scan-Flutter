import 'package:eas_test_flutter_barcode_scanner/login/login_request.dart';
import 'package:eas_test_flutter_barcode_scanner/models/user.dart';

abstract class LoginCallBack {
  void onLoginSuccess(User user);
  void onLoginError(String error);
}

class LoginResponse {
  LoginCallBack _callBack;
  LoginRequest loginRequest = new LoginRequest();
  LoginResponse(this._callBack);
  doLogin(String username, String password) {
    loginRequest
        .getLogin(username, password)
        .then((user) => _callBack.onLoginSuccess(user!))
        .catchError(
            (onError) => {_callBack.onLoginError("Username/Password Salah!")});
  }
}
