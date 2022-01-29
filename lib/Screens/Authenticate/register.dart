import 'package:flutter/material.dart';
import 'package:moneyexchange/Services/auth.dart';
import 'package:moneyexchange/Shared/constants.dart';
import 'package:moneyexchange/Shared/loading.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({required this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  String error = "";
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Create Account,',
          style: Theme.of(context).textTheme.headline1,
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(20.0, 100.0, 20.0, 0.0),
        child: Form(
            key: _formKey,
            child:Column(
              children: [
                TextFormField(
                  cursorColor: primaryAppColor,
                  style: Theme.of(context).textTheme.bodyText2,
                  decoration: inputDecoration.copyWith(hintText: 'Enter an Email address'),
                  onChanged: (val) {
                    setState(()=>email = val);
                  },
                  validator: (val)=> val!.isEmpty?'Enter an email address':null,
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  cursorColor: primaryAppColor,
                  style: Theme.of(context).textTheme.bodyText2,
                  decoration: inputDecoration.copyWith(hintText: 'Enter Password'),
                  obscureText: true,
                  onChanged: (val) {
                    setState(()=>password = val);
                  },
                  validator: (val)=> val!.length < 6?'Enter password of length greater than 6 characters':null,
                ),
                SizedBox(
                  height: 30.0,
                ),
                ElevatedButton(
                  onPressed: () async {
                    if(_formKey.currentState!.validate()){
                      setState(() {
                        loading = true;
                      });
                      dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                      if(result==null){
                        setState((){
                          error = "User already exists";
                          loading = false;
                        });
                      }
                    }
                  },
                  child: loading ? Loading() : Text(
                    'Register',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: primaryAppColor,
                      minimumSize: const Size(700.0, 70.0),
                      elevation: 0.0,
                      shadowColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      )
                  ),
                ),
                SizedBox(
                  height:20.0,
                ),
                GestureDetector(
                  onTap: () => widget.toggleView(),
                  child: Text(
                    'Already have an accout, Sign in?',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Text(
                  error,
                  style: TextStyle(color: Colors.red,fontSize: 15.0),
                ),
              ],
            )
        ),
      ),
    );
  }
}
