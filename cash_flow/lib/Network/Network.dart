// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

const baseURL = 'https://calm-gold-hedgehog-yoke.cyclic.app/api';

class Network extends ChangeNotifier {
  GoogleSignInAccount? currentUser;
  String balance = "";
  var monthlyExpense = [];
  String userId = "";
  var expenseSplit = {};
  var transactionList = [];
  var isLoaded = false;

  FutureOr<void> getAll() async {
    isLoaded = false;
    await getBalance();
    await getMonthlyExpense();
    await getExpenseSplit();
    await getAllTransactions();
    isLoaded = true;
  }

  FutureOr<void> getBalance() async {
    final prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString('userId');
    var url1 = baseURL + '/getBalance/$userId';
    http.get(Uri.parse(url1)).then((value) {
      if (value.statusCode == 200) {
        balance = json.decode(value.body)["balance"];
        notifyListeners();
      } else {
        Fluttertoast.showToast(msg: json.decode(value.body)["message"]);
      }
    });
  }

  FutureOr<void> getMonthlyExpense() async {
    final prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString('userId');
    var url1 = baseURL + '/monthlySpending/$userId';
    print("======================= $userId");
    http.get(Uri.parse(url1)).then((value) {
      if (value.statusCode == 200) {
        monthlyExpense = json.decode(value.body);
        notifyListeners();
      } else {
        Fluttertoast.showToast(msg: json.decode(value.body)["message"]);
      }
    });
  }

  FutureOr<void> getExpenseSplit() async {
    final prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString('userId');
    var url1 = baseURL + '/getSplitData/$userId';
    http.get(Uri.parse(url1)).then((value) {
      if (value.statusCode == 200) {
        expenseSplit = json.decode(value.body);
        notifyListeners();
      } else {
        Fluttertoast.showToast(msg: json.decode(value.body)["message"]);
      }
    });
  }

  FutureOr<void> getAllTransactions() async {
    final prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString('userId');
    var url1 = baseURL + '/getDataByUserId/$userId';
    http.get(Uri.parse(url1)).then((value) {
      if (value.statusCode == 200) {
        transactionList = json.decode(value.body);
        transactionList = List.from(transactionList.reversed);
        notifyListeners();
      } else {
        Fluttertoast.showToast(msg: json.decode(value.body)["message"]);
      }
    });
  }

  FutureOr<void> putData(
      String expenseType, String expenseName, String amount) async {
    final prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString('userId');
    var url1 = baseURL + '/postData';
    var body = json.encode({
      "userId": userId,
      "dateTime": DateTime.now().toString(),
      "expenseType": expenseType,
      "expenseName": expenseName,
      "amount": amount
    });
    http
        .post(Uri.parse(url1),
            headers: {"Content-Type": "application/json"}, body: body)
        .then((value) {
      if (value.statusCode == 201) {
        Fluttertoast.showToast(msg: json.decode(value.body)["message"]);
      } else {
        Fluttertoast.showToast(msg: json.decode(value.body)["message"]);
      }
    });
  }

  FutureOr<void> deleteTransaction(String id) async {
    final prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString('userId');
    var url1 = baseURL + '/deleteTransaction/$id';
    http.delete(Uri.parse(url1)).then((value) {
      if (value.statusCode == 200) {
        Fluttertoast.showToast(msg: json.decode(value.body)["message"]);
        notifyListeners();
      } else {
        Fluttertoast.showToast(msg: json.decode(value.body)["message"]);
      }
    });
  }
}
