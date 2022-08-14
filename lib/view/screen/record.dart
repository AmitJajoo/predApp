import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:predapp/controller/auth_controller.dart';
import 'package:predapp/view/screen/auth/login.dart';
import 'package:share_plus/share_plus.dart';

class Record extends StatefulWidget {
  const Record({Key? key}) : super(key: key);

  @override
  State<Record> createState() => _RecordState();
}

class _RecordState extends State<Record> {
  Map<String, dynamic> record = {};
  refresh() async {
    record = await AuthController().getData();
    print("record $record ${record['Age']}");
    setState(() {
      is_loading = true;
    });
  }

  bool is_loading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Records"),
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
      body: Visibility(
        visible: is_loading,
        replacement: Center(child: CircularProgressIndicator()),
        // child: ListView.builder(
        //     itemCount: record.length,
        //     itemBuilder: (_, index) {
        //       return Text(record[index]["Age"]);
        //     }),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('data')
              .doc(AuthController().user.uid)
              .collection("disease")
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            return record.isEmpty
                ? Center(
                    child: Text(
                    "No Record Found",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ))
                : ClipRRect(
                    child: ListView(
                      // physics: ScrollPhysics(),
                      clipBehavior: Clip.none,
                      children: snapshot.data!.docs.map((document) {
                        return GestureDetector(
                          onTap: () {
                            if (document["Disease"] == "Heart") {
                              showAlertDialogHeart(
                                  context,
                                  document["Age"],
                                  document["Cheast Pain"],
                                  document['Cholesterol'],
                                  document['Exercise Angina'],
                                  document['FastingBS'],
                                  document['Max Hr'],
                                  document['Old Peak'],
                                  document['Resting Bp'],
                                  document['ST Slope'],
                                  document['Sex'],
                                  document['resting ECG'],
                                  document["Result"],
                                  document["Name"]);
                            } else if (document["Disease"] == "Diabetes") {
                              showAlertDialogDiabetic(
                                  context,
                                  document["Pregnancies"],
                                  document["Glucose"],
                                  document["Blood Pressure"],
                                  document["Skin Thickness"],
                                  document["Insulin"],
                                  document["BMI"],
                                  document["DPF"],
                                  document["Age"],
                                  document["Result"],
                                  document["Name"]);
                            } else if (document["Disease"] == "Liver") {
                              showAlertDialogLiver(
                                  context,
                                  document["Age"],
                                  document["Alamine_Aminotransferase"],
                                  document["Albumin"],
                                  document["Albumin_and_Globulin_Ratio"],
                                  document["Alkaline_Phosphotase"],
                                  document["Direct_Bilirubin"],
                                  document["Sex"],
                                  document["Total_Bilirubin"],
                                  document["Total_Protiens"],
                                  document["Result"],
                                  document["Name"]);
                            }
                          },
                          child: Container(
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              // border: Border.all(width: 1),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  offset: const Offset(
                                    0.0,
                                    0.0,
                                  ),
                                  blurRadius: 2.0,
                                  spreadRadius: 1.0,
                                ), //BoxShadow
                                BoxShadow(
                                  color: Colors.white,
                                  offset: const Offset(0.0, 0.0),
                                  blurRadius: 0.0,
                                  spreadRadius: 0.0,
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ListTile(
                                  title: Text(document["Disease"]),
                                  subtitle: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(document["Date"]),
                                      Text(document["Name"])
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                )
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  );
          },
        ),
      ),
    );
    // );
  }
}

showAlertDialogDiabetic(
    BuildContext context,
    String pregnancies,
    String glucose,
    String bp,
    String skinThickness,
    String insulin,
    String bmi,
    String dpf,
    String age,
    String result,
    String name) {
  // Create button
  Widget okButton = ElevatedButton(
    child: Text("Cancel"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  Widget shareButton = ElevatedButton(
    child: Text("Share"),
    onPressed: () async {
      String dis;
      if (result == "0") {
        dis = "Result : Does not have a possibility of disease.";
      } else {
        dis = "Result : Have a Possibility of disease.";
      }
      await Share.share("""
  Disease:Diabetic
  Name : $name
  Pregnancies : $pregnancies
  Glucose : $glucose,
  Blood Pressure : $bp
  Skin Thickness : $skinThickness
  Insulin : $insulin
  Bmi : $bmi
  DPF : $dpf
  Age : $age
  $dis
""", subject: "Pred App");
    },
  );

  // Create AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Diabetic"),
    content: Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Name : $name"),
          Text("Pregnancies : $pregnancies"),
          Text("Glucose : $glucose"),
          Text("Blood Pressure : $bp"),
          Text("Skin Thickness : $skinThickness"),
          Text("Insulin : $insulin"),
          Text("Bmi : $bmi"),
          Text("DPF : $dpf"),
          Text("Age : $age"),
          Text(result == "0"
              ?  "Result : Does not have a possibility of disease."
              : "Result : Have a Possibility of disease."),
        ],
      ),
    ),
    actions: [shareButton, okButton],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

