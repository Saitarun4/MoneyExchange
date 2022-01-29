import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:location/location.dart';
import 'package:moneyexchange/Models/card.dart';
import 'package:moneyexchange/Models/usercard.dart';
import 'package:moneyexchange/Screens/Authenticate/register.dart';
import 'package:moneyexchange/Screens/addcard.dart';
import 'package:moneyexchange/Services/auth.dart';
import 'package:moneyexchange/Shared/constants.dart';
import 'package:moneyexchange/Shared/loading.dart';

class HomeScreen extends StatefulWidget{
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<HomeScreen> {
  String _locationMessage = "Tap to find Location";
  bool loading = false;
  void _getCurrentLocation() async{
    Location location = Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;
    //checking for service
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }
    //requesting for location permission
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    _locationData = await location.getLocation();
    location.onLocationChanged.listen((LocationData _locationData) {
      // Use current location
      setState(() {
        _locationMessage = "${_locationData.latitude},${_locationData.longitude}";
      });
    });


  }

    final AuthService _auth = AuthService();
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('Requests').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Money',
              style: Theme.of(context).textTheme.headline1?.copyWith(color: Colors.green,fontSize: 25.0),
              textAlign: TextAlign.center,
            ),
            Text(
              'Exchange',
              style: Theme.of(context).textTheme.headline1?.copyWith(color: Colors.blue,fontSize: 25.0),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 15.0, 0, 0),
            child: Text(
              'logout',
              style: Theme.of(context).textTheme.bodyText2?.copyWith(fontWeight: FontWeight.w600),

            ),
          ),
          IconButton(
            onPressed: () async {
              await _auth.signOut();
            },
            icon: Icon(Icons.logout),
            color: Colors.black,
          ),
        ],
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
        child:Stack(
          alignment: Alignment.center,
          fit: StackFit.expand,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(2.0, 0.0, 2.0, 5.0),
              child: StreamBuilder<QuerySnapshot>(
                stream: _usersStream,
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong');
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Loading();
                  }
                  return ListView(
                    physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                    children: snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                      return CardModel(
                        userCard: new UserCard(name: data['name'], amount: data['amount'], mode: data['mode'], address: data['address'], phonenumber: data['phonenumber']),
                      );
                    }).toList(),
                  );
                },
              ),
            ),
            Positioned(
              height: 70.0,
              bottom: 20.0,
              left: 20.0,
              right: 20.0,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/Request');
                },
                child: const Text(
                  'Request',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                    primary: primaryAppColor,
                    fixedSize: const Size(500.0, 80.0),
                    elevation: 0.0,
                    shadowColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    )
                ),
              ),
            ),
          ],
        )
      ),
    );
  }
}