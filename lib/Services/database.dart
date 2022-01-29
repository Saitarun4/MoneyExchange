import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService{
  final CollectionReference userRequest = FirebaseFirestore.instance.collection('Requests');


  Future<void> addUser(String name,int amount,bool mode,int phonenumber,String address) async{
    // Call the user's CollectionReference to add a new user
    return await userRequest
      .doc(name)
        .set({
      'name':name,
      'amount':amount,
      'mode':mode,
      'phonenumber':phonenumber,
      'address':address,
    })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<void> deleteUser(String name) {
    return userRequest
        .doc(name)
        .delete()
        .then((value) => print("User Deleted"))
        .catchError((error) => print("Failed to delete user: $error"));
  }
}