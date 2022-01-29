import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moneyexchange/Models/user.dart';
import 'package:moneyexchange/Screens/addcard.dart';
import 'package:moneyexchange/Screens/home/home_screen.dart';
import 'package:moneyexchange/Screens/home/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:moneyexchange/Services/auth.dart';
import 'package:provider/provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MoneyExchange());
}

class MoneyExchange extends StatelessWidget {
  const MoneyExchange({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  StreamProvider<AppUser?>.value(
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
        title: 'MoneyExchange',
        initialRoute: '/Wrapper',
        routes: {
          '/Wrapper': (context) => const Wrapper(),
          '/HomeScreen': (context) => HomeScreen(),
          '/Request': (context) => AddCard(),
        },
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          buttonTheme: ButtonThemeData(focusColor: Colors.black),
          textTheme: TextTheme(
            headline1: GoogleFonts.roboto(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 30.0,
            ),
              headline2: GoogleFonts.roboto(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 25.0,
              ),
              headline3: GoogleFonts.roboto(
                color: Colors.white,
                fontSize: 25.0,
              ),
            bodyText1: GoogleFonts.ubuntuMono(
              color: Colors.black,
              fontWeight: FontWeight.w800,
              fontSize: 25.0,
            ),
            bodyText2: GoogleFonts.roboto(
              color: Colors.black,
              fontSize: 20.0,
            ),
            subtitle1: GoogleFonts.roboto(
              color: Colors.black87,
              fontSize: 12.0,
            ),
            subtitle2: GoogleFonts.roboto(
              color: Colors.black54,
              fontSize: 17.0,
            )
          )
        ),
      ),
    );
  }
}


