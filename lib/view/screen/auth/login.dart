import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:predapp/const.dart';
import 'package:predapp/controller/auth_controller.dart';
import 'package:predapp/view/screen/auth/forgot_password.dart';
import 'package:predapp/view/screen/auth/sign_in.dart';
import 'package:predapp/view/screen/bottom_navbar.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController email = TextEditingController();

  final TextEditingController password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isObscure = true;
  final _auth = FirebaseAuth.instance;

  bool _isLoading = false;

  loginUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthController().logininUsers(email.text, password.text);
    setState(() {
      _isLoading = false;
    });
    if (res != "success") {
      showSnakBar(res, context);
    } else {
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => BottomNavBar()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(36.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                    height: 200,
                    child: Image.asset(
                      "assets/icon.png",
                      fit: BoxFit.contain,
                    )),
                // TextField(
                //     controller: email,
                //     cursorColor: Colors.black,
                //     decoration: InputDecoration(
                //       filled: true,
                //       border: OutlineInputBorder(borderSide: BorderSide.none),
                //       hintText: "Enter Email",
                //       focusedBorder: OutlineInputBorder(
                //         borderSide: BorderSide(
                //           color: Colors.black54,
                //           width: 1,
                //         ),
                //         borderRadius: BorderRadius.circular(10.0),
                //       ),
                //     )),
                TextFormField(
                    autofocus: false,
                    controller: email,
                    keyboardType: TextInputType.emailAddress,

                    // validation
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter your email";
                      }
                      if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                          .hasMatch(value)) {
                        return ("Please Enter a valid email");
                      }
                      return null;
                    },
                    onSaved: (value) {
                      email.text = value!;
                    },
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.mail),
                      contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                      hintText: "Email",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    )),
                SizedBox(
                  height: 20,
                ),
                // TextField(
                //     obscureText: true,
                //     controller: password,
                //     cursorColor: Colors.black,
                //     decoration: InputDecoration(
                //       filled: true,
                //       border: OutlineInputBorder(borderSide: BorderSide.none),
                //       hintText: "Enter Password",
                //       focusedBorder: OutlineInputBorder(
                //         borderSide: BorderSide.none,
                //         borderRadius: BorderRadius.circular(10.0),
                //       ),
                //     )),
                TextFormField(
                  obscureText: isObscure,
                  autofocus: false,
                  controller: password,
                  validator: (value) {
                    RegExp regex = new RegExp(r'^.{6,}$');
                    if (value!.isEmpty) {
                      return "Please enter your password";
                    }
                    if (!regex.hasMatch(value)) {
                      return "Enter valid Password(Min. 6 Characters)";
                    }
                  },
                  onSaved: (value) {
                    password.text = value!;
                  },
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.vpn_key),
                    contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                    hintText: "Password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    // suffixIcon: Icon(Icons.visibility_off),
                    suffixIcon: InkWell(
                      onTap: () {
                        setState(() {
                          isObscure = !isObscure;
                        });
                      },
                      child: Icon(
                          isObscure ? Icons.visibility_off : Icons.visibility),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                // GestureDetector(
                //   onTap: () async {
                //     await loginUser();
                //     email.clear();
                //     password.clear();
                //   },
                //   child: Container(
                //     alignment: Alignment.center,
                //     width: MediaQuery.of(context).size.width,
                //     padding: EdgeInsets.all(15),
                //     decoration: BoxDecoration(
                //         color: buttonColor,
                //         borderRadius: BorderRadius.circular(10)),
                //     child: _isLoading
                //         ? Center(
                //             child: CircularProgressIndicator(
                //               color: Colors.white,
                //             ),
                //           )
                //         : Text(
                //             "Login",
                //             // style: TextStyle(
                //             //     color: Colors.white,
                //             //     fontWeight: FontWeight.bold,
                //             //     fontSize: 24),
                //             style: GoogleFonts.dancingScript(
                //               textStyle: TextStyle(
                //                   color: Colors.white,
                //                   letterSpacing: .5,
                //                   fontSize: 24,
                //                   fontWeight: FontWeight.bold),
                //             ),
                //           ),
                //   ),
                // ),
                Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(30),
                  color: buttonColor,
                  child: MaterialButton(
                      padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                      minWidth: MediaQuery.of(context).size.width,
                      onPressed: () async {
                        // final SharedPreferences sharedPreferences =
                        //     await SharedPreferences.getInstance();
                        // sharedPreferences.setString("email", emailController.text);
                        signIn(email.text, password.text);
                      },
                      child: Text(
                        "Login",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      )),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          color: Colors.black,
                          // letterSpacing: .5,
                          fontSize: 14,
                          //fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => SignInScreen())));
                      },
                      child: Text(
                        "Sign Up",
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: Colors.black,
                              letterSpacing: .5,
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => ForgotPasswordScreen()));
                  },
                  child: Text(
                    "Forget Password ?",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void signIn(String email, String password) async {
    try {
      if (_formKey.currentState!.validate()) {
        await _auth
            .signInWithEmailAndPassword(email: email, password: password)
            .then((uid) => {
                  Fluttertoast.showToast(msg: "Login Successful"),
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => BottomNavBar())),
                })
            .catchError((e) {
          Fluttertoast.showToast(msg: e!.message);
        });
      }
    } catch (e) {
      debugPrint("Login error $e");
    }
  }
}
