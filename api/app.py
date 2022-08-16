# This is a sample Python script.

# Press Shift+F10 to execute it or replace it with your code.
# Press Double Shift to search everywhere for classes, files, tool windows, actions, and settings.


from flask import Flask, render_template, url_for, flash, redirect , json
import joblib
from flask import request
import numpy as np
app = Flask(__name__)

@app.route("/heart",methods=['POST'])
def heart_dis():
    if request.method=='POST':
        # Age(40) , Sex (0), RestingBP (140), Cholesterol (289), FastingBS (0), MaxHr (172), ExerciseAngina (0), Oldpeak (0.0),
        # 	CheastPain Type- ASY (0),CheastPain Type- ATA (1), CheastPain Type- NAP (0), CheastPain Type- TA (0),
        #  	RestingECG - LVH (0), RestingECG - Normal (1),RestingECG - ST (0), ST_Slope - Down (0), ST_Slope - Flat (0),
        # 	ST_Slope - Up (1)
        json_data = request.json
        age = json_data['age']
        sex = json_data['sex']
        restingBP = json_data["RestingBP"]
        cholesterol = json_data["Cholesterol"]
        fastingBS = json_data["FastingBS"]
        maxHr = json_data["MaxHr"]
        exerciseAngina = json_data["ExerciseAngina"]
        oldpeak = json_data["Oldpeak"]
        cheastPainTypeASY  = json_data['CheastPainTypeASY']
        cheastPainTypeATA  = json_data['CheastPainTypeATA']
        cheastPainTypeNAP  = json_data['CheastPainTypeNAP']
        cheastPainTypeTA  = json_data['CheastPainTypeTA']
        restingECG_LVH = json_data["RestingECGLVH"]
        restingECG_Normal = json_data["RestingECGNormal"]
        restingECG_ST = json_data["RestingECGST"]
        stSlopeDown = json_data["STSlopeDown"]
        stSlopeFlat = json_data["STSlopeFlat"]
        stSlopeUp = json_data["STSlopeUp"]


        # exang = json_data['exang']
        # print("a"+str(cp)+"b"+str(trestbps)+"c"+str(chol))
        to_predict = np.array([age ,sex,restingBP, cholesterol, fastingBS, maxHr, exerciseAngina, oldpeak,cheastPainTypeASY,cheastPainTypeATA,cheastPainTypeNAP,cheastPainTypeTA,restingECG_LVH,restingECG_Normal,restingECG_ST,stSlopeDown,stSlopeFlat,stSlopeUp]).reshape(1,18)
        print(to_predict)
        loaded_model = joblib.load("model/heart_new.pkl")
        result = loaded_model.predict(to_predict.tolist())
        print("ersult:" + str(result))
        response = app.response_class(
            response=json.dumps({"is_heart_dis": result.tolist()[0]}),
            status=200,
            mimetype='application/json'
        )
        return response


@app.route("/liver",methods=['POST'])
def liver():
    if request.method=='POST':
        json_data = request.json
        age = json_data['Age']
        sex = json_data['Gender']
        total_bilirubin = json_data['Total_Bilirubin']
        direct_bilirubin = json_data['Direct_Bilirubin']
        alkaline_phosphotase = json_data["Alkaline_Phosphotase"]
        alamine_amino = json_data["Alamine_Aminotransferase"]
        total_protiens = json_data["Total_Protiens"]
        albumin = json_data["Albumin"]
        albumin_and_globin = json_data["Albumin_and_Globulin_Ratio"]
        to_predict = np.array(
            [age, sex, total_bilirubin, direct_bilirubin, alkaline_phosphotase, alamine_amino, total_protiens, albumin, albumin_and_globin]).reshape(1, 9)
        loaded_model = joblib.load("model/liver_new.pkl")
        result = loaded_model.predict(to_predict)
        response = app.response_class(
            response=json.dumps({"is_liver_disease": result.tolist()[0]}),
            status=200,
            mimetype='application/json'
        )
        return response

if __name__ == "__main__":
    app.run(debug=False)

