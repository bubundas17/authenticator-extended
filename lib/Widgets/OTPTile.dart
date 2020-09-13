import 'dart:async';

import 'package:authenticator_extended/datahandler.dart';
import 'package:authenticator_extended/model/SecretKey.dart';
import 'package:dart_otp/dart_otp.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:otp/otp.dart';

//import 'package:otp/otp.dart';
//import 'package:dart_otp/dart_otp.dart';

class OTPTile extends StatelessWidget {
  SecretKay data;

  OTPTile(this.data);

  @override
  Widget build(BuildContext context) {
//    StartTimer();
    return StreamBuilder(
      stream: authenticatorData.timeLeft.stream,
      initialData: 0,
      builder: (context, snapshot) {
        return Card(
          key: Key(data.uri),
          elevation: 3,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      CircularProgressIndicator(
                        value: snapshot.data / 30,
                        backgroundColor: Color(0x101010FF),
                        strokeWidth: 5,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                      ),
                      Text(
                        "${snapshot.data}",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text(
                        data.provider,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Center(
                        child: Text(
                          "${data.getOtp()}",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(
                        data.user,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
//                IconButton(
//                    icon: Icon(Icons.delete),
//                    onPressed: () {
//                      showDialog(
//                          context: context,
//                          child: AlertDialog(
//                            title: Text("Delete Key"),
//                            content: Text(
//                                "You are about to delete the secret key for ${data.provider}:${data.user}\n\nNote: It will be irreversible. And the key will go away for ever unless you have a backup."),
//                            actions: <Widget>[
//                              FlatButton(
//                                  onPressed: () {
//                                    Navigator.of(context).pop();
//                                  },
//                                  child: Text("Cancel")),
//                              FlatButton(
//                                  onPressed: () {
//                                    Navigator.of(context).pop();
//                                    authenticatorData.deleteKey(data);
//                                    Scaffold.of(context).showSnackBar(SnackBar(
//                                      content: Text("Secret Key Deleted."),
//                                    ));
//                                  },
//                                  child: Text("OK", style: TextStyle(color: Colors.red),)),
//                            ],
//                          ));
//                    }),
                IconButton(
                    icon: Icon(Icons.content_copy),
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: data.getOtp()));
                      Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text("OTP Copied To Clipboard."),
                      ));
                    })
              ],
//      child: Text("$otp - $timeleft"),
            ),
          ),
        );
      },
    );
  }
}
