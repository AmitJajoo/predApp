import 'package:flutter/material.dart';
import 'package:predapp/controller/auth_controller.dart';
import 'package:predapp/view/screen/auth/login.dart';
import 'package:url_launcher/url_launcher.dart';

class About extends StatefulWidget {
  About({Key? key}) : super(key: key);

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  Uri _amiturl = Uri.parse('https://www.linkedin.com/in/amit-jajoo-287b33a2/');
  Uri _guptaurl =
      Uri.parse('https://www.linkedin.com/in/amit-khandelwal-72216b190/');
  Uri _soniurl = Uri.parse('https://www.linkedin.com/in/iadityasoni/');

  _launchURL(_url) async {
    if (await launchUrl(_url)) {
      await launchUrl(_url);
    } else {
      throw 'Could not launch $_url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Pred App"),
        elevation: 0,
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                // begin: Alignment.topCenter,
                // end: Alignment.bottomCenter,
                colors: <Color>[Color(0xffDC1C13), Color(0xffEA4C46)]),
          ),
        ),
        actions: [
          GestureDetector(
              onTap: () async {
                await AuthController().signOut();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              },
              child: Icon(Icons.logout))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(36.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: SizedBox(
                  height: 200,
                  child: Image.asset(
                    "assets/icon.png",
                    fit: BoxFit.contain,
                  )),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            Text(
                """Pred App is an app for health that is capable for making disease prediction, based on a number different factor.\nPred App takes an input from patient medical reports values for there prediction.\nThis current version of Pred App is capable for making prediction for diabetes, heart and liver.  """),
            SizedBox(
              height: 20,
            ),
            Text("Developed by : "),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Amit Jajoo",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    debugPrint("Hello world");
                    _launchURL(_amiturl);
                    debugPrint("Hello world1111");
                  },
                  child: Image.asset(
                    "assets/linkedin.png",
                    width: 30,
                    height: 30,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Amit Khandelwal",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    debugPrint("Hello world");
                    _launchURL(_guptaurl);
                    debugPrint("Hello world1111");
                  },
                  child: Image.asset(
                    "assets/linkedin.png",
                    width: 30,
                    height: 30,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Aditya Soni",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    debugPrint("Hello world");
                    _launchURL(_soniurl);
                    debugPrint("Hello world1111");
                  },
                  child: Image.asset(
                    "assets/linkedin.png",
                    width: 30,
                    height: 30,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Text("Version : v.1.0"),
            )
          ],
        ),
      ),
    );
  }
}
