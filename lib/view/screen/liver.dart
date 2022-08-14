import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:predapp/const.dart';
import 'package:predapp/controller/auth_controller.dart';
import 'package:predapp/modal/liver_modal.dart';
import 'package:predapp/view/screen/auth/login.dart';
import 'package:predapp/view/screen/widget/text_field.dart';

class Liver extends StatefulWidget {
  const Liver({Key? key}) : super(key: key);

  @override
  State<Liver> createState() => _LiverState();
}

class _LiverState extends State<Liver> {
  bool isSecondPage = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();

  final TextEditingController ageController = TextEditingController();
  final TextEditingController totalBilirubinController =
      TextEditingController();
  final TextEditingController directBilirubinController =
      TextEditingController();
  final TextEditingController alkalinePhosphotaseController =
      TextEditingController();
  final TextEditingController alamineAminotransferaseController =
      TextEditingController();
  final TextEditingController totalProtiensController = TextEditingController();
  final TextEditingController albuminController = TextEditingController();
  final TextEditingController albuminGlobulinController =
      TextEditingController();

  final List<String> gender = [
    'Male',
    'Female',
  ];
  String? selectedGenderValue;
  int? sex;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Liver Prediction"),
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
                              hintText: 'Age in number. Eg - 65',
                              border: InputBorder.none,
                              labelText: "Age"),
                        ),
                      ),
                      TextFieldContainer(
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2(
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
                            value: selectedGenderValue,
                            onChanged: (value) {
                              setState(() {
                                selectedGenderValue = value as String;
                                if (selectedGenderValue == "Male") {
                                  sex = 1;
                                } else {
                                  sex = 0;
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
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,

                          // onSaved: (newValue) => gluController = newValue! as int,
                          controller: totalBilirubinController,
                          cursorColor: kPrimaryColor,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter your total bilirubin";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                              hintText: 'Total Bilirubin in mg/dL. Eg - 0.7',
                              border: InputBorder.none,
                              labelText: "Total Bilirubin"),
                        ),
                      ),
                      TextFieldContainer(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,

                          // onSaved: (newValue) => gluController = newValue! as int,
                          controller: directBilirubinController,
                          cursorColor: kPrimaryColor,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter your direct bilirubin";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                              hintText: 'Conjugated Bilirubin in mg/dL. Eg - 0.1',
                              border: InputBorder.none,
                              labelText: 'Direct Bilirubin'),
                        ),
                      ),
                      TextFieldContainer(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,

                          // onSaved: (newValue) => gluController = newValue! as int,
                          controller: alkalinePhosphotaseController,
                          cursorColor: kPrimaryColor,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter your Alkaline Phosphotase";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                              hintText: 'Alkaline Phosphotase in IU/L. Eg - 187',
                              border: InputBorder.none,
                              labelText: 'Alkaline Phosphotase'),
                        ),
                      ),
                      TextFieldContainer(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,

                          // onSaved: (newValue) => gluController = newValue! as int,
                          controller: alamineAminotransferaseController,
                          cursorColor: kPrimaryColor,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter your Alamine Aminotransferase";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                              hintText: 'Alamine Aminotransferase in IU/L. Eg - 16',
                              border: InputBorder.none,
                              labelText: 'Alamine Aminotransferase'),
                        ),
                      ),
                      TextFieldContainer(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,

                          // onSaved: (newValue) => gluController = newValue! as int,
                          controller: totalProtiensController,
                          cursorColor: kPrimaryColor,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter your Total Protiens";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                              hintText: 'Total Protiens in g/dL. Eg - 6.8',
                              border: InputBorder.none,
                              labelText: 'Total Protiens'),
                        ),
                      ),
                      TextFieldContainer(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter your Albumin";
                            }
                            return null;
                          },
                          // onSaved: (newValue) => gluController = newValue! as int,
                          controller: albuminController,
                          cursorColor: kPrimaryColor,
                          decoration: const InputDecoration(
                              hintText: 'Albumin in g/dL. Eg - 3.3',
                              border: InputBorder.none,
                              labelText: 'Albumin'),
                        ),
                      ),
                      TextFieldContainer(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.done,

                          // onSaved: (newValue) => gluController = newValue! as int,
                          controller: albuminGlobulinController,
                          cursorColor: kPrimaryColor,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter your A/G ratio";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                              hintText: 'A/G ratio. Eg - 0.9',
                              border: InputBorder.none,
                              labelText: "Albumin and Globulin Ratio"),
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
      AuthController().liverData(
          nameController.text,
          ageController.text,
          selectedGenderValue!,
          totalBilirubinController.text,
          directBilirubinController.text,
          alkalinePhosphotaseController.text,
          alamineAminotransferaseController.text,
          totalProtiensController.text,
          albuminController.text,
          albuminGlobulinController.text,
          result1.toString());
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

  FetchLiver? refresh1;
  int? result;
  Future<int> refresh() async {
    refresh1 = await createAlbum(
        int.parse(ageController.text),
        sex!,
        double.parse(totalBilirubinController.text),
        double.parse(directBilirubinController.text),
        int.parse(alkalinePhosphotaseController.text),
        int.parse(alamineAminotransferaseController.text),
        double.parse(totalProtiensController.text),
        double.parse(albuminController.text),
        double.parse(albuminGlobulinController.text));
    result = refresh1!.is_liver_disease;
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
              result == 1 ? "assets/smile.png" : "assets/sad.png",
              scale: 0.6,
            )),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            result == 1
                ? "👍🏻Heads Up, you seem perfectly fine."
                : "There's no panic, but it would be fine to visit a doctor around.\nThere might be a possibility of Heart disease.",
            style: GoogleFonts.poppins(
              textStyle: Theme.of(context).textTheme.headline4,
              fontSize: result == 1 ? 48 : 30,
              fontWeight: FontWeight.w700,
              fontStyle: FontStyle.normal,
            ),
          ),
        )
      ],
    );
  }
}
