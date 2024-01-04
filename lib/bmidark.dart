import 'package:flutter/material.dart';
import 'package:calculator/constants/constantsdark.dart';
import 'package:calculator/loading.dart';

class BMIDark extends StatefulWidget {
  const BMIDark({Key? key}) : super(key: key);

  @override
  State<BMIDark> createState() => _BMIDarkState();
}

class _BMIDarkState extends State<BMIDark> {
  String height = '';
  String weight = '';
  String age = '';
  String gender='Male';

  String error='';
  bool loading=false;

  String bmireport = '';
  String bmivalue='';
  Color bmicolor = Colors.red;

  double bmi=0;

  final numericRegex = RegExp(r'^[0-9]+$');
  final _formKey =GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('BMI Calculator'),
        backgroundColor: Colors.indigo[900],
      ),
      body: SingleChildScrollView(
        child: Container (
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 10),
                Text(
                  'Height (in cm)',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Enter your Height'),
                  style: TextStyle(color: Colors.white),
                  keyboardType: TextInputType.number,
                  validator: (val) {
                    if (val==null || val.isEmpty) {
                      return 'Please enter a valid height';
                    }
                    if(!numericRegex.hasMatch(val)){
                      return 'Please enter only numeric values';
                    }
                    final heightval = int.tryParse(val);
                    if(heightval == null || heightval<1 || heightval>275){
                      return 'Height should be between 1-275';
                    }
                    return null;
                  },
                  onChanged: (val) {
                    setState(() {
                      height = val;
                    });
                  },
                ),
                SizedBox(height: 10),
                Text(
                  'Weight (in kg)',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Enter your Weight'),
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: Colors.white),
                  validator: (val) {
                    if (val==null || val.isEmpty) {
                      return "Please enter a valid weight";
                    }
                    if(!numericRegex.hasMatch(val)){
                      return 'Please enter only numeric values';
                    }
                    final weightval = int.tryParse(val);
                    if(weightval == null || weightval<1 || weightval>700){
                      return 'Weight should be between 1-700';
                    }
                    return null;
                  },
                  onChanged: (val) {
                    setState(() {
                      weight = val;
                    });
                  },
                ),
                SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      //print('button is pressed');
                      //print(' answer = $height $weight $age $gender');
                      if(_formKey.currentState?.validate() ?? false){
                        showBMI();
                        //errormsg('Successful');
                      }
                    },
                    child: Text
                      (
                        'Calculate BMI'
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.indigo[900],
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  error,
                  style: TextStyle(color: Colors.red, fontSize: 16.0),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  /*void errormsg(msg){
    setState(() {
      error = msg;
    });
  }*/

  void showBMI() {
    //print('Hello');
    calculateBMI();
    showDialog(
        context: context,
        builder:(BuildContext context) {
          return AlertDialog(
            title: Text('Your BMI Details',
            style: TextStyle(
              color: Colors.white
            ),),
            backgroundColor: Colors.black,
            content: SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      bmireport,
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: bmicolor),
                    ),
                    SizedBox(height: 10),
                    Text('Height=$height cms \nWeight=$weight kgs',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    SizedBox(height: 10),
                    Text('Your BMI value:',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    SizedBox(height: 10),
                    Text('$bmivalue kg/m\u00B2',
                      style: TextStyle(fontSize: 18, color: bmicolor, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),
                    Text('BMI RANGES:',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    SizedBox(height: 10),
                    Text('Underweight:\nBMI less than 18.4\n\nNormal weight:\nBMI between 18.5 and 24.9\n\nOverweight:\nBMI between 25 and 29.9\n\nObesity:\nBMI of 30 or greater',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),

                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                  onPressed: (){
                    Navigator.of(context).pop();
                    setState(() {
                      height='';
                      weight='';
                    });
                    //print('height=$height, weight=$weight');
                    _formKey.currentState?.reset();
                  },
                  child: Text('OK')
              ),
            ],
          );
        }
    );
  }

  void calculateBMI(){
    //final ageval = int.tryParse(age) ?? 0;
    final weightval = int.tryParse(weight) ?? 0;
    final heightval = int.tryParse(height) ?? 0;

    double heightinm=0;

    try{
      heightinm=heightval/100;
      //print('heightinm=$heightinm');
      bmi=weightval/(heightinm*heightinm);
      //print('bmi= $bmi');
      bmicolor = Colors.red;

      if(bmi<18.5){
        bmireport='UNDERWEIGHT';
      }
      else if (bmi>=18.5 && bmi<=24.9){
        bmireport='NORMAL WEIGHT';
        bmicolor = Colors.green;
      }
      else if(bmi>=25 && bmi<=29.9){
        bmireport='OVERWEIGHT';
      }
      else if(bmi>30){
        bmireport='OBESITY';
      }
      else{
        bmireport='ERROR';
      }
      bmivalue = bmi.toString();
    }
    catch(e){
      print('error = $e');
    }
    //print('hw = $heightval $weightval');
  }
}