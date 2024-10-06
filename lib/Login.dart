import 'package:demo/Constant/My_Function.dart';
import 'package:demo/Constant/My_Texts.dart';
import 'package:demo/Constant/My_colors.dart';
import 'package:demo/Provider/Login_Provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Registration.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgBlue,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 25),
            child: Column(mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: height/3.5,),
                Text("Log In",style: TextStyle(fontSize:27,fontWeight: FontWeight.w500,color: clWhite,fontFamily: fontSemibold),),
                Text("Login with your Phone Number",style: TextStyle(fontSize:18,fontWeight: FontWeight.w200,color: clWhite,fontFamily: fontRegular),),
          
                SizedBox(height: 30,),
          
            Consumer<LoginProvider>(
              builder: (context,value,child) {
                return Container(
                  height: 55,
                  width: width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: clWhite,width:1),
                      color: bgBlue,
                      boxShadow: [
                        BoxShadow(
                            color: clWhite,spreadRadius:-3,blurRadius:3
                        )
                      ]
                  ),
                    child: Padding(
                      padding: const EdgeInsets.only(left:9,),
                      child: TextField(
                        controller: value.phoneController,
                        cursorColor:Colors.white,
                        style: TextStyle(color:clWhite,fontSize:18,fontWeight: FontWeight.w500,fontFamily: fontSemibold),
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10),
                          border: InputBorder.none,
                          hintText: "Contact Number",
                          hintStyle: TextStyle(color: clWhite,fontSize:16,fontWeight: FontWeight.w300,fontFamily: fontRegular),
                          focusedBorder:
                          OutlineInputBorder(borderRadius: BorderRadius.circular(22),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),


                );
              }
            ),
                SizedBox(height:height/15,),
          
                Consumer<LoginProvider>(
                  builder: (context,value,child) {
                    return InkWell(
                      onTap: (){

                        if(
                          value.phoneController.text.length==10&&value.phoneController.text!=''
                        ){
                          value.sendOtp(context);
                        } else{
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              backgroundColor: Colors.white,
                              content: Text("Enter Valid PhoneNumber", style: TextStyle(color:bgBlue,fontSize: 15,fontWeight: FontWeight.w800,fontFamily: fontbold))));
                        }
                        value.clearOtp();
                      },
                      child: Center(
                        child: Container(
                          height: 45,
                          width: width/3,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white.withOpacity(0.8)
                          ),
                          child: Center(
                            child:
                            value.loader?CircularProgressIndicator(color:bgBlue,):
                            Text("Login",style: TextStyle(color:bgBlue,fontSize:19,fontWeight: FontWeight.w700,fontFamily: fontSemibold),
                                              ),
                          ),
                      ),
                    )
                    );
                  }
                ),
                SizedBox(height: height/4.5,),
                Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an Account?",style: TextStyle(color:clWhite,fontSize:15,fontWeight: FontWeight.w400,fontFamily: fontRegular),),
                    InkWell(
                      onTap: (){
                        callNextReplacement(context, Registration(from: "NEW",loginusrid: '',));
                      },
                        child: Text("Register Now",style: TextStyle(color:Colors.blue.shade300,fontSize:16,fontWeight: FontWeight.w400,fontFamily: fontRegular),))
                  ],
                )
              ],
            ),
          ),
        ),

      ),
    );
  }
}