showAlertDialogLiver(
  BuildContext context,
  String age,
  String alamineAminotransferase,
  String albumin,
  String albuminandGlobulinRatio,
  String alkalinePhosphotase,
  String directBilirubin,
  String sex,
  String totalBilirubin,
  String totalProtiens,
  String result,
  String name,
) {
  // Create button
  Widget okButton = ElevatedButton(
    child: Text("Cancel"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  Widget okShare = ElevatedButton(
    child: Text("Share"),
    onPressed: () async {
      String dis;
      if (result == "1") {
        dis = "Result : Does not have a possibility of disease.";
      } else {
        dis = "Result : Have a Possibility of disease.";
      }
      await Share.share("""
       Disease:Liver
  Name : $name
  Age : $age
  Alamine Aminotransferase : $alamineAminotransferase
  Albumin : $albumin
  Albumin and Globulin Ratio : $albuminandGlobulinRatio
  Alkaline Phosphotase : $alkalinePhosphotase
  Direct Bilirubin : $directBilirubin
  Gender : $sex
  Total Bilirubin : $totalBilirubin
  Total Protiens : $totalProtiens
  $dis
    """);
    },
  );

  // Create AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Liver"),
    content: Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Name : $name"),
          Text("Age : $age"),
          Text("Alamine Aminotransferase : $alamineAminotransferase"),
          Text("Albumin : $albumin"),
          Text("Albumin and Globulin Ratio : $albuminandGlobulinRatio"),
          Text("Alkaline Phosphotase : $alkalinePhosphotase"),
          Text("Direct Bilirubin : $directBilirubin"),
          Text("Gender : $sex"),
          Text("Total Bilirubin : $totalBilirubin"),
          Text("Total Protiens : $totalProtiens"),
          Text(result == "1"
              ?  "Result : Does not have a possibility of disease."
              : "Result : Have a Possibility of disease."),
        ],
      ),
    ),
    actions: [okShare, okButton],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

showAlertDialogHeart(
    BuildContext context,
    String age,
    String cheastPain,
    String cholesterol,
    String exerciseAngina,
    String fastingBS,
    String maxHr,
    String oldPeak,
    String restingBp,
    String stSlope,
    String sex,
    String restingECG,
    String result,
    String name) {
  // Create button
  Widget okButton = ElevatedButton(
    child: Text("Cancel"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  Widget okShare = ElevatedButton(
    child: Text("Share"),
    onPressed: () async {
      String dis;
      if (result == "0") {
        dis = "Result : Does not have a possibility of disease.";
      } else {
        dis = "Result : Have a Possibility of disease.";
      }
      await Share.share("""
       Disease:Heart
  Name : $name
  Age : $age
  Cheast Pain : $cheastPain
  Cholesterol : $cholesterol
  Exercise Angina : $exerciseAngina
  Fasting BS : $fastingBS
  Max Hr : $maxHr
  Old Peak : $oldPeak
  Resting Bp : $restingBp
  ST Slope :  $stSlope
  Sex : $sex
  Resting ECG : $restingECG
  $dis
  """);
    },
  );

  // Create AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Heart Attack"),
    content: Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Name : $name"),
          Text("Age : $age"),
          Text("Cheast Pain : $cheastPain"),
          Text("Cholesterol : $cholesterol"),
          Text("Exercise Angina : $exerciseAngina"),
          Text("Fasting BS : $fastingBS"),
          Text("Max Hr : $maxHr"),
          Text("Old Peak : $oldPeak"),
          Text("Resting Bp : $restingBp"),
          Text("ST Slope :  $stSlope"),
          Text("Sex : $sex"),
          Text("Resting ECG : $restingECG"),
          Text(result == "0"
              ? "Result : Does not have a possibility of disease."
              : "Result : Have a Possibility of disease."),
        ],
      ),
    ),
    actions: [okShare, okButton],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
