// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '/model/user_model.dart';
import '/utils/commons.dart';
import '/utils/show_otp_dialogue.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  Future<bool> isUserExists(String phoneNumber) async {
    QuerySnapshot snap = await _firestore
        .collection('users')
        .where('phoneNumber', isEqualTo: phoneNumber)
        .get();

    print(snap.docs);
    if (snap.docs.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  login(
    String phoneNumber,
    String password,
    BuildContext context,
  ) async {
    String res = 'Something Went Wrong';
    DocumentSnapshot<Map<String, dynamic>> snap =
        await _firestore.collection('users').doc(phoneNumber).get();

    if (snap.data() != null) {
      if (snap.data()!['password'] != password) {
        snackBar('Invalid Password');
      } else {
        phoneSignIn(context, phoneNumber);
      }
    }
    return res;
  }

  addUserToDB(
    String firstName,
    String lastName,
    String email,
    String password,
    String phoneNumber,
  ) {
    try {
      UserModel user = UserModel(
        email: email,
        firstName: firstName,
        lastName: lastName,
        password: password,
        phoneNumber: phoneNumber,
      );
      _firestore.collection('users').doc(phoneNumber).set(user.toMap());
    } on FirebaseAuthException catch (e) {
      print(e.message);
    }
  }

  Future<bool> phoneSignIn(
    BuildContext context,
    String phoneNumber,
  ) async {
    TextEditingController controller = TextEditingController();
    bool validated = false;
    try {
      await _auth
          .verifyPhoneNumber(
            phoneNumber: phoneNumber,
            verificationCompleted: (PhoneAuthCredential credential) async {
              await _auth.signInWithCredential(credential);
            },
            verificationFailed: (e) {
              String msg = 'Something Went Wrong';
              print('Message: ${e.message}');
              if (e.code == 'invalid-phone-number') {
                msg =
                    ('The phone number is not valid. Use [+][Country Code] Format');
              }
              snackBar(msg);
            },
            codeSent: (verificationId, forceResendingToken) {
              showOTPDialogue(context, controller, () async {
                PhoneAuthCredential credential = PhoneAuthProvider.credential(
                  verificationId: verificationId,
                  smsCode: controller.text.trim(),
                );
                await _auth.signInWithCredential(credential);
                validated = true;
                Navigator.pop(context);
              });
            },
            codeAutoRetrievalTimeout: (verificationId) {},
          )
          .then((value) => Future.delayed(Duration.zero));
    // ignore: empty_catches
    } on Exception {}
    return validated;
  }

  signOut() async {
    await _auth.signOut();
  }
}
