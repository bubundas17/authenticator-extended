import 'package:authenticator_extended/Widgets/OTPTile.dart';
import 'package:authenticator_extended/model/SecretKey.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';

import '../datahandler.dart';

class EditSecretKey extends StatelessWidget {
  static var path = "/edit";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Edit Secret Key"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.ac_unit),
              onPressed: () {
//                  print(SecretKay.serialize(OTPSecrets));
              },
            )
          ],
        ),
        body: StreamBuilder(
          initialData: [],
          stream: authenticatorData.secretKeys.stream,
          builder: (context, snapshot) {
            return ListView.builder(
                itemBuilder: (context, index) {
                  return OTPTile(snapshot.data[index]);
                },
                itemCount: snapshot.data.length);
          },
        ));
  }
}
