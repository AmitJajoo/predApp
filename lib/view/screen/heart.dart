import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:predapp/const.dart';
import 'package:predapp/controller/auth_controller.dart';
import 'package:predapp/modal/heart_modal.dart';
import 'package:predapp/view/screen/auth/login.dart';
import 'package:predapp/view/screen/widget/text_field.dart';

class HeartScreen extends StatefulWidget {
  const HeartScreen({Key? key}) : super(key: key);

  @override
  State<HeartScreen> createState() => _HeartScreenState();
}

class _HeartScreenState extends State<HeartScreen> {
  bool isSecondPage = false;
  final List<String> gender = [
    'Male',
    'Female',
  ];
  final List<String> fastingBp = [
    'Yes',
    'No',
  ];
  final List<String> excersice = ["Yes", "No"];
  final List<String> chestPainType = [
    "Cheast Pain Type - ASY",
    "Cheast Pain Type - ATA",
    "Cheast Pain Type - NAP",
    "Cheast Pain Type - TA",
  ];
  final List<String> restingEcg = [
    "Resting ECG - LVH",
    "Resting ECG - Normal",
    "Resting ECG - ST",
  ];
  final List<String> stSlope = ["STSlopeDown", "STSlopeFlat", "STSlopeUp"];
  String? selectedGenderValue;
  String? selectedFastingValue;
  String? selectedExcericeValue;
  String? selectedChestPainValue;
  String? selectedRestingEcgValue;
  String? selectedStSlopeValue;
  int? sex;
  int? fbs;
  int? excersiceAngina;
  int chestPainAsy = 0;
  int chestPainAta = 0;

  int chestPainNap = 0;

  int chestPainTa = 0;

  int restingECGLvh = 0;
  int restingECGNormal = 0;

