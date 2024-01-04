import 'package:flutter/material.dart';
import 'package:calculator/buttons.dart';
import 'package:calculator/bmidark.dart';
import 'package:math_expressions/math_expressions.dart';

class DarkMode extends StatefulWidget {
  //const DarkMode({Key? key}) : super(key: key);
  final Function toggleView;
  DarkMode({required this.toggleView});


  @override
  State<DarkMode> createState() => _DarkModeState();
}

class _DarkModeState extends State<DarkMode> {
  var userInput='';
  var answer ='';

  final List<String> buttons = [
    'C',
    '+/-',
    '%',
    'DEL',
    '7',
    '8',
    '9',
    '/',
    '4',
    '5',
    '6',
    'x',
    '1',
    '2',
    '3',
    '-',
    '0',
    '.',
    '=',
    '+',
  ];

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: new AppBar(
        title: Text(
            'Calculator',
          style: TextStyle(
            color: Colors.white
          ),
        ),
        backgroundColor: Colors.indigo[900],
        actions: <Widget>[
          TextButton.icon(
            icon: Icon(Icons.accessibility_new),
            label: Text(
              'BMI',
              style: TextStyle(
                  color: Colors.white
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BMIDark()),
              );
            },
          ),
          TextButton.icon(
            icon: Icon(Icons.light_mode),
            label: Text('Light mode',
              style: TextStyle(
                  color: Colors.white
              ),
            ),
            onPressed: () {
               //Home();
              widget.toggleView();
            },
          )
        ],
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: <Widget>[
          Expanded(
              child: Container(
                //height: 10,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(0,screenSize.width * 0.03,15,0),
                      alignment: Alignment.centerRight,
                      child: Text(
                        userInput,
                        style: TextStyle(fontSize: screenSize.width * 0.07, color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(0,screenSize.width * 0.03,15,0),
                      alignment: Alignment.centerRight,
                      child: Text(
                        answer,
                        style: TextStyle(
                            fontSize: screenSize.width * 0.07,
                            color: Colors.white,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    )
                  ],
                ),
              )
          ),
          Expanded(
              flex: 4,
              child: Container(
                //height: 20,
                child: GridView.builder(
                    itemCount: buttons.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4
                    ),
                    itemBuilder: (BuildContext context, int index){
                      if(index==0){
                        return MyButton(
                          color: Colors.red,
                          textColor: Colors.white,
                          buttonText: 'C',
                          buttontapped: (){
                            setState(() {
                              userInput = '';
                              answer = '0';
                            });
                          },
                        );
                      }
                      else if (index==1) {
                        return MyButton(
                          color: Colors.brown[900],
                          textColor: Colors.white,
                          buttonText: buttons[index],
                          buttontapped: () {
                            toggleSign();
                            // Implement functionality for this button here
                            // For example, perform an action when this button is tapped
                          },
                        );
                      }
                      else if(index==2) {
                        return MyButton(
                          color: Colors.brown[900],
                          textColor: Colors.white,
                          buttonText: '%',
                          buttontapped: () {
                            setState(() {
                              userInput += buttons[index];
                            });
                          },
                        );
                      }
                      else if(index==3) {
                        return MyButton(
                          color: Colors.red,
                          textColor: Colors.white,
                          buttonText: 'DEL',
                          buttontapped: () {
                            setState(() {
                              userInput = userInput.substring(0, userInput.length - 1);
                            });
                          },
                        );
                      }
                      else if(index==18) {
                        return MyButton(
                          color: Colors.red,
                          textColor: Colors.white,
                          buttonText: buttons[index],
                          buttontapped: () {
                            equalPressed();
                          },
                        );
                      }
                      else {
                        return MyButton(
                          color: isOperator(buttons[index])
                              ? Colors.brown[900]
                              : Colors.blueGrey[800],
                          textColor: isOperator(buttons[index])
                              ? Colors.white
                              : Colors.white,
                          buttonText: buttons[index],
                          buttontapped: () {
                            setState(() {
                              userInput += buttons[index];
                            });
                          },
                        );
                      }
                    }
                ),
              )
          ),
        ],
      ),
    );
  }

  bool isOperator(String x) {
    if (x == '/' || x == 'x' || x == '-' || x == '+' || x == '=') {
      return true;
    }
    return false;
  }

  void equalPressed() {
    String finaluserinput= userInput;
    finaluserinput = userInput.replaceAll('x', '*');
    Parser p = Parser();

    Expression exp = p.parse(finaluserinput);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    try {
      double eval = exp.evaluate(EvaluationType.REAL, cm);
      answer = eval.toString();

      setState(() {
        answer = eval.toString(); // Update the answer within setState
      });
    } catch (e) {
      setState(() {
        answer = 'Error'; // Handle errors within setState
      });
    }
  }

  void toggleSign() {
    setState(() {
      if (userInput.isNotEmpty) {
        if (userInput[0] == '-') {
          userInput = userInput.substring(1);
        } else {
          userInput = '-$userInput';
        }
      }
    });
  }
}