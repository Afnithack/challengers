import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget otpbox(double height, double width,){
  return Padding(
    padding: const EdgeInsets.only(left:3,right: 3),
    child: Container(height: height,width: width,
      decoration: BoxDecoration(color: Colors.white.withOpacity(0.4),
          borderRadius: BorderRadius.circular(10)),
      child: Center(
        child: TextField(keyboardType: TextInputType.number,
          inputFormatters: [LengthLimitingTextInputFormatter(1)],
          decoration: InputDecoration(

              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10)
              )
          ),
          style: TextStyle(color: Colors.white,fontSize:21),
        ),
      ),

    ),
  );
}