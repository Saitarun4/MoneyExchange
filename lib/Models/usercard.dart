import 'package:flutter/material.dart';

class UserCard{
  String name;
  int amount;
  bool mode;
  String address;
  int phonenumber;
  UserCard({
    required this.name,
    required this.amount,
    required this.mode,
    required this.address,
    required this.phonenumber,
  });

}

List<UserCard> userCards = [
  UserCard(name: 'Sai Tarun',amount: 1000,mode: true,address: 'Nadergul',phonenumber: 9550404607),
];