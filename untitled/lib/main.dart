import 'package:flutter/material.dart';

void main() {
  runApp(myApp());
}

class myApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.blueAccent), home: demo(),);
  }
}

class demo extends StatefulWidget {
  @override
  demoState createState() => demoState();
}

class demoState extends State<demo> {

  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  double? result1;
  String bmi_status = "";
  bool vaildateh=false,validatew=false;

  MaterialColor? getTextColor(String s1) {
    if (s1 == "正常") {
      return Colors.green;
    } else if (s1 == "過輕") {
      return Colors.grey;
    } else if (s1 == "肥胖") {
      return Colors.red;
    }
    @override
    void dispose(){
      heightController.dispose();
      weightController.dispose();
      super.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      title: Text("BMl 計算機"), centerTitle: true, backgroundColor: Colors.grey,),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: heightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'height in cm',
                hintText: "cm",
                errorText:vaildateh? "輸入身高!!!!":null,
                icon: Icon(Icons.trending_up),
              ),
              style: TextStyle(fontSize: 22),
            ),
            SizedBox(height: 20),
            TextField(
              controller: weightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'weight in Kg',
                hintText: "kg",
                icon: Icon(Icons.trending_down),
                errorText: validatew?"輸入體重!!體重!!":null
              ),
              style: TextStyle(fontSize: 22),
            ),
            SizedBox(height: 15),
            ElevatedButton(
              child: Text("計算", style: TextStyle(color: Colors.white),),
              onPressed: (){
                setState(() {
                  heightController.text.isEmpty? vaildateh=true:vaildateh=false;
                  weightController.text.isEmpty? validatew=true:validatew=false;
                });

                calculateBMI();},
              style: ElevatedButton.styleFrom(
                  textStyle: TextStyle(fontSize: (22))),
            ),
            SizedBox(height: 15),
            Text(
              result1 == null ? "輸入數值有那麼困難嗎!?" : "您的BMl值=${result1
                  ?.toStringAsFixed(2)},太神啦",
              style: TextStyle(color: Colors.redAccent,
                  fontSize: 25,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 15),
            RichText(
                text: TextSpan(style: TextStyle(color: Colors.blueAccent,
                    fontSize: 22,
                    fontWeight: FontWeight.w500),
                    children: <TextSpan>[
                      TextSpan(text: bmi_status == null ? "" : "您的體重狀態為:"),
                      TextSpan(text: bmi_status == null ? "" : "${bmi_status}",
                          style: TextStyle(color: getTextColor(bmi_status),
                              fontWeight: FontWeight.bold)),
                    ])),

          ],
        ),
      ),
    );
  }

  void calculateBMI() {
    double h = double.parse(heightController.text) / 100;
    double w = double.parse(weightController.text);
    double result = w / (h * h);
    result1 = result;
    if (result1! < 18.5) {
      bmi_status = "過輕";
    }
    else if (result1! < 22.5) {
      bmi_status = "正常";
    } else
      bmi_status = "肥胖";
    setState(() {});
  }
}
