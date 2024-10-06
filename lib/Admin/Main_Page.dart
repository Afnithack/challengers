import 'package:demo/Login.dart';
import 'package:demo/Constant/My_Function.dart';
import 'package:demo/Provider/Main_Provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Home.dart';
import 'User_list.dart';


class MainPage extends StatelessWidget {

  MainPage({super.key,});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff172D3B),
        body: Column(mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Align(alignment: Alignment.centerRight,
              child: InkWell(
                onTap: (){
                  FirebaseAuth auth = FirebaseAuth.instance;
                  auth.signOut();
                  callNextReplacement(context, LoginScreen());
                },
                child: Container(
                    height: 35,
                    width: 90,
                    decoration: BoxDecoration(
                        color: Color(0xff172D3B),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(width: 1,color: Colors.white)

                    ),
                    child: Row(mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Logout",style: TextStyle(color:Colors.white,fontSize:15,fontWeight: FontWeight.w500),
                        ),
                        SizedBox(width: 5,),
                        Icon(Icons.logout,size: 15,color:Colors.white,),
                      ],
                    ),),
              ),
            ),
            SizedBox(height:height/4,),

            Text("Challengers",style: TextStyle(fontSize:27,fontWeight: FontWeight.w500,color: Colors.white),),
            Text("Champions League",style: TextStyle(fontSize:18,fontWeight: FontWeight.w200,color: Colors.white),),

            SizedBox(height: 50,),

            Consumer<TestProvider>(
              builder: (context,value,child) {
                return InkWell(
                    onTap: (){
                      value.GetCutomerdtls();
                      callNext(context, UserList());
                    },
                    child: Center(
                      child: Container(
                        height: 45,
                        width: width/2,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white.withOpacity(0.8)
                        ),
                        child: Center(
                          child: Text("User List",style: TextStyle(color:Color(0xff172D3B),fontSize:19,fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                    )
                );
              }
            ),
            SizedBox(height: 10,),
            Consumer<TestProvider>(
              builder: (context,value,child) {
                return InkWell(
                    onTap: (){
                      value.GetGames();
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Home2()));
                    },
                    child: Center(
                      child: Container(
                        height: 45,
                        width: width/2,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white.withOpacity(0.8)
                        ),
                        child: Center(
                          child: Text("Home",style: TextStyle(color:Color(0xff172D3B),fontSize:19,fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                    )
                );
              }
            ),

          ],
        ),
      ),
    );
  }
}
