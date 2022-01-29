import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:moneyexchange/Models/user.dart';
import 'package:moneyexchange/Models/usercard.dart';
import 'package:moneyexchange/Screens/home/home_screen.dart';
import 'package:moneyexchange/Services/database.dart';
import 'package:moneyexchange/Shared/constants.dart';
import 'package:moneyexchange/Shared/loading.dart';
import 'package:provider/provider.dart';

class AddCard extends StatefulWidget {
  const AddCard({Key? key,}) : super(key: key);
  @override
  _AddCardState createState() => _AddCardState();
}

class _AddCardState extends State<AddCard> {
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  String error = "";
  String dropdownValue = 'Online';
  UserCard _userCard = new UserCard(name: '', amount: 0, mode:true, address: '', phonenumber: 0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_outlined,color: Colors.black,),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        title: Padding(
          padding: const EdgeInsets.fromLTRB(37.0, 0, 0, 0),
          child: Row(
            children: [
              Text(
                'Request',
                style: Theme.of(context).textTheme.headline2?.copyWith(color: Colors.black54,),
                textAlign: TextAlign.center,
              ),
              Text(
                'Money',
                style: Theme.of(context).textTheme.headline2?.copyWith(color: Colors.black87,),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 0.0),
            child: Column(
                children: [
                  TextFormField(
                    cursorColor: primaryAppColor,
                    style: Theme.of(context).textTheme.bodyText2,
                    decoration: inputDecoration.copyWith(hintText: 'Name'),
                    onChanged: (val) {
                      setState(()=> _userCard.name = val);
                    },
                    validator: (val)=> val!.isEmpty?'Enter Name':null,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    cursorColor: primaryAppColor,
                    keyboardType: TextInputType.number,
                    style: Theme.of(context).textTheme.bodyText2,
                    decoration: inputDecoration.copyWith(hintText: 'Amount'),
                    onChanged: (val) {
                      setState(()=> _userCard.amount = int.parse(val));
                    },
                    validator: (val)=> val!.isEmpty?'Enter Amount':null,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  DropdownButtonFormField<String>(
                    value: null,
                    isDense: true,
                    isExpanded : true,
                    decoration: inputDecoration,
                    hint: Text(
                      'Select Payment Mode',
                    ),
                    icon: const Icon(Icons.arrow_drop_down_circle_outlined),
                    style: Theme.of(context).textTheme.bodyText2,
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue = newValue!;
                        dropdownValue=='Online'?_userCard.mode=true:_userCard.mode=false;
                      });
                    },
                    items: <String>['Online', 'Offline']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value,
                        style: TextStyle(
                          color: (value=='Online')?Colors.blue:Colors.green,
                          fontWeight: FontWeight.bold,
                        ),),
                      );
                    }).toList(),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    cursorColor: primaryAppColor,
                    keyboardType: TextInputType.phone,
                    style: Theme.of(context).textTheme.bodyText2,
                    decoration: inputDecoration.copyWith(hintText: 'Mobile Number'),
                    onChanged: (val) {
                      setState(()=> _userCard.phonenumber = int.parse(val));
                    },
                    validator: (val)=> val?.length!=10?'Enter Valid Mobile ':null,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    cursorColor: primaryAppColor,
                    keyboardType: TextInputType.streetAddress,
                    style: Theme.of(context).textTheme.bodyText2,
                    decoration: inputDecoration.copyWith(hintText: 'Address'),
                    onChanged: (val) {
                      setState(()=> _userCard.address = val);
                    },
                    validator: (val)=> val!.isEmpty?'Enter Address':null,
                  ),
                  SizedBox(
                    height: 50.0,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if(_formKey.currentState!.validate()){
                        setState(() {
                          loading = true;
                        });
                        DatabaseService().addUser(_userCard.name, _userCard.amount, _userCard.mode, _userCard.phonenumber, _userCard.address);
                        Navigator.pushNamedAndRemoveUntil(context, '/HomeScreen', (route) => false);
                      }
                    },
                    child: loading ? Loading() : Text(
                      'Submit',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                        primary: primaryAppColor,
                        fixedSize: const Size(700.0, 70.0),
                        elevation: 0.0,
                        shadowColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        )
                    ),
                  ),
                ]
            ),
          ),
        ),
      )
    );
  }
}
