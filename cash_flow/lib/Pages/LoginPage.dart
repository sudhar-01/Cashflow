// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _email = new TextEditingController(text: "");
  TextEditingController _password = new TextEditingController(text: "");

  @override
  void initState() {
    super.initState();
    _email.text = "";
    _password.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
                  child: Text(
                    "CashFlow",
                    style:
                        TextStyle(fontSize: 30.0, fontWeight: FontWeight.w500),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.asset(
                      'assets/login_page_bg1.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 20.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.07,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color:
                                Colors.grey.withOpacity(0.5), //color of shadow
                            spreadRadius: 5, //spread radius
                            blurRadius: 7, // blur radius
                            offset: Offset(0, 2),
                          )
                        ]),
                    child: TextField(
                      controller: _email,
                      decoration: InputDecoration(
                          hintText: "Email",
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(8.0)),
                      onSubmitted: (value) {
                        _email.text = value;
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 20.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.07,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color:
                                Colors.grey.withOpacity(0.5), //color of shadow
                            spreadRadius: 5, //spread radius
                            blurRadius: 7, // blur radius
                            offset: Offset(0, 2),
                          )
                        ]),
                    child: TextField(
                      controller: _password,
                      decoration: InputDecoration(
                          hintText: "Password",
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(8.0)),
                      onSubmitted: (value) {
                        _password.text = value;
                      },
                    ),
                  ),
                ),
                InkWell(
                  onTap: (() {
                    Navigator.pushNamed(context, "/homePage");
                  }),
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width * 0.3,
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
                    child: Text(
                      "Login",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0),
                    ),
                  ),
                )
              ],
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Color(0x00ac5d00), Color(0xFFB800)]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
