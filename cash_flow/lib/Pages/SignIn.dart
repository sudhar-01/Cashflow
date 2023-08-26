// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'dart:convert' show json;
import 'dart:ui';

import 'package:cash_flow/Network/Network.dart';
import 'package:cash_flow/Util.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State createState() => SignInDemoState();
}

class SignInDemoState extends State<SignInPage> {
  GoogleSignInAccount? _current;
  final FirebaseAuth auth = FirebaseAuth.instance;
  GoogleSignIn _signIn = GoogleSignIn();

  @override
  void initState() {
    super.initState();
    _signIn = GoogleSignIn();
    _signIn.disconnect();
    _signIn.signInSilently();
  }

  void signIn(BuildContext context) {
    // GoogleSignInAccount? user = _current;
    _signIn.signIn()
      ..then((value) {
        if (value != null) {
          addUserToDatabase(value.email.toString(),
              value.displayName.toString(), value.photoUrl.toString());
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
              child: Display("Cashflow", boldFont, FontStyle.italic, 50,
                  Color(0xffDEC331))),
          Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
            child: ClipRRect(
              child: Image.asset(
                'assets/SignInVector.svg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          InkWell(
            onTap: (() {
              signIn(context);
            }),
            child: Container(
              height: 50,
              width: MediaQuery.of(context).size.width * 0.6,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5), //color of shadow
                    spreadRadius: 5, //spread radius
                    blurRadius: 7, // blur radius
                    offset: Offset(0, 2),
                  ),
                ],
                color: Color.fromRGBO(6, 82, 117, 1.0),
                borderRadius: BorderRadius.circular(40.0),
              ),
              padding: EdgeInsets.all((5.0)),
              child: Row(
                children: [
                  Image.asset(
                    'assets/google_icon.png',
                    fit: BoxFit.contain,
                  ),
                  Text(
                    " Sign In with Google account",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12.0),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    ));
  }

  addUserToDatabase(String email, String name, String photoUrl) {
    var url = baseURL + '/postUserData';
    var body = json.encode({
      "email": email,
      "name": name,
    });
    http
        .post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: body,
    )
        .then((value) {
      if (value.statusCode == 201 || value.statusCode == 200) {
        var userId;
        if (value.statusCode == 201) {
          userId = json.decode(value.body)["userId"].toString();
        } else {
          userId = json.decode(value.body)[0]["userId"].toString();
        }
        SharedPreferences.getInstance().then((pref) {
          pref.setString("userId", userId);
          pref.setString("email", email);
          pref.setString("name", name);
          pref.setString("photo", photoUrl);
          if (value.statusCode == 201) {
            Provider.of<Network>(context, listen: false)
                .putData("balance", "No data", "0");
          }
        });

        Navigator.pushNamed(context, "/homePage");
      } else {
        Fluttertoast.showToast(msg: "500 : Internal Server Error");
      }
    });
  }
}
