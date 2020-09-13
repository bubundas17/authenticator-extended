import 'package:authenticator_extended/Widgets/OTPTile.dart';
import 'package:authenticator_extended/model/SecretKey.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';

import '../datahandler.dart';

class HomePage extends StatelessWidget {
  static var path = "/";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Authenticator"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.ac_unit),
              onPressed: () {
//                  print(SecretKay.serialize(OTPSecrets));
              },
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            BarcodeScanner.scan().then((value) {
              var secKey = SecretKay.PerseURI(value.rawContent);
              if (secKey.validate())
                authenticatorData.addKey(secKey);
              else {
                Scaffold.of(context).showSnackBar(
                    SnackBar(content: Text("Malformed Qr Code.")));
              }
            });
          },
          child: Icon(Icons.add),
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