  int restingECGSt = 0;
  int stSlopeDown = 0;
  int stSlopeFlat = 0;
  int stSlopeUp = 0;
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController restingBP = TextEditingController();
  final TextEditingController cholesterol = TextEditingController();
  final TextEditingController fastingBS = TextEditingController();
  final TextEditingController maxHr = TextEditingController();
  final TextEditingController exerciseAngina = TextEditingController();
  final TextEditingController oldpeak = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Heart Prediction"),
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
      body: isSecondPage
          ? Center(child: buildFutureBuilder())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFieldContainer(
                        child: TextFormField(
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                          // onSaved: (newValue) => gluController = newValue! as int,
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
                              labelText: "Name"),
                        ),
                      ),
                      TextFieldContainer(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          // onSaved: (newValue) => gluController = newValue! as int,
                          controller: ageController,
                          cursorColor: kPrimaryColor,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter your age";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                              hintText: 'Age in number. Eg - 40',
                              border: InputBorder.none,
                              labelText: "Age"),
                        ),
                      ),
                      TextFieldContainer(
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2(
                            isExpanded: true,
                            hint: Text(
                              'Select Gender',
                              style: TextStyle(
                                fontSize: 14,
                                color: Theme.of(context).hintColor,
                              ),
                            ),
                            items: gender
                                .map((item) => DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(
                                        item,
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ))
                                .toList(),
                            value: selectedGenderValue, autofocus: true,
                            onChanged: (value) {
                              setState(() {
                                selectedGenderValue = value as String;
                                if (selectedGenderValue == "Male") {
                                  sex = 0;
                                } else {
                                  sex = 1;
                                }
                              });
                            },

                            buttonHeight: 40,
                            buttonWidth: 140,
                            itemHeight: 40,
                            buttonElevation: 2,
                            itemPadding:
                                const EdgeInsets.only(left: 14, right: 14),
                            // dropdownMaxHeight: 200,
                            dropdownWidth:
                                MediaQuery.of(context).size.width * 0.9,
                            dropdownPadding: null,
                            dropdownDecoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: Colors.redAccent,
                            ),
                            dropdownElevation: 8,
                            scrollbarRadius: const Radius.circular(40),
                            scrollbarThickness: 6,
                            scrollbarAlwaysShow: true,
                            offset: const Offset(-20, 0),
                          ),
                        ),
                      ),
                      TextFieldContainer(
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter your Resting BP";
                            }
                            return null;
                          },
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,

                          // onSaved: (newValue) => gluController = newValue! as int,
                          controller: restingBP,
                          cursorColor: kPrimaryColor,
                          decoration: const InputDecoration(
                              hintText: 'Resting Blood Pressure (in mm Hg). Eg - 140',
                              border: InputBorder.none,
                              labelText: "Resting  BP"),
                        ),
                      ),
                      TextFieldContainer(
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter your Cholestrol";
                            }
                            return null;
                          },
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          // onSaved: (newValue) => gluController = newValue! as int,
                          controller: cholesterol,
                          cursorColor: kPrimaryColor,
                          decoration: const InputDecoration(
                              hintText: 'Serum cholestrol in mg/dl.  Eg - 289',
                              border: InputBorder.none,
                              labelText: 'Cholestrol'),
                        ),
                      ),
                      TextFieldContainer(
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2(
                            isExpanded: true,
                            hint: Text(
                              'Fasting Blood Sugar > 120 mg/dl',
                              style: TextStyle(
                                fontSize: 14,
                                color: Theme.of(context).hintColor,
                              ),
                            ),
                            items: fastingBp
                                .map((item) => DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(
                                        item,
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ))
                                .toList(),
                            value: selectedFastingValue, autofocus: true,
                            onChanged: (value) {
                              setState(() {
                                selectedFastingValue = value as String;
                                if (selectedFastingValue == "Yes") {
                                  fbs = 1;
                                } else {
                                  fbs = 0;
                                }
                              });
                            },

                            buttonHeight: 40,
                            buttonWidth: 140,
                            itemHeight: 40,
                            buttonElevation: 2,
                            itemPadding:
                                const EdgeInsets.only(left: 14, right: 14),
                            // dropdownMaxHeight: 200,
                            dropdownWidth:
                                MediaQuery.of(context).size.width * 0.9,
                            dropdownPadding: null,
                            dropdownDecoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: Colors.redAccent,
                            ),
                            dropdownElevation: 8,
                            scrollbarRadius: const Radius.circular(40),
                            scrollbarThickness: 6,
                            scrollbarAlwaysShow: true,
                            offset: const Offset(-20, 0),
                          ),
                        ),
                      ),
                      TextFieldContainer(
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter your Maximum Heart Rate";
                            }
                            return null;
                          },
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          // onSaved: (newValue) => gluController = newValue! as int,
                          controller: maxHr,
                          cursorColor: kPrimaryColor,
                          decoration: const InputDecoration(
                              hintText: 'Maximmum Heart Rate achieved. Eg - 172',
                              border: InputBorder.none,
                              labelText: "MaxHr"),
                        ),
                      ),
                      TextFieldContainer(
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2(
                            isExpanded: true,
                            hint: Text(
                              'Exercise induced Angina.',
                              style: TextStyle(
                                fontSize: 14,
                                color: Theme.of(context).hintColor,
                              ),
                            ),
                            items: excersice
                                .map((item) => DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(
                                        item,
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ))
                                .toList(),
                            value: selectedExcericeValue, autofocus: true,
                            onChanged: (value) {
                              setState(() {
                                selectedExcericeValue = value as String;
                                if (selectedExcericeValue == "Yes") {
                                  excersiceAngina = 1;
                                } else {
                                  excersiceAngina = 0;
                                }
                              });
                            },
                            buttonHeight: 40,
                            buttonWidth: 140,
                            itemHeight: 40,
                            buttonElevation: 2,
                            itemPadding:
                                const EdgeInsets.only(left: 14, right: 14),
                            // dropdownMaxHeight: 200,
                            dropdownWidth:
                                MediaQuery.of(context).size.width * 0.9,
                            dropdownPadding: null,
                            dropdownDecoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: Colors.redAccent,
                            ),
                            dropdownElevation: 8,
                            scrollbarRadius: const Radius.circular(40),
                            scrollbarThickness: 6,
                            scrollbarAlwaysShow: true,
                            offset: const Offset(-20, 0),
                          ),
                        ),
                      ),
                      TextFieldContainer(
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter your Old Peak";
                            }
                            return null;
                          },
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.done,
                          // onSaved: (newValue) => gluController = newValue! as int,
                          controller: oldpeak,
                          cursorColor: kPrimaryColor,
                          decoration: const InputDecoration(
                              hintMaxLines: 2,
                              hintText:
                                  'ST depression induced by exercise relative to rest. Eg - 0.0',
                              border: InputBorder.none,
                              labelText: "Old Peak"),
                        ),
                      ),
                      TextFieldContainer(
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2(
                            isExpanded: true,
                            hint: Text(
                              'Select Chest Pain',
                              style: TextStyle(
                                fontSize: 14,
                                color: Theme.of(context).hintColor,
                              ),
                            ),
                            items: chestPainType
                                .map((item) => DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(
                                        item,
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ))
                                .toList(),
                            value: selectedChestPainValue,
                            onChanged: (value) {
                              setState(() {
                                selectedChestPainValue = value as String;
                                if (selectedChestPainValue ==
                                    "Cheast Pain Type - ASY") {
                                  chestPainAsy = 1;
                                } else if (selectedChestPainValue ==
                                    "Cheast Pain Type - ATA") {
                                  chestPainAta = 1;
                                } else if (selectedChestPainValue ==
                                    "Cheast Pain Type - NAP") {
                                  chestPainNap = 1;
                                } else {
                                  chestPainTa = 1;
                                }
                              });
                            },
                            // buttonHeight: 40,
                            // buttonWidth: 140,
                            // itemHeight: 40,
                            buttonElevation: 2,
                            itemPadding:
                                const EdgeInsets.only(left: 14, right: 14),
                            // dropdownMaxHeight: 200,
                            dropdownWidth:
                                MediaQuery.of(context).size.width * 0.9,
                            dropdownPadding: null,
                            dropdownDecoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: Colors.redAccent,
                            ),
                            dropdownElevation: 8,
                            scrollbarRadius: const Radius.circular(40),
                            scrollbarThickness: 6,
                            scrollbarAlwaysShow: true,
                            offset: const Offset(-20, 0),
                          ),
                        ),
                      ),
                      TextFieldContainer(
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2(
                            isExpanded: true,
                            hint: Text(
                              'Select ECG Type',
                              style: TextStyle(
                                fontSize: 14,
                                color: Theme.of(context).hintColor,
                              ),
                            ),
                            items: restingEcg
                                .map((item) => DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(
                                        item,
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ))
                                .toList(),
                            value: selectedRestingEcgValue,
                            onChanged: (value) {
                              setState(() {
                                selectedRestingEcgValue = value as String;
                                if (selectedRestingEcgValue ==
                                    "Resting ECG - LVH") {
                                  restingECGLvh = 1;
                                } else if (selectedRestingEcgValue ==
                                    "Resting ECG - Normal") {
                                  restingECGNormal = 1;
                                } else {
                                  restingECGSt = 1;
                                }
                              });
                            },
                            // buttonHeight: 40,
                            // buttonWidth: 140,
                            // itemHeight: 40,
                            buttonElevation: 2,
                            itemPadding:
                                const EdgeInsets.only(left: 14, right: 14),
                            // dropdownMaxHeight: 200,
                            dropdownWidth:
                                MediaQuery.of(context).size.width * 0.9,
                            dropdownPadding: null,
                            dropdownDecoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: Colors.redAccent,
                            ),
                            dropdownElevation: 8,
                            scrollbarRadius: const Radius.circular(40),
                            scrollbarThickness: 6,
                            scrollbarAlwaysShow: true,
                            offset: const Offset(-20, 0),
                          ),
                        ),
                      ),
                      TextFieldContainer(
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2(
                            isExpanded: true,
                            hint: Text(
                              'Select ECG Type',
                              style: TextStyle(
                                fontSize: 14,
                                color: Theme.of(context).hintColor,
                              ),
                            ),
                            items: stSlope
                                .map((item) => DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(
                                        item,
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ))
                                .toList(),
                            value: selectedStSlopeValue,
                            onChanged: (value) {
                              setState(() {
                                selectedStSlopeValue = value as String;
                                if (selectedStSlopeValue == "STSlopeDown") {
                                  stSlopeDown = 1;
                                } else if (selectedStSlopeValue ==
                                    "STSlopeFlat") {
                                  stSlopeFlat = 1;
                                } else {
                                  stSlopeUp = 1;
                                }
                              });
                            },
                            // buttonHeight: 40,
                            // buttonWidth: 140,
                            // itemHeight: 40,
                            buttonElevation: 2,
                            itemPadding:
                                const EdgeInsets.only(left: 14, right: 14),
                            // dropdownMaxHeight: 200,
                            dropdownWidth:
                                MediaQuery.of(context).size.width * 0.9,
                            dropdownPadding: null,
                            dropdownDecoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: Colors.redAccent,
                            ),
                            dropdownElevation: 8,
                            scrollbarRadius: const Radius.circular(40),
                            scrollbarThickness: 6,
                            scrollbarAlwaysShow: true,
                            offset: const Offset(-20, 0),
                          ),
                        ),
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.red,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 20),
                              textStyle: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500)),
                          onPressed: () async {
                            setState(() {
                              isLoading = true;
                            });

                            validateAndSave();
                          },
                          child: isLoading
                              ? Center(
                                  child: CircularProgressIndicator(
                                  color: Colors.white,
                                ))
                              : Text("Predict"))
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  void validateAndSave() async {
    final FormState form = _formKey.currentState!;
    if (form.validate()) {
      int result1 = await refresh();
      debugPrint("Future Album  in diabetes 1 ${result1}");

      AuthController().heartData(
          nameController.text,
          ageController.text,
          selectedGenderValue!,
          restingBP.text,
          cholesterol.text,
          selectedFastingValue!,
          maxHr.text,
          selectedExcericeValue!,
          oldpeak.text,
          selectedChestPainValue!,
          selectedRestingEcgValue!,
          selectedStSlopeValue!,
          result1.toString());
      // debugPrint("345666433 $");
      setState(() {
        isSecondPage = true;
        isLoading = false;
      });
      print('Form is valid');
    } else {
      print('Form is invalid');
      setState(() {
        isLoading = false;
      });
    }
  }

  FetchHeartAttack? refresh1;
  int? result;
  Future<int> refresh() async {
    refresh1 = await createAlbum(
        int.parse(ageController.text),
        sex!,
        int.parse(restingBP.text),
        int.parse(cholesterol.text),
        fbs!,
        int.parse(maxHr.text),
        excersiceAngina!,
        double.parse(oldpeak.text),
        chestPainAsy,
        chestPainAta,
        chestPainNap,
        chestPainTa,
        restingECGLvh,
        restingECGNormal,
        restingECGSt,
        stSlopeDown,
        stSlopeFlat,
        stSlopeUp);
    debugPrint("heart 1233445554 $refresh1");
    result = refresh1!.is_heart_dis;
    return result!;
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
              result == 0 ? "assets/smile.png" : "assets/sad.png",
              scale: 0.6,
            )),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            result == 0
                ? "👍🏻Heads Up, you seem perfectly fine."
                : "There's no panic, but it would be fine to visit a doctor around.\nThere might be a possibility of Heart disease.",
            style: GoogleFonts.poppins(
              textStyle: Theme.of(context).textTheme.headline4,
              fontSize: result == 0 ? 48 : 30,
              fontWeight: FontWeight.w700,
              fontStyle: FontStyle.normal,
            ),
          ),
        )
      ],
    );
  }
}
