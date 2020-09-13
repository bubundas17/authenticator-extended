import 'dart:async';

import 'package:authenticator_extended/model/SecretKey.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataProviderAuthenticator {
  List<SecretKay> _OTPSecrets = [];
  SharedPreferences _prefs;

  // Streams
  StreamController<int> timeLeft;
  StreamController<List <SecretKay>> secretKeys;



  int calculateTimeLeft() {
    var date = new DateTime.now().millisecondsSinceEpoch;
    // Calculate The Price
    return 30 - ((date / 1000).floor() % 30);
  }

  void saveState() async {
    await _prefs.setString("secrets", SecretKay.serialize(_OTPSecrets));
  }

  void initData() async {
    _prefs = await SharedPreferences.getInstance();
    String keys = _prefs.getString("secrets");
    if (keys != null) _OTPSecrets = SecretKay.deSerialize(keys);
    secretKeys.add(_OTPSecrets);
  }

  void reBroudcastSecretKeys() {
    secretKeys.add(_OTPSecrets);
  }

  void addKey(SecretKay key){
    _OTPSecrets.add(key);
    reBroudcastSecretKeys();
    saveState();
  }

  void deleteKey(SecretKay key) {
    _OTPSecrets = _OTPSecrets.where((i) => i.uri != key.uri ).toList();
    reBroudcastSecretKeys();
    saveState();
  }

  DataProviderAuthenticator(){
    initData();
    timeLeft = StreamController.broadcast();
    secretKeys = StreamController.broadcast();
    Timer.periodic(Duration(seconds: 1), (Timer t) {
      timeLeft.add(calculateTimeLeft());
    });
  }


  void dispose() {
    timeLeft.close();
    secretKeys.close();
    saveState();
  }

}

DataProviderAuthenticator authenticatorData = DataProviderAuthenticator();
