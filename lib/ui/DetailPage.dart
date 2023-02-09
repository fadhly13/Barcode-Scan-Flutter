import 'package:eas_test_flutter_barcode_scanner/models/hasilScan.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key, required this.hasilScan});
  final HasilScan hasilScan;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Data"),
        leading: IconButton(
          icon: Icon(Icons.keyboard_arrow_left),
          onPressed: (() {
            Navigator.pop(context);
          }),
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [_detailsCard(hasilScan)],
          )),
    );
  }

  Widget _detailsCard(final HasilScan hasilScan) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: Colors.brown,
        elevation: 4,
        child: Column(
          children: [
            ListTile(
              leading: Icon(FontAwesomeIcons.idCard),
              iconColor: Colors.white,
              title: Text(hasilScan.id.toString()),
              textColor: Colors.white,
            ),
            // ListTile(
            //   leading: Icon(FontAwesomeIcons.idBadge),
            //   iconColor: Colors.white,
            //   title: Text(hasilScan.iduser.toString()),
            //   textColor: Colors.white,
            // ),
            ListTile(
              leading: Icon(Icons.adf_scanner),
              iconColor: Colors.white,
              title: Text(hasilScan.idscan.toString()),
              textColor: Colors.white,
            ),
            ListTile(
              leading: Icon(Icons.date_range),
              iconColor: Colors.white,
              title: Text(
                  DateTime.fromMillisecondsSinceEpoch(hasilScan.created!)
                      .toString()),
              textColor: Colors.white,
            ),
            const Divider(
              height: 0.6,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
