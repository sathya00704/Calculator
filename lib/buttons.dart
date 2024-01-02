import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  //const MyButton({Key? key}) : super(key: key);
  final color;
  final textColor;
  final String buttonText;
  final buttontapped;

  //Constructor
  MyButton({required this.color, required this.textColor, required this.buttonText, required this.buttontapped});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttontapped,
      child: Padding(
        padding: const EdgeInsets.all(0),
        child: ClipRRect(
          //borderRadius: BorderRadius.circular(0),
          child: Container(
            //color: color,
            decoration: BoxDecoration(
              color: color,
              border: Border.all(
                color: Colors.black, // Border color
                width: 1, // Border width
              ),
            ),
            child: Center(
              child: Text(
                buttonText,
                style: TextStyle(
                  color: textColor,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
