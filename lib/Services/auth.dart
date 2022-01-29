import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:moneyexchange/Models/user.dart';
import 'package:moneyexchange/Services/database.dart';

class AuthService{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AppUser? _userFromUserCredential(User? user){
    return user!=null ? AppUser(uid: user.uid): null;
  }

  Stream<AppUser?> get user{
    return _auth.authStateChanges()
        .map(_userFromUserCredential);
  }

  //sign in anonymously
  Future signInAnon() async{
    try{
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userFromUserCredential(user);
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }

  //sign in with email and password
  Future signInWithEmailAndPassword(String email,String password) async{
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return _userFromUserCredential(user);
    } catch(e){
      print(e.toString());
      return null;
    }
  }

  //create user with email and password
  Future registerWithEmailAndPassword(String email,String password) async{
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return _userFromUserCredential(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future signOut() async{
    try{
      return await _auth.signOut();
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }
}

