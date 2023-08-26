// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:cash_flow/Network/Network.dart';
import 'package:cash_flow/Pages/DashBoard.dart';
import 'package:cash_flow/Pages/ProfilePage.dart';
import 'package:cash_flow/Pages/TransactionHistory.dart';
import 'package:cash_flow/Pages/AddMoney.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 4, vsync: this);
    getAllData(context);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Network>(builder: (context, provider, child) {
      return provider.isLoaded
          ? Scaffold(
              appBar: AppBar(
                backgroundColor: Theme.of(context).primaryColor,
                automaticallyImplyLeading: false,
                title: Text("CashFlow"),
              ),
              body: Container(
                height: MediaQuery.of(context).size.height,
                child: TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  controller: _tabController,
                  children: [
                    DashBoard(),
                    AddMoney(),
                    TransactionHistory(),
                    Profile()
                  ],
                ),
              ),
              bottomNavigationBar: Container(
                height: MediaQuery.of(context).size.height * 0.07,
                color: Theme.of(context).primaryColor,
                child: TabBar(
                  indicatorColor: Theme.of(context).primaryColor,
                  controller: _tabController,
                  tabs: [
                    Icon(Icons.dashboard),
                    Icon(Icons.monetization_on),
                    Icon(Icons.history),
                    Icon(Icons.person_add_alt)
                  ],
                ),
              ))
          : Container(
              color: Colors.white,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
    });
  }
}

void getAllData(BuildContext context) async {
  var provider = Provider.of<Network>(context, listen: false);
  // Timer(Duration(seconds: 2), () => provider.getBalance());
  // Timer(Duration(seconds: 2), () => provider.getExpenseSplit());
  // Timer(Duration(seconds: 2), () => provider.getAllTransactions());
  // Timer(Duration(seconds: 2), () => provider.getMonthlyExpense());
  provider.getAll();
}
