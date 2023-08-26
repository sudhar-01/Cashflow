// ignore_for_file: prefer_interpolation_to_compose_strings, prefer_const_constructors

import 'dart:ffi';

import 'package:cash_flow/Network/Network.dart';
import 'package:cash_flow/Pages/HomePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class TransactionHistory extends StatefulWidget {
  const TransactionHistory({super.key});

  @override
  State<TransactionHistory> createState() => _TransactionHistoryState();
}

class _TransactionHistoryState extends State<TransactionHistory> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllData(context);
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Consumer<Network>(
      builder: (context, provider, child) => Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
              child: Text(
                "Transaction History",
                style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w500),
              ),
            ),
            Container(
              height: height * 0.7,
              child: provider.transactionList.length == 0
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: provider.transactionList.length,
                      itemBuilder: (context, index) => Dismissible(
                        key: Key(provider.transactionList[index]["_id"]),
                        secondaryBackground: Container(
                          color: Colors.red,
                          child: Center(
                              child: Icon(
                            Icons.delete_outline,
                            color: Colors.white,
                          )),
                        ),
                        background: Container(
                          color: Colors.red,
                          child: Center(
                              child: Icon(
                            Icons.delete_outline,
                            color: Colors.white,
                          )),
                        ),
                        confirmDismiss: (confirm) async {
                          await showDialog(
                              context: context,
                              builder: (context) => _showDeleteAlert(
                                  context,
                                  provider.transactionList[index]["_id"],
                                  provider.transactionList[index]
                                      ["expenseName"],
                                  provider.transactionList[index]["amount"]));
                        },
                        onDismissed: (direction) {},
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10.0, 20, 10, 5),
                          child: Container(
                            height: height * 0.15,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey
                                      .withOpacity(0.5), //color of shadow
                                  spreadRadius: 5, //spread radius
                                  blurRadius: 7, // blur radius
                                  offset: Offset(0, 2),
                                ),
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            padding: EdgeInsets.all(20.0),
                            child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        provider.transactionList[index]
                                                        ["expenseName"] ==
                                                    "No data" ||
                                                provider.transactionList[index]
                                                        ["expenseName"] ==
                                                    ""
                                            ? provider.transactionList[index]
                                                ["expenseType"]
                                            : provider.transactionList[index]
                                                ["expenseName"],
                                        style: TextStyle(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Text(
                                        _getDate(
                                            provider.transactionList[index]
                                                ["date"],
                                            provider.transactionList[index]
                                                ["month"],
                                            provider.transactionList[index]
                                                ["year"]),
                                        style: TextStyle(fontSize: 15.0),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        provider.transactionList[index]
                                            ["amount"],
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Icon(
                                        provider.transactionList[index]
                                                    ["expenseType"] ==
                                                "balance"
                                            ? Icons.arrow_upward_rounded
                                            : Icons.arrow_downward_rounded,
                                        color: provider.transactionList[index]
                                                    ["expenseType"] ==
                                                "balance"
                                            ? Colors.green
                                            : Colors.red,
                                      )
                                    ],
                                  ),
                                ]),
                          ),
                        ),
                      ),
                    ),
            )
          ],
        ),
      ),
    );
  }

  String _getDate(String date, String month, String year) {
    var months = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "July",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec"
    ];
    return date.toString() +
        "th " +
        months[int.parse(month)] +
        ", " +
        year.toString();
  }

  AlertDialog _showDeleteAlert(
      BuildContext context, String id, String type, String amount) {
    return AlertDialog(
      contentPadding: EdgeInsets.all(10.0),
      title: Text("Please confirm delete"),
      content: InkWell(
        onTap: () async {
          var provider = Provider.of<Network>(context, listen: false);
          provider.deleteTransaction(id);
          Navigator.pop(context);
        },
        child: Container(
          width: 100,
          height: 40,
          decoration: BoxDecoration(
              color: Colors.red, borderRadius: BorderRadius.circular(10.0)),
          alignment: Alignment.center,
          child: Text(
            "Yes delete",
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
        ),
      ),
    );
  }
}
