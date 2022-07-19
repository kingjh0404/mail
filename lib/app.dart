import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'home.dart';

class MailApp extends StatelessWidget {
  const MailApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        if(snapshot.hasError){
          return const Center(
            child: Text("firebase load failed"),
          );
        }
        if(snapshot.connectionState == ConnectionState.done){
          return HomePage();
        }
        return const CircularProgressIndicator();
      },
    );
  }
}