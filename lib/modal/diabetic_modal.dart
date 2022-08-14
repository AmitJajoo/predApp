import 'dart:convert';
import 'package:http/http.dart' as http;

String data = '';
FetchDiabetic fetchDiabeticFromJson(String str) =>
    FetchDiabetic.fromJson(json.decode(str));

String fetchDiabeticToJson(FetchDiabetic data) => json.encode(data.toJson());
Future<FetchDiabetic> createAlbum(int preg, int glucose, int bp, int skin,
    int insulin, double bmi, double dpf, int age) async {
  final response = await http.post(
    Uri.parse('https://flask-api-amit.herokuapp.com/api/v1/predict_diabetes'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      "pregnancies": preg,
      "glucose": glucose,
      "bloodpressure": bp,
      "skinthickness": skin,
      "insulin": insulin,
      "bmi": bmi,
      "dpf": dpf,
      "age": age
    }),
  );
  print(response.body);
  print("object");
  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return fetchDiabeticFromJson(response.body);
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create album.');
  }
}

class FetchDiabetic {
  FetchDiabetic({
    required this.isDiabetic,
  });

  String isDiabetic;

  factory FetchDiabetic.fromJson(Map<String, dynamic> json) => FetchDiabetic(
        isDiabetic: json["isDiabetic"],
      );

  Map<String, dynamic> toJson() => {
        "isDiabetic": isDiabetic,
      };
}
