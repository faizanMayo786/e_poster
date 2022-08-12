import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  Rx<UserModel> userModel = UserModel(
          firstName: 'firstName',
          lastName: 'lastName',
          email: 'email',
          password: 'password',
          phoneNumber: 'phoneNumber')
      .obs;

  @override
  onInit() {
    super.onInit();
    getUser();
  }

  getUser() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snap = await FirebaseFirestore
          .instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.phoneNumber)
          .get();

      if (snap.data() != null) {
        userModel.value = UserModel.fromMap(snap.data()!);
      }
    } on Exception {
      // ignore: todo
      // TODO
    }
  }
}
