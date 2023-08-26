// ignore_for_file: prefer_const_constructors

import 'package:cash_flow/Network/Network.dart';
import 'package:cash_flow/Pages/DashBoard.dart';
import 'package:cash_flow/Pages/HomePage.dart';
import 'package:cash_flow/Pages/ProfilePage.dart';
import 'package:cash_flow/Pages/TransactionHistory.dart';
import 'package:cash_flow/Pages/AddMoney.dart';
import 'package:cash_flow/Pages/SignIn.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await Firebase.initializeApp();
  final prefs = await SharedPreferences.getInstance();
  var userId = prefs.getString('userId');
  runApp(ChangeNotifierProvider<Network>(
    create: (_) => Network(),
    child: MyApp(
      isUserNull: userId == null || userId == "",
    ),
  ));
}

class MyApp extends StatelessWidget {
  final bool isUserNull;
  const MyApp({super.key, required this.isUserNull});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      initialRoute: isUserNull ? '/loginPage' : '/homePage',
      routes: {
        '/loginPage': (context) => SignInPage(),
        '/homePage': (context) => HomePage(),
        '/dashboard': (context) => DashBoard(),
        '/transactionHistory': (context) => TransactionHistory(),
        '/addMoney': (context) => AddMoney(),
        '/Profile': (context) => Profile()
      },
    );
  }
}
