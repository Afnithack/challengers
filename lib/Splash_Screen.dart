import 'dart:async';

import 'package:demo/Login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Constant/My_Function.dart';
import 'Provider/Login_Provider.dart';

class SpalshScreen extends StatefulWidget {
  const SpalshScreen({super.key});

  @override
  State<SpalshScreen> createState() => _SpalshScreenState();
}

class _SpalshScreenState extends State<SpalshScreen> {
  @override

  void initState() {
    LoginProvider loginProvider =
    Provider.of<LoginProvider>(context, listen: false);

    FirebaseAuth auth = FirebaseAuth.instance;
    var loginUser = auth.currentUser;

    Timer( Duration(seconds: 5), () {
      print("hjkl"+loginUser.toString());
      if(loginUser==null){
        callNextReplacement(context, LoginScreen());
      }else{
        loginProvider.userAuthorized(loginUser.phoneNumber, context);

      }
    });
    super.initState();
  }

  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(

        body:
        Container(
               height: height,
              width: width,
              color: Color(0xff172D3B),
              child: Column(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Challengers",style: TextStyle(fontSize:27,fontWeight: FontWeight.w500,color: Colors.white),),
                  Text("Champions League",style: TextStyle(fontSize:18,fontWeight: FontWeight.w200,color: Colors.white),),
                ],
              )
        ),
      ),
    );
  }
}
