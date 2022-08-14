import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:predapp/const.dart';
import 'package:predapp/controller/auth_controller.dart';
import 'package:predapp/modal/diabetic_modal.dart';
import 'package:predapp/view/screen/auth/login.dart';
import 'package:predapp/view/screen/widget/text_field.dart';

class DiabetesPage extends StatefulWidget {
  const DiabetesPage({Key? key}) : super(key: key);

  @override
  State<DiabetesPage> createState() => _DiabetesPageState();
}

class _DiabetesPageState extends State<DiabetesPage> {
  bool isLoading = false;
  // int? pregController
  //     gluController,
  //     bpController,
  //     skinController,
  //     insulinController,
  //     bmiController,
  //     dpfController,
  //     ageController;
  String result = "0";
  bool isSecondPage = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = new TextEditingController();

  final TextEditingController pregController = new TextEditingController();
  final TextEditingController gluController = new TextEditingController();
  final TextEditingController bpController = new TextEditingController();
  final TextEditingController skinController = new TextEditingController();
  final TextEditingController insulinController = new TextEditingController();
  final TextEditingController bmiController = new TextEditingController();
  final TextEditingController dpfController = new TextEditingController();
  final TextEditingController ageController = new TextEditingController();
  bool loader = false;
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Diabetes Prediction"),
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
        // actions: [
        //   GestureDetector(
        //       onTap: () async {
        //         await AuthController().signOut();
        //         Navigator.push(context,
        //             MaterialPageRoute(builder: (context) => LoginScreen()));
        //       },
        //       child: Icon(Icons.logout))
        // ],
      ),
      body: !isSecondPage
          ? SingleChildScrollView(
              child: predDiabetes(),
            )
          : Center(child: buildFutureBuilder()),
    );
  }

  predDiabetes() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFieldContainer(
              child: TextFormField(
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                // onSaved: (newValue) => pregController = newValue! as int,
                controller: nameController,
                cursorColor: kPrimaryColor,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter your name";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  hintText: 'Name',
                  border: InputBorder.none,
                  labelText: 'Name',
                ),
              ),
            ),
            TextFieldContainer(
              child: TextFormField(
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                // onSaved: (newValue) => pregController = newValue! as int,
                controller: pregController,
                cursorColor: kPrimaryColor,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter your Pregnancies number";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  hintText: 'Number of times pregnant . Eg - 1',
                  border: InputBorder.none,
                  labelText: 'Pregnancies',
                ),
              ),
            ),
            TextFieldContainer(
              child: TextFormField(
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,

                // onSaved: (newValue) => gluController = newValue! as int,
                controller: gluController,
                cursorColor: kPrimaryColor,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter your Glucose number";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                    hintMaxLines: 2,
                    hintText:
                        'Plasma glucose concentration a 2 hours in an oral glucose tolerance test. Eg - 148',
                    border: InputBorder.none,
                    labelText: "Glucose"),
              ),
            ),
            TextFieldContainer(
              child: TextFormField(
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                // onSaved: (newValue) => bpController = newValue! as int,
                controller: bpController,
                cursorColor: kPrimaryColor,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter your Blood Pressure";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                    hintText: 'Diastolic Blood Pressure (mm Hg). Eg - 72',
                    border: InputBorder.none,
                    labelText: "Blood Pressure"),
              ),
            ),
            TextFieldContainer(
              child: TextFormField(
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,

                // onSaved: (newValue) => skinController = newValue! as int,
                controller: skinController,
                cursorColor: kPrimaryColor,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter your Skin Thickness";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                    hintText: 'Triceps skin fold thickness (mm). Eg - 35',
                    border: InputBorder.none,
                    labelText: "Skin Thickness"),
              ),
            ),
            TextFieldContainer(
              child: TextFormField(
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,

                // onSaved: (newValue) => insulinController = newValue! as int,
                controller: insulinController,
                cursorColor: kPrimaryColor,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter your insulin";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                    hintText: '2-Hour serum insulin (mu U/ml). Eg - 94',
                    border: InputBorder.none,
                    labelText: "Insulin"),
              ),
            ),
            TextFieldContainer(
              child: TextFormField(
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,

                // onSaved: (newValue) => bmiController = newValue! as int,
                controller: bmiController,
                cursorColor: kPrimaryColor,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter your BMI";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                    hintMaxLines: 2,
                    hintText: 'Body mass index\n(Weight in kg/height in m)^2. Eg - 33.6',
                    border: InputBorder.none,
                    labelText: "BMI"),
              ),
            ),
            TextFieldContainer(
              child: TextFormField(
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter your DPF";
                  }
                  return null;
                },
                // onSaved: (newValue) => dpfController = newValue! as int,
                controller: dpfController,
                cursorColor: kPrimaryColor,
                decoration: const InputDecoration(
                    hintText: 'Diabetes Pedigree Function',
                    border: InputBorder.none,
                    labelText: "Diabetes Pedigree Function"),
              ),
            ),
            TextFieldContainer(
              child: TextFormField(
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter your age";
                  }
                  return null;
                },
                // onSaved: (newValue) => ageController = newValue! as int,
                controller: ageController,
                cursorColor: kPrimaryColor,
                decoration: const InputDecoration(
                    hintText: 'Age in number',
                    border: InputBorder.none,
                    labelText: "Age"),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () async {
                  setState(() {
                    isLoading = true;
                  });
                  validateAndSave();
                  // await refresh();

                  // await buildFutureBuilder();
                  //
                },
                child: isLoading
                    ? Center(
                        child: CircularProgressIndicator(
                        color: Colors.white,
                      ))
                    : Text('Predict'),
                style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 20),
                    textStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500))),
          ],
        ),
      ),
    );
  }

  void validateAndSave() async {
    final FormState form = _formKey.currentState!;
    if (form.validate()) {
      await refresh();
      AuthController().diabeticdata(
          nameController.text,
          pregController.text,
          gluController.text,
          bpController.text,
          skinController.text,
          insulinController.text,
          bmiController.text,
          dpfController.text,
          ageController.text,
          result);
      setState(() {
        isLoading = false;
        isSecondPage = true;
      });
      print('Form is valid');
    } else {
      setState(() {
        isLoading = false;
      });
      print('Form is invalid');
    }
  }

  FetchDiabetic? refresh1;
  Future<void> refresh() async {
    try {
      if (_formKey.currentState!.validate()) {
        refresh1 = await createAlbum(
            int.parse(pregController.text),
            int.parse(gluController.text),
            int.parse(bpController.text),
            int.parse(skinController.text),
            int.parse(insulinController.text),
            double.parse(bmiController.text),
            double.parse(dpfController.text),
            int.parse(ageController.text));
        result = refresh1!.isDiabetic;
      }
    } catch (e) {}
  }

  buildFutureBuilder() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
            padding: EdgeInsets.all(20),
            alignment: Alignment.center,
            child: Image.asset(
              result == "0" ? "assets/smile.png" : "assets/sad.png",
              scale: 0.6,
            )),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            result == "0"
                ? "👍🏻Heads Up, you seem perfectly fine."
                : "There's no panic, but it would be fine to visit a doctor around.\nThere might be a possibility of Diabetes disease.",
            style: GoogleFonts.poppins(
              textStyle: Theme.of(context).textTheme.headline4,
              fontSize: result == "0" ? 48 : 30,
              fontWeight: FontWeight.w700,
              fontStyle: FontStyle.normal,
            ),
          ),
        )
      ],
    );
  }
}
