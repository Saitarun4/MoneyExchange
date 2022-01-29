import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:moneyexchange/Models/usercard.dart';
import 'package:moneyexchange/Shared/constants.dart';

class CardModel extends StatelessWidget {
  final UserCard userCard;
  const CardModel({Key? key, required this.userCard}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: userCard.mode?Colors.blue.withOpacity(.2):Colors.green.withOpacity(.2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 0.0,
      shadowColor: Colors.black,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              userCard.name,
              style: Theme.of(context).textTheme.headline2?.copyWith(color:userCard.mode?onlineTextColor:offlineTextColor),
            ),
            SizedBox(
              height: 5.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                userCard.mode?
                    Text(
                      'online',
                      style: Theme.of(context).textTheme.subtitle2?.copyWith(fontWeight: FontWeight.bold,color: Colors.black54),
                    ):
                    Text(
                      'offline',
                      style: Theme.of(context).textTheme.subtitle2?.copyWith(fontWeight: FontWeight.bold,color: Colors.black54),
                    ),
                SizedBox(
                  width: 20.0,
                ),
                Text(
                  '${userCard.amount}',
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize:30.0,color: userCard.mode?Colors.blue:Colors.green,fontWeight: FontWeight.w800),
                ),
              ],
            ),
            SizedBox(
              height: 5.0,
            ),
            Text(
              '${userCard.phonenumber}',
              style: Theme.of(context).textTheme.subtitle2,
            ),
            SizedBox(
              height: 5.0,
            ),
            Text(
              userCard.address,
              style: Theme.of(context).textTheme.subtitle2,
            ),
          ],
        ),
      ),
    );
  }
}
