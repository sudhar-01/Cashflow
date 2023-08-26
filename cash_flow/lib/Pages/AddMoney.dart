import 'package:cash_flow/Models/addMoneyModels.dart';
import 'package:cash_flow/Models/addMoneyTypes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../Network/Network.dart';

class AddMoney extends StatefulWidget {
  const AddMoney({super.key});

  @override
  State<AddMoney> createState() => _AddMoneyState();
}

class _AddMoneyState extends State<AddMoney> {
  late SliverGridDelegate _sliverGridDelegate;

  @override
  void initState() {
    super.initState();
    _sliverGridDelegate = new SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, mainAxisSpacing: 20.0, crossAxisSpacing: 30.0);
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Consumer<Network>(builder: (context, provider, child) {
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.builder(
            padding: EdgeInsets.all(10.0),
            itemCount: AddMoneyTypes.length,
            gridDelegate: _sliverGridDelegate,
            itemBuilder: (context, index) {
              return ExpenseContainer(index: index);
            }),
      );
    });
  }
}
