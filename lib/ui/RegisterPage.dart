import 'package:eas_test_flutter_barcode_scanner/register/register_response.dart';
import 'package:eas_test_flutter_barcode_scanner/models/user.dart';
import 'package:eas_test_flutter_barcode_scanner/ui/Home.dart';
import 'package:eas_test_flutter_barcode_scanner/ui/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:eas_test_flutter_barcode_scanner/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => new _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> implements RegisterCallBack {
  BuildContext? _ctx;
  bool _isLoading = false;
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  String? _username, _password;

  RegisterResponse? _response;

  _RegisterPageState() {
    _response = new RegisterResponse(this);
  }

  void _submit() {
    final form = formKey.currentState;

    if (form!.validate()) {
      setState(() {
        _isLoading = true;
        form.save();
        _response!.doRegister(_username!, _password!);
      });
    }
  }

  void _showSnackBar(String text) {
    var snackBar = SnackBar(content: Text(text));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
        _ctx = context;
        var registerBtn = ElevatedButton(
          onPressed: _submit,
          child: new Text("Register"),
        );
        var registerForm = new Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new Form(
              key: formKey,
              child: new Column(
                children: <Widget>[
                  new Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: new TextFormField(
                      onSaved: (val) => _username = val,
                      decoration: new InputDecoration(labelText: "Username"),
                    ),
                  ),
                  new Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: new TextFormField(
                      onSaved: (val) => _password = val,
                      decoration: new InputDecoration(labelText: "Password"),
                       obscureText: true,
                    ),
                  )
                ],
              ),
            ),
            registerBtn,
            _loginBtn()
          ],
        );

        return new Scaffold(
          appBar: new AppBar(
            title: new Text("Register Page"),
          ),
          key: scaffoldKey,
          body: new Container(
            child: new Center(
              child: registerForm,
            ),
          ),
        );
    }
  

  Widget _loginBtn() {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      },
      child: new Text("Login"),
    );
  }

  @override
  void onRegisterError(String error) {
    _showSnackBar(error);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void onRegisterSuccess(int user) async {
    if (user != null) {
      //go to login page
      Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
    } else {
      _showSnackBar("Register Gagal, Silahkan Periksa Register Anda");
      setState(() {
        _isLoading = false;
      });
    }
  }
}
