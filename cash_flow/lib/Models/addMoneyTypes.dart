import 'package:cash_flow/Pages/AddMoney.dart';
import 'package:flutter/material.dart';

var AddMoneyTypes = [
  {
    "Name": "Food",
    "Icon": Icon(
      Icons.emoji_food_beverage_outlined,
      color: Colors.blue,
    ),
    "color": Colors.blue,
    'shadowColor': Colors.blue.withOpacity(0.3)
  },
  {
    "Name": "Rent",
    "Icon": Icon(
      Icons.house_outlined,
      color: Colors.red,
    ),
    "color": Colors.red,
    'shadowColor': Colors.red.withOpacity(0.3)
  },
  {
    "Name": "Clothes",
    "Icon": Icon(
      Icons.shopping_bag_outlined,
      color: Color.fromARGB(255, 149, 92, 0),
    ),
    "color": Color.fromARGB(255, 149, 92, 0),
    'shadowColor': Color.fromARGB(255, 149, 92, 0).withOpacity(0.3)
  },
  {
    "Name": "Investment",
    "Icon": Icon(
      Icons.money_outlined,
      color: Colors.green,
    ),
    "color": Colors.green,
    'shadowColor': Colors.green.withOpacity(0.3)
  },
  {
    "Name": "Friends",
    "Icon": Icon(
      Icons.person_add_alt_1_outlined,
      color: Colors.orange,
    ),
    "color": Colors.orange,
    'shadowColor': Colors.orange.withOpacity(0.3)
  },
  {
    "Name": "Other",
    "Icon": Icon(
      Icons.monetization_on_outlined,
      color: Colors.black,
    ),
    "color": Colors.black,
    'shadowColor': Colors.grey.withOpacity(0.3)
  },
  {
    "Name": "balance",
    "Icon": Icon(
      Icons.balance_outlined,
      color: Colors.purple,
    ),
    "color": Colors.purple,
    'shadowColor': Colors.purple.withOpacity(0.3)
  },
];
