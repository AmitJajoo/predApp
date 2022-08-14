import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:predapp/controller/auth_controller.dart';
import 'package:predapp/view/screen/auth/login.dart';
import 'package:predapp/view/screen/bottom_navbar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData.light(),
        // home: StreamBuilder(
        //   stream: FirebaseAuth.instance.authStateChanges(),
        //   builder: (context, snapshot) {
        //     if (snapshot.connectionState != ConnectionState.active) {
        //       return Center(child: CircularProgressIndicator());
        //     }
        //     final user = snapshot.data;
        //     if (user != null &&
        //         FirebaseAuth.instance.currentUser!.emailVerified == true) {
        //       print("user is logged in");
        //       return HomeScreen();
        //     } else {
        //       return LoginScreen();
        //     }
        //   },
        // ));

        home: StreamBuilder(
          stream: AuthController().authChanges,
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasData) {
              return BottomNavBar();
            }
            return LoginScreen();
          },
        ));
  }
}
