import 'dart:convert';
import 'package:http/http.dart' as http;

String data = '';
FetchLiver fetchLiverFromJson(String str) =>
    FetchLiver.fromJson(json.decode(str));

String fetchLiverToJson(FetchLiver data) =>
    json.encode(data.toJson());


Future<FetchLiver> createAlbum(
    int age,
    int gender,
    double totalBilirubin,
    double directBilirubin,
    int alkalinePhosphotase,
    int alamineAminotransferase,
    double totalProtiens,
    double albumin,
    double albuminAndGlobulinRatio
    ) async {
  final response = await http.post(
    Uri.parse('https://disease-12.herokuapp.com/liver'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      "Age": age,
      "Gender": gender,
        "Total_Bilirubin": totalBilirubin,
      "Direct_Bilirubin": directBilirubin,
      "Alkaline_Phosphotase": alkalinePhosphotase,
      "Alamine_Aminotransferase": alamineAminotransferase,
      "Total_Protiens": totalProtiens,
      "Albumin": albumin,
      "Albumin_and_Globulin_Ratio": albuminAndGlobulinRatio
    }),
  );
  print(response.body);
  
  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return fetchLiverFromJson(response.body);
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create album.');
  }
}

class FetchLiver {
  FetchLiver({
    required this.is_liver_disease,
  });

  int is_liver_disease;

  factory FetchLiver.fromJson(Map<String, dynamic> json) =>
      FetchLiver(
        is_liver_disease: json["is_liver_disease"],
      );

  Map<String, dynamic> toJson() => {
        "is_liver_disease": is_liver_disease,
      };
}
