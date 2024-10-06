import 'package:demo/Constant/My_Texts.dart';
import 'package:demo/Constant/My_colors.dart';
import 'package:demo/Provider/Main_Provider.dart';
import 'package:flutter/material.dart';
import 'package:otp_timer_button/otp_timer_button.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

import 'Provider/Login_Provider.dart';



class Otp extends StatelessWidget {
  const Otp({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgBlue,
      
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Text("Enter Your OTP",style: TextStyle(fontWeight:FontWeight.w700,fontSize: 25,color: clWhite,fontFamily: fontSemibold),),
              Text("Please enter the verification code",style: TextStyle(fontSize:16,fontWeight:FontWeight.w400,color: clWhite,fontFamily:fontMedium ),),
              SizedBox(height: 20,),
              Consumer<LoginProvider>(
                  builder: (context,value,child) {
                    return Pinput(
                      controller:value.otpController,
                      length: 6,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      defaultPinTheme: PinTheme( decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: bgBlue,),
                        borderRadius: BorderRadius.circular(15),
                      ),
                        textStyle: TextStyle(fontWeight: FontWeight.w700,fontSize: 21,color:bgBlue, fontFamily: fontSemibold),
                        height: 50,
                        width: 50,

                      ),

                      onCompleted: (pin){
                        value.verify(context);

                      },
                    );
                  }
              ),
              SizedBox(height: 20,),
              Center(

                child: OtpTimerButton(
                  backgroundColor: Colors.white,
                  // controller: controller,
                  onPressed: () {},
                  text: Text('OTP auto resend in ',style: TextStyle(
                    color: clWhite,
                    fontWeight: FontWeight.w500,fontSize: 16,fontFamily: fontMedium ),),
                  duration: 60,
                ),
              ),
              SizedBox(height: 80,),
              Consumer<TestProvider>(
                builder: (context,value,child) {
                  return Center(
                    child: Container(
                      height: 45,
                      width: width/3,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white.withOpacity(0.8)
                      ),
                      child: Center(
                        child: Text("Finish",style: TextStyle(color:bgBlue,fontSize:19,fontWeight: FontWeight.w700,fontFamily: fontSemibold),
                        ),
                      ),
                    ),
                  );
                }
              ),
              SizedBox(height: 80,),

            ],
          ),
        ),
      ),
    );
  }
}
