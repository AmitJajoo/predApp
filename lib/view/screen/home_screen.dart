import 'package:flutter/material.dart';
import 'package:predapp/controller/auth_controller.dart';
import 'package:predapp/view/screen/auth/login.dart';
import 'package:predapp/view/screen/diabetic.dart';
import 'package:predapp/view/screen/heart.dart';
import 'package:predapp/view/screen/liver.dart';


class Button extends StatelessWidget {
  const Button({Key? key}) : super(key: key);

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
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.05),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.2,
                child: Image.asset(
                  "assets/medical-team-1.png", fit: BoxFit.contain,
                  // width: MediaQuery.of(context).size.width * 0.3,
                  // height: MediaQuery.of(context).size.height * 0.5
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView(
                physics: ScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 10),
                shrinkWrap: true,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const DiabetesPage()));
                    },
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        children: [
                          Image.asset(
                            "assets/diabetes.png",
                            // width: 256,
                            // height: 256,
                          ),
                          const Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              "Diabetes",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w400),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => HeartScreen()));
                    },
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        children: [
                          Image.asset(
                            "assets/heart.png",
                            // width: 256,
                            // height: 256,
                          ),
                          const Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              "Heart Attack",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w400),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context, MaterialPageRoute(builder: (_) => Liver()));
                    },
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        children: [
                          Image.asset(
                            "assets/liver.png",
                            // width: 256,
                            // height: 256,
                          ),
                          const Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              "Liver Disease",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w400),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            // SizedBox(
            //   width: MediaQuery.of(context).size.width * 0.9,
            //   child: ElevatedButton(
            //     onPressed: () {
            // Navigator.push(
            //     context, MaterialPageRoute(builder: (_) => DiabetesPage()));
            //     },
            //     child: Text("Diabetes Predication"),
            //     style: ElevatedButton.styleFrom(
            //         primary: Colors.deepOrange,
            //         padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            //         textStyle:
            //             TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            //   ),
            // ),
            // SizedBox(
            //   height: 30,
            // ),
            // SizedBox(
            //   width: MediaQuery.of(context).size.width * 0.9,
            //   child: ElevatedButton(
            //       style: ElevatedButton.styleFrom(
            //           primary: Colors.deepOrange,
            //           padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            //           textStyle:
            //               TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            //       onPressed: () {
            // Navigator.push(context,
            //     MaterialPageRoute(builder: (_) => HeartScreen()));
            //       },
            //       child: Text("Heart Attack Predication")),
            // ),
            // SizedBox(
            //   height: 30,
            // ),
            // SizedBox(
            //   width: MediaQuery.of(context).size.width * 0.9,
            //   child: ElevatedButton(
            //       style: ElevatedButton.styleFrom(
            //           primary: Colors.deepOrange,
            //           padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            //           textStyle:
            //               TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            //       onPressed: () {
            //         // Navigator.push(
            //         //     context, MaterialPageRoute(builder: (_) => MyHomePage()));
            //       },
            //       child: Text("Movie Recommendation")),
            // ),
          ],
        ),
      ),
    );
  }
}
