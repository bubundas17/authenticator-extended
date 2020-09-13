import 'package:authenticator_extended/Screens/home.dart';
import 'package:authenticator_extended/Screens/settings.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(AuthenticatorApp());
}

class AuthenticatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      theme: ThemeData.light().copyWith(primaryColor: Colors.deepPurple),
      title: "Authenticator",

      routes: {
        HomePage.path: (context) => HomePage(),
        SettingsPage.path: (context) => SettingsPage()
      },
    );
  }
}
