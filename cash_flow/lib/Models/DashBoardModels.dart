import 'package:cash_flow/Network/Network.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class TitleCard extends StatelessWidget {
  const TitleCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
      child: Text(
        "DashBoard",
        style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w500),
      ),
    );
  }
}

class BalanceCard extends StatelessWidget {
  final String balance;
  const BalanceCard({super.key, required this.balance});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.fromLTRB(10.0, 20, 10, 0),
      child: Container(
        height: height * 0.1,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5), //color of shadow
              spreadRadius: 5, //spread radius
              blurRadius: 7, // blur radius
              offset: Offset(0, 2),
            ),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
        ),
        padding: EdgeInsets.all(20.0),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
            " Balance",
            style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w500),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              balance,
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
            ),
          ),
        ]),
      ),
    );
  }
}

class MonthlyExpenseGraph extends StatelessWidget {
  const MonthlyExpenseGraph({super.key, required this.monthlyExpenseArray});
  final monthlyExpenseArray;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.fromLTRB(10.0, 20, 10, 0),
      child: Container(
        height: height * 0.4,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5), //color of shadow
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
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Monthly Expense Graph",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
              ),
              Container(
                height: height * 0.3,
                child: SfCartesianChart(
                    primaryXAxis: CategoryAxis(),
                    series: <LineSeries<SalesData, String>>[
                      LineSeries<SalesData, String>(
                          dataSource: List<SalesData>.generate(
                              monthlyExpenseArray.length, (index) {
                            return SalesData(
                                monthlyExpenseArray[index]["month"],
                                double.parse(monthlyExpenseArray[index]["total"]
                                    .toString()));
                          }),
                          xValueMapper: (SalesData sales, _) => sales.month,
                          yValueMapper: (SalesData sales, _) => sales.sales)
                    ]),
              )
            ]),
      ),
    );
  }
}

class SalesData {
  SalesData(this.month, this.sales);
  final String month;
  final double sales;
}

class ExpenseSplit extends StatelessWidget {
  final Map chartData;
  const ExpenseSplit({super.key, required this.chartData});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.fromLTRB(10.0, 20, 10, 0),
      child: Container(
        height: height * 0.5,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5), //color of shadow
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
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Expense Split",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
              ),
              Container(
                  height: height * 0.4,
                  child: SfCircularChart(
                    legend: Legend(
                        position: LegendPosition.bottom,
                        isVisible: true,
                        overflowMode: LegendItemOverflowMode.wrap),
                    series: <CircularSeries>[
                      DoughnutSeries<ExpenseSplitData, String>(
                        dataSource: [
                          ExpenseSplitData(
                              "Food",
                              chartData["Food"] != null
                                  ? double.parse(chartData["Food"].toString())
                                  : 0.0),
                          ExpenseSplitData(
                              "Rent",
                              chartData["Rent"] != null
                                  ? double.parse(chartData["Rent"].toString())
                                  : 0.0),
                          ExpenseSplitData(
                              "Clothes",
                              chartData["Clothes"] != null
                                  ? double.parse(
                                      chartData["Clothes"].toString())
                                  : 0.0),
                          ExpenseSplitData(
                              "Investment",
                              chartData["Investment"] != null
                                  ? double.parse(
                                      chartData["Investment"].toString())
                                  : 0.0),
                          ExpenseSplitData(
                              "Friends",
                              chartData["Friends"] != null
                                  ? double.parse(
                                      chartData["Friends"].toString())
                                  : 0.0),
                          ExpenseSplitData(
                              "Other",
                              chartData["Other"] != null
                                  ? double.parse(chartData["Other"].toString())
                                  : 0.0),
                        ],
                        xValueMapper: (ExpenseSplitData data, _) => data.type,
                        yValueMapper: (ExpenseSplitData data, _) => data.amount,
                      )
                    ],
                  ))
            ]),
      ),
    );
  }
}

class ExpenseSplitData {
  ExpenseSplitData(this.type, this.amount);
  final String type;
  final double amount;
}
