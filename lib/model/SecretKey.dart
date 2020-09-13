import 'package:dart_otp/dart_otp.dart';
import 'package:flutter/material.dart';
import 'package:otp/otp.dart';

class SecretKay {
  final String secret;
  final String identifier;
  final String provider;
  final String user;
  final String uri;

  SecretKay(
      {@required this.secret,
      @required this.identifier,
      @required this.uri,
      this.provider,
      this.user});

  bool validate() {
    try {
      this.getOtp();
      return true;
    } catch (e) {
      return false;
    }
  }

  String getOtp() {
    var otp = OTP.generateTOTPCodeString(
        this.secret, DateTime.now().millisecondsSinceEpoch,
        algorithm: Algorithm.SHA1, isGoogle: true);
//    TOTP totp = TOTP(secret: this.secret);
//    return totp.now();
    return otp;
  }

  static SecretKay PerseURI(String uri) {
    var data = Uri.parse(uri);
    var splited = data.pathSegments[0].split(":");
    var provider = "";
    var user = "";

//    print(data.queryParameters["secret"]);
    if (splited.length >= 1) {
      provider = splited[0];
    }

    if (splited.length >= 2) {
      user = splited[1];
    }

    return SecretKay(
        secret: data.queryParameters["secret"],
        identifier: data.pathSegments[0],
        uri: uri,
        provider: provider,
        user: user);
  }

  static String serialize(List<SecretKay> keys) {
//    String out = "";
    List<String> keysout = [];
//    print(keys);
    for (var i = 0; i < keys.length; i++) {
//      print("The '${keys[i].uri.trim()}'");
      if (keys[i].uri.trim().isNotEmpty) keysout.add(keys[i].uri);
//      out += "\n";
    }
    return keysout.join("\n");
  }

  static List<SecretKay> deSerialize(String keys) {
//    print(keys);
    List<String> keysStr = keys.split("\n");
//    print(keysStr);
    List<SecretKay> list = [];
    keysStr = keysStr
        .where((element) => element != null && element.isNotEmpty)
        .toList();
//    print(keysStr);
    for (var i = 0; i < keysStr.length; i++) {
      var secKey = SecretKay.PerseURI(keysStr[i]);
      if (secKey.validate()) list.add(secKey);
    }
    return list;
  }
}
