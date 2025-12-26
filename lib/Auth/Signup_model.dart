import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:newspaper/Auth/login_screen.dart';
Signupuser(
    BuildContext context,
    String username,
    String useremail,
    String password,
    ) async {
  try {
    UserCredential userCredential =
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: useremail,
      password: password,
    );
    User? newUser = userCredential.user;
    await FirebaseFirestore.instance
        .collection("newusers")
        .doc(newUser!.uid)
        .set({
      'userName': username,
      'userEmail': useremail,
      'createdAt': DateTime.now(),
      'userid': newUser.uid,
    });
    Navigator.push(context, MaterialPageRoute(builder: (context) => validsign()),
    );

  } on FirebaseAuthException catch (e) {
    print("Firebase Error: $e");
  } catch (e) {
    print("Error: $e");
  }
}
