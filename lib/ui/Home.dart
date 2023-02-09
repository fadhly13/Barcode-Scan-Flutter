import 'dart:async';

import 'package:eas_test_flutter_barcode_scanner/helpers/dbhelper.dart';
import 'package:eas_test_flutter_barcode_scanner/models/hasilScan.dart';
import 'package:eas_test_flutter_barcode_scanner/ui/DetailPage.dart';
import 'package:eas_test_flutter_barcode_scanner/ui/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(BarcodeScannerPage(
      signOut: () {},
    ));

class BarcodeScannerPage extends StatefulWidget {
  final Function signOut;

  const BarcodeScannerPage({super.key, required this.signOut});

  @override
  _BarcodeScannerPageState createState() => _BarcodeScannerPageState();
}

class _BarcodeScannerPageState extends State<BarcodeScannerPage> {
  String _scanBarcode = 'Unknown';
  DbHelper dbHelper = DbHelper();
  int count = 0;
  late List<HasilScan> hasilscanList;
  String? userId, username;

  @override
  void initState() {
    super.initState();
  }

  Future<void> startBarcodeScanStream() async {
    FlutterBarcodeScanner.getBarcodeStreamReceiver(
            '#ff6666', 'Cancel', true, ScanMode.BARCODE)!
        .listen((barcode) => print(barcode));
  }

  Future<void> logout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setInt("value", 99);
    preferences.commit();
  }

  Future<void> getUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      username = preferences.getString("user");
      userId = preferences.getString("userId");
      preferences.commit();
    });
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    if (!mounted) return;

    // insert scan hasil
    final dt = DateTime.now();
    final dtInEpoch = dt.millisecondsSinceEpoch;
    String kode;
    Random random = new Random();
    String kode_ext = random.nextInt(99999).toString();
    if (barcodeScanRes == "barang basah") {
      kode = "BB-" + kode_ext;
    } else {
      kode = "BK-" + kode_ext;
    }
    // ganti id_user kalau udah jadi login registernya
    int userID = 1;
    if (userId != null) {
      userID = userId as int;
    }
    HasilScan hasilScan = HasilScan(kode, userID, dtInEpoch);
    addHasilScan(hasilScan);

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.brown),
        home: Scaffold(
            appBar: AppBar(
              title: Text("Home Page"),
              titleTextStyle: const TextStyle(fontSize: 18),
              actions: <Widget>[
                Padding(
                    padding: EdgeInsets.only(right: 20.0),
                    child: GestureDetector(
                      onTap: () {
                        logout();
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()));
                      },
                      child: const Icon(
                        Icons.exit_to_app,
                        size: 26.0,
                      ),
                    )),
              ],
            ),
            body: createListView(),
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add),
              tooltip: 'Scan QR',
              onPressed: () => scanQR(),
            )));
  }

  Future<HasilScan?> navigateToDetailPage(
      BuildContext context, HasilScan hasilscan) async {
    var result = await Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) {
      return DetailPage(
        hasilScan: hasilscan,
      );
    }));
    return result;
  }

  ListView createListView() {
    TextStyle? textStyle = Theme.of(context).textTheme.subtitle1;
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.brown[800],
              child: Icon(FontAwesomeIcons.book),
            ),
            title: Text(
              hasilscanList[index].idscan!,
              style: textStyle,
            ),
            subtitle: Text(DateTime.fromMillisecondsSinceEpoch(
                    hasilscanList[index].created!)
                .toString()),
            trailing: GestureDetector(
              child: Icon(Icons.delete),
              onTap: () {
                deleteHasilScan(hasilscanList[index]);
              },
            ),
            onTap: () async {
              // ke halaman detail
              // halaman detail
              // - edit created (datetime) gawe date time selector
              // - nampilno detail lainnya

              var hasilscan =
                  await navigateToDetailPage(context, hasilscanList[index]);
              if (hasilscan != null) editHasilScan(hasilscan);
            },
          ),
        );
      },
    );
  }

  void addHasilScan(HasilScan object) async {
    int? result = await dbHelper.insert(object);
    if (result! > 0) {
      updateListView();
    }
  }

  void editHasilScan(HasilScan object) async {
    int? result = await dbHelper.update(object);
    if (result! > 0) {
      updateListView();
    }
  }

  void deleteHasilScan(HasilScan object) async {
    int? result = await dbHelper.delete(object.id!);
    if (result! > 0) {
      updateListView();
    }
  }

  void updateListView() {
    final Future<Database> dbFuture = dbHelper.initDb();
    dbFuture.then((database) {
      Future<List<HasilScan>> hasilscanListFuture = dbHelper.gethasilscanList();
      hasilscanListFuture.then((hasilscanList) {
        setState(() {
          this.hasilscanList = hasilscanList;
          this.count = hasilscanList.length;
        });
      });
    });
  }
}
