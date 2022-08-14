import 'dart:convert';
import 'package:http/http.dart' as http;

String data = '';
FetchHeartAttack fetchHeartAttackFromJson(String str) =>
    FetchHeartAttack.fromJson(json.decode(str));

String fetchHeartAttackToJson(FetchHeartAttack data) =>
    json.encode(data.toJson());
Future<FetchHeartAttack> createAlbum(
    int age,
    int sex,
    int restingBp,
    int cholesterol,
    int fastingBS,
    int maxHr,
    int exerciseAngina,
    double oldPeak,
    int cheastPainTypeASY,
    int cheastPainTypeATA,
    int cheastPainTypeNAP,
    int cheastPainTypeTA,
    int restingECGLVH,
    int restingECGNormal,
    int restingECGST,
    int stSlopeDown,
    int stSlopeFlat,
    int stSlopeUp) async {
  final response = await http.post(
    Uri.parse('https://disease-12.herokuapp.com/heart'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      "age": age,
      "sex": sex,
      "RestingBP": restingBp,
      "Cholesterol": cholesterol,
      "FastingBS": fastingBS,
      "MaxHr": maxHr,
      "ExerciseAngina": exerciseAngina,
      "Oldpeak": oldPeak,
      "CheastPainTypeASY": cheastPainTypeASY,
      "CheastPainTypeATA": cheastPainTypeATA,
      "CheastPainTypeNAP": cheastPainTypeNAP,
      "CheastPainTypeTA": cheastPainTypeTA,
      "RestingECGLVH": restingECGLVH,
      "RestingECGNormal": restingECGNormal,
      "RestingECGST": restingECGST,
      "STSlopeDown": stSlopeDown,
      "STSlopeFlat": stSlopeFlat,
      "STSlopeUp": stSlopeUp
    }),
  );
  print(response.body);
  print("""CheastPainTypeASY: $cheastPainTypeASY,
      CheastPainTypeATA: $cheastPainTypeATA,
      CheastPainTypeNAP: $cheastPainTypeNAP,
      CheastPainTypeTA: $cheastPainTypeTA""");
  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return fetchHeartAttackFromJson(response.body);
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create album.');
  }
}

class FetchHeartAttack {
  FetchHeartAttack({
    required this.is_heart_dis,
  });

  int is_heart_dis;

  factory FetchHeartAttack.fromJson(Map<String, dynamic> json) =>
      FetchHeartAttack(
        is_heart_dis: json["is_heart_dis"],
      );

  Map<String, dynamic> toJson() => {
        "is_heart_dis": is_heart_dis,
      };
}
