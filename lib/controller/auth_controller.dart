import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:predapp/const.dart';

class AuthController {
  //function to add image to storage
  // Future<String> _uploadImageToStorage(Uint8List? image) async {
  //   Reference ref = firebaseStorage
  //       .ref()
  //       .child("profilePic")
  //       .child(firebaseAuth.currentUser!.uid);
  //   UploadTask uploadTask = ref.putData(image!);
  //   TaskSnapshot snap = await uploadTask;
  //   String downloadUrl = await snap.ref.getDownloadURL();
  //   return downloadUrl;
  // }

  // //function to enable users pick image
  // pickImage(ImageSource source) async {
  //   final ImagePicker _imagePicker = ImagePicker();
  //   XFile _file = (await _imagePicker.pickImage(source: source))!;
  //   if (_file != null) {
  //     return await _file.readAsBytes();
  //   } else {
  //     print("No Image selected");
  //   }
  // }

  Stream<User?> get authChanges => firebaseAuth.authStateChanges();
  User get user => firebaseAuth.currentUser!;

  Future<String> signInUser(
      String full_name, String user_name, String email, String password) async {
    String res = "some error";
    try {
      if (full_name.isNotEmpty &&
          user_name.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty) {
        UserCredential user = await firebaseAuth.createUserWithEmailAndPassword(
            email: email, password: password);
        debugPrint(user.user!.email);
        // String downloadUrl = await _uploadImageToStorage(image);
        await firebaseFirestore.collection("users").doc(user.user!.uid).set({
          "fullName": full_name,
          "username": user_name,
          "email": email,
          // "image": downloadUrl
        });
        res = "success";
      } else {
        res = "Please fill all the fields";
      }
    } catch (e) {
      res = e.toString();
      print("12234 $res");
    }
    return res;
  }

