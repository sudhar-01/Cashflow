// ignore_for_file: prefer_const_constructors

import 'package:cash_flow/Network/Network.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'SignIn.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  GoogleSignIn? _current;
  late String _photoUrl = "";
  late String _name = "";
  late String _email = "";

  @override
  void initState() {
    super.initState();
    _current = GoogleSignIn();
    getPrefs();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      SizedBox(
        height: 120,
        width: 120,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(60),
          child: _photoUrl == ""
              ? Icon(Icons.person)
              : Image.network(
                  _photoUrl,
                  fit: BoxFit.contain,
                ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(
          _name,
          style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).primaryColor),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(10),
        child: Text(
          _email,
          style: TextStyle(
              fontSize: 20.0, fontWeight: FontWeight.w500, color: Colors.grey),
        ),
      ),
      InkWell(
        onTap: () {
          _current?.disconnect();
          removePrefs();
          Navigator.of(context).popAndPushNamed('/loginPage');
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: width * 0.6,
            height: height * 0.07,
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5), //color of shadow
                spreadRadius: 4, //spread radius
                blurRadius: 6, // blur radius
                offset: Offset(0, 2),
              ),
            ], borderRadius: BorderRadius.circular(10.0), color: Colors.red),
            alignment: Alignment.center,
            child: Text(
              "Logout",
              style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            ),
          ),
        ),
      ),
    ]);
  }

  getPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _photoUrl = prefs.getString("photo").toString();
      _name = prefs.getString("name").toString();
      _email = prefs.getString("email").toString();
    });
  }

  removePrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("userId");
    prefs.remove("email");
    prefs.remove("name");
    prefs.remove("photo");
  }
}
