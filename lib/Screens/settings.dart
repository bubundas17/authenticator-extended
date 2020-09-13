import 'package:authenticator_extended/Widgets/OTPTile.dart';
import 'package:authenticator_extended/model/SecretKey.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';

import '../datahandler.dart';

class SettingsPage extends StatelessWidget {
  static var path = "/settings";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Settings"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.ac_unit),
              onPressed: () {
//                  print(SecretKay.serialize(OTPSecrets));
              },
            )
          ],
        ),
        body: Container());
  }
}
