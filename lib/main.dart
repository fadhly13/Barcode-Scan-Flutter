import 'package:flutter/material.dart';
import 'package:eas_test_flutter_barcode_scanner/ui/Home.dart';
import 'package:eas_test_flutter_barcode_scanner/ui/LoginPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EAS',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: LoginPage(),
    );
  }
}

// class HomeScreen extends StatelessWidget {
//   HomeScreen(Function() signOut);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Home Page"),
//         titleTextStyle: const TextStyle(fontSize: 18),
//         actions: <Widget>[
//           Padding(
//               padding: EdgeInsets.only(right: 20.0),
//               child: GestureDetector(
//                 onTap: () {
//                   Navigator.pushReplacement(context,
//                       MaterialPageRoute(builder: (context) => LoginPage()));
//                 },
//                 child: const Icon(
//                   Icons.exit_to_app,
//                   size: 26.0,
//                 ),
//               )),
//         ],
//       ),
//     );
//   }
// }
