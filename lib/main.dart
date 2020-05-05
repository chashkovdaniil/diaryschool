import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';


void main() {
  InAppPurchaseConnection.enablePendingPurchases();
  runApp(DiarySchoolApp());
}

class DiarySchoolApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Дневник',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.white),
      home: SafeArea(
        child: Scaffold(
          body: Center(child: Text("home")),
        ),
      ),
    );
  }
}
