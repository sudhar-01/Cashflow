import 'package:cash_flow/Models/addMoneyTypes.dart';
import 'package:cash_flow/Network/Network.dart';
import 'package:cash_flow/Pages/HomePage.dart';
import 'package:cash_flow/Pages/AddMoney.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class ExpenseContainer extends StatelessWidget {
  TextEditingController amount = new TextEditingController(text: "");
  TextEditingController otherName = new TextEditingController(text: "");
  final int index;

  ExpenseContainer({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    AlertDialog addAlert(String type) {
      return AlertDialog(
          title: Text("Enter the amount"),
          content: Container(
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
            height: 200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextField(
                  controller: amount,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "Amount in Rs.",
                  ),
                  onSubmitted: ((value) {
                    amount.text = value;
                  }),
                ),
                TextField(
                  controller: otherName,
                  decoration: InputDecoration(hintText: "Name (optional)"),
                  onSubmitted: ((value) {
                    otherName.text = value;
                  }),
                ),
                TextButton(
                  onPressed: () async {
                    print(otherName.text);
                    if (amount.text == "") {
                      Navigator.of(context).pop();
                      Fluttertoast.showToast(msg: "Amount should not be empty");
                    } else {
                      otherName.text =
                          otherName.text == "" ? "No data" : otherName.text;
                      Provider.of<Network>(context, listen: false)
                          .putData(type, otherName.text, amount.text);
                      Provider.of<Network>(context, listen: false).getAll();
                      Navigator.of(context).pop();
                    }
                  },
                  child: Text("Submit"),
                )
              ],
            ),
          ));
    }

    return InkWell(
        onTap: (() {
          amount.text = "";
          otherName.text = "";
          showDialog(
              context: context,
              builder: (context) => addAlert(
                    AddMoneyTypes[index]['Name'] as String,
                  ));
        }),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: AddMoneyTypes[index]['shadowColor']
                    as Color, //color of shadow
                spreadRadius: 5, //spread radius
                blurRadius: 7, // blur radius
                offset: Offset(0, 2),
              ),
            ],
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            AddMoneyTypes[index]["Icon"] as Icon,
            Text(
              AddMoneyTypes[index]["Name"].toString(),
              style: TextStyle(
                  color: AddMoneyTypes[index]['color'] as Color,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500),
            ),
          ]),
        ));
  }
}
