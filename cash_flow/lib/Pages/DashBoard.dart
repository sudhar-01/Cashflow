// ignore_for_file: prefer_const_constructors

import 'package:cash_flow/Models/DashBoardModels.dart';
import 'package:cash_flow/Pages/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

import '../Network/Network.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
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
    return Consumer<Network>(builder: (context, provider, child) {
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            TitleCard(),
            BalanceCard(
              balance: provider.balance,
            ),
            MonthlyExpenseGraph(
              monthlyExpenseArray: provider.monthlyExpense,
            ),
            ExpenseSplit(chartData: provider.expenseSplit),
            // Padding(
            //   padding: const EdgeInsets.fromLTRB(10.0, 20, 10, 10),
            //   child: Container(
            //     height: height * 0.3,
            //     decoration: BoxDecoration(
            //       boxShadow: [
            //         BoxShadow(
            //           color: Colors.grey.withOpacity(0.5), //color of shadow
            //           spreadRadius: 5, //spread radius
            //           blurRadius: 7, // blur radius
            //           offset: Offset(0, 2),
            //         ),
            //       ],
            //       color: Colors.white,
            //       borderRadius: BorderRadius.circular(20.0),
            //     ),
            //     padding: EdgeInsets.all(20.0),
            //     child: Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: [
            //           Text(
            //             "Profit",
            //             style: TextStyle(
            //                 fontSize: 20.0, fontWeight: FontWeight.w500),
            //           ),
            //         ]),
            //   ),
            // )
          ],
        ),
      );
    });
  }
}
