import 'view/home_view.dart';
import 'view/sign_in_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initializing Firbase App
  await Firebase.initializeApp();

  // Entry Point of Application
  runApp(const EPoster());
}

class EPoster extends StatelessWidget {
  const EPoster({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get Metrial App Controller
    return GetMaterialApp(
      title: 'E-Poster',
      debugShowCheckedModeBanner: false,
      // Theme of Application
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

      // State Persistance provided by Firebase Authentication
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              
              return const HomeView();
            } else if (snapshot.hasError) {
              return SignInView();
            }
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return SignInView();
        },
      ),
    );
  }
}
