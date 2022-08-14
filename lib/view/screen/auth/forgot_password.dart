
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:predapp/const.dart';
import 'package:predapp/controller/auth_controller.dart';
import 'package:predapp/view/screen/auth/login.dart';


class ForgotPasswordScreen extends StatefulWidget {
  ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController email = TextEditingController();
  bool _isLoading = false;
  forgotPassword() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthController().forgotPassword(email.text);
    setState(() {
      _isLoading = false;
    });
    if (res != "success") {
      showSnakBar(res, context);
    } else {
      showSnakBar("Link has been send to your email", context);
      Navigator.push(context, MaterialPageRoute(builder: (_) => LoginScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Forgot Password",
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                  color: Colors.black,
                  letterSpacing: .5,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          TextField(
              controller: email,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                filled: true,
                border: OutlineInputBorder(borderSide: BorderSide.none),
                hintText: "Enter Email",
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(10.0),
                ),
              )),
          SizedBox(
            height: 15,
          ),
          GestureDetector(
            onTap: () {
              forgotPassword();
              email.clear();
            },
            child: Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: buttonColor,
                //borderRadius: BorderRadius.circular(10)
              ),
              child: _isLoading
                  ? Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    )
                  : Text(
                      "Forget Password",
                      // style: TextStyle(
                      //     color: Colors.white,
                      //     fontWeight: FontWeight.bold,
                      //     fontSize: 24),
                      style: GoogleFonts.dancingScript(
                        textStyle: TextStyle(
                            color: Colors.white,
                            letterSpacing: .5,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
            ),
          ),
        ],
      ),
    ));
  }
}
