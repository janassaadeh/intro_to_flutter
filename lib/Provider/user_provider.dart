import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intro_to_flutter/Model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserProvider with ChangeNotifier {
  UserModel? userModel;
  bool isLogged = false;
  String message = '';



  final FirebaseAuth _auth = FirebaseAuth.instance;
Future<void> register(String email, String password,String name,String phoneNumber) async {
  try {
    await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    await FirebaseAuth.instance.currentUser!.updateDisplayName(name);
      // Store additional user information (including phone number) in Firestore
      await FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser!.uid).set({
        'name': name,
        'email': email,
        'phone': phoneNumber,
      });

  } catch (e) {
    print("Error during registration: $e");
  }
}
  Future<bool> signIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      isLogged = true;
      message = 'Sign in successful';
      notifyListeners(); // Notify listeners to update UI
      print(message);
       DocumentSnapshot userSnapshot = await FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser!.uid).get();
      userModel=UserModel(
                    email: userSnapshot['email'],
                    name: userSnapshot['name'],
                    phone: userSnapshot['phone']
                  );
                  return true;
    } catch (e) {
      isLogged = false;
      message = 'Error: $e';
      notifyListeners(); // Notify listeners to update UI
      print(message);
      return false;
    }
  }
 final GoogleSignIn googleSignIn = GoogleSignIn();
Future<bool> signInWithGoogle() async {
  try {
    // Trigger Google Sign-In
    final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

    // Obtain authentication details
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount!.authentication;

      isLogged = true;
      message = 'Sign in successful';
      notifyListeners(); // Notify listeners to update UI

    // Create Firebase Auth credentials
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    // Sign in to Firebase with the obtained credentials
    final UserCredential authResult = await _auth.signInWithCredential(credential);

    // Retrieve user information
    final User? user = authResult.user;

    // Print/display user information
    print("Signed in: ${user!.displayName}");

    String? name = user.displayName??'';
    String? email = user.email??'';
    String? phone = user.phoneNumber??'';

    userModel = UserModel(
      email: email!,
      name: name!,
      phone: phone!
    );
print("email${userModel!.email}");
print("name${name}");
print("phone${phone}");

notifyListeners();
    return true;
  } catch (error) {
    // Handle errors during the sign-in process
    print("Error signing in with Google: $error");
      notifyListeners(); // Notify listeners to update UI

    return false;
  }
}


  void logout() {
    userModel = UserModel();
    isLogged = false;
    FirebaseAuth.instance.signOut();
 googleSignIn.signOut();
    notifyListeners();
  }
}