  //function to login in users
  logininUsers(String email, String password) async {
    String res = "some error occur";
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password);
        res = "success";
        print("you are now logged in");
      } else {
        res = "Please, fields must not be empty";
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  //forget Password
  Future<String> forgotPassword(String email) async {
    String res = "some error occured";
    try {
      if (email.isNotEmpty) {
        await firebaseAuth.sendPasswordResetEmail(email: email);
        print("Resend link is send to your email");
        res = "success";
      } else {
        res = "Email field must not be empty";
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<String> diabeticdata(
      String name,
      String pregnancies,
      String glucose,
      String blood_pressure,
      String skin_thickness,
      String insulin,
      String bmi,
      String dpf,
      String age,
      String result) async {
    String res = "some error";
    try {
      String dateFormat =
          DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now());
      if (pregnancies.isNotEmpty &&
          glucose.isNotEmpty &&
          blood_pressure.isNotEmpty &&
          skin_thickness.isNotEmpty &&
          insulin.isNotEmpty &&
          bmi.isNotEmpty &&
          dpf.isNotEmpty &&
          age.isNotEmpty &&
          name.isNotEmpty) {
        // UserCredential user = await firebaseAuth.createUserWithEmailAndPassword(
        //     email: email, password: password);
        // debugPrint(user.user!.email);
        // String downloadUrl = await _uploadImageToStorage(image);
        await firebaseFirestore
            .collection("data")
            .doc(user.uid)
            .collection("disease")
            .add({
          "Disease": "Diabetes",
          "Date": dateFormat,
          "Pregnancies": pregnancies,
          "Glucose": glucose,
          "Blood Pressure": blood_pressure,
          "Skin Thickness": skin_thickness,
          "Insulin": insulin,
          "BMI": bmi,
          "DPF": dpf,
          "Age": age,
          "Name": name,
          "Result": result
          // "image": downloadUrl
        });

        res = "success";
      } else {
        res = "Please fill all the fields";
      }
    } catch (e) {
      res = e.toString();
      print("12234 $res");
    }
    return res;
  }

  Future<String> heartData(
      String name,
      String age,
      String sex,
      String restingBp,
      String cholesterol,
      String fastingBS,
      String maxHr,
      String exerciseAngina,
      String oldpeak,
      String cheastPain,
      String restingECG,
      String stSlope,
      String result) async {
    String res = "some error";
    try {
      String dateFormat =
          DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now());
      if (age.isNotEmpty &&
          sex.isNotEmpty &&
          restingBp.isNotEmpty &&
          cholesterol.isNotEmpty &&
          fastingBS.isNotEmpty &&
          maxHr.isNotEmpty &&
          exerciseAngina.isNotEmpty &&
          oldpeak.isNotEmpty &&
          cheastPain.isNotEmpty &&
          restingECG.isNotEmpty &&
          stSlope.isNotEmpty &&
          name.isNotEmpty) {
        // UserCredential user = await firebaseAuth.createUserWithEmailAndPassword(
        //     email: email, password: password);
        // debugPrint(user.user!.email);
        // String downloadUrl = await _uploadImageToStorage(image);
        await firebaseFirestore
            .collection("data")
            .doc(user.uid)
            .collection("disease")
            .add({
          "Disease": "Heart",
          "Date": dateFormat,
          "Age": age,
          "Sex": sex,
          "Resting Bp": restingBp,
          "Cholesterol": cholesterol,
          "FastingBS": fastingBS,
          "Max Hr": maxHr,
          "Exercise Angina": exerciseAngina,
          "Old Peak": oldpeak,
          "Cheast Pain": cheastPain,
          "resting ECG": restingECG,
          "ST Slope": stSlope,
          "Name": name,
          "Result": result
        });

        res = "success";
      } else {
        res = "Please fill all the fields";
      }
    } catch (e) {
      res = e.toString();
      print("12234 $res");
    }
    print("456546546756 $res");
    return res;
  }

  Future<String> liverData(
      String name,
      String age,
      String sex,
      String totalBilirubin,
      String directBilirubin,
      String alkalinePhosphotase,
      String alamineAminotransferase,
      String totalProtiens,
      String albumin,
      String albuminGlobulin,
      String result) async {
    String res = "some error";
    try {
      String dateFormat =
          DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now());
      if (age.isNotEmpty &&
          sex.isNotEmpty &&
          totalBilirubin.isNotEmpty &&
          directBilirubin.isNotEmpty &&
          alkalinePhosphotase.isNotEmpty &&
          alamineAminotransferase.isNotEmpty &&
          totalProtiens.isNotEmpty &&
          albumin.isNotEmpty &&
          albuminGlobulin.isNotEmpty &&
          name.isNotEmpty) {
        // UserCredential user = await firebaseAuth.createUserWithEmailAndPassword(
        //     email: email, password: password);
        // debugPrint(user.user!.email);
        // String downloadUrl = await _uploadImageToStorage(image);
        await firebaseFirestore
            .collection("data")
            .doc(user.uid)
            .collection("disease")
            .add({
          "Disease": "Liver",
          "Date": dateFormat,
          "Age": age,
          "Sex": sex,
          "Total_Bilirubin": totalBilirubin,
          "Direct_Bilirubin": directBilirubin,
          "Alkaline_Phosphotase": alkalinePhosphotase,
          "Alamine_Aminotransferase": alamineAminotransferase,
          "Total_Protiens": totalProtiens,
          "Albumin": albumin,
          "Albumin_and_Globulin_Ratio": albuminGlobulin,
          "Name": name,
          "Result": result
          // "image": downloadUrl
        });

        res = "success";
      } else {
        res = "Please fill all the fields";
      }
    } catch (e) {
      res = e.toString();
      print("12234 $res");
    }
    return res;
  }

  Future<Map<String, dynamic>> getData() async {
    Map<String, dynamic> res = {};
    try {
      var abc = await firebaseFirestore
          .collection("data")
          .doc(user.uid)
          .collection("disease")
          .get()
          .then((querySnapshot) {
        querySnapshot.docs.forEach((result) {
          res = result.data();
          print("result getData() ${result.data()}");
        });
      });

      // for (var snapshot in abc.docs) {
      //   res = snapshot.data();
      //   print("0987 $res"); // <-- Document ID
      // }
      print("7890 $res");
      // var res = abc.docs[0].reference.id.toString();

    } catch (e) {
      res = {"error": e};
    }
    return res;
  }

  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }
}

showSnakBar(String content, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(content)));
}
