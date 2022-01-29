import 'package:flutter/material.dart';
import 'package:moneyexchange/Models/user.dart';
import 'package:moneyexchange/Screens/authenticate/authenticate.dart';
import 'package:moneyexchange/Screens/authenticate/sign_in.dart';
import 'package:moneyexchange/Screens/home/home_screen.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser?>(context);

    if(user==null){
      return Authenticate();
    } else{
      return HomeScreen();
    }
  }
}
