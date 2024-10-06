import 'package:demo/Admin/User_list.dart';
import 'package:demo/Constant/My_Function.dart';
import 'package:demo/Constant/My_Texts.dart';
import 'package:demo/Constant/My_colors.dart';
import 'package:demo/Provider/Main_Provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Login.dart';


class Registration extends StatelessWidget {
  String from;
  String loginusrid;
  Registration({super.key,required this.from,required this.loginusrid});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
       backgroundColor: bgBlue,

        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 28),
            child: Column(mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 70,),
                Text("Register",style: TextStyle(fontSize:27,fontWeight: FontWeight.w500,color: clWhite,fontFamily: fontMedium),),
                Text("Register Your Account",style: TextStyle(fontSize:18,fontWeight: FontWeight.w200,color: clWhite,fontFamily: fontRegular),),
          
                SizedBox(height:20,),
          
                InkWell(
                  onTap: (){
                    showBottomSheet(context);
                  },
                  child: Consumer<TestProvider>(
                    builder: (context,value,child) {
                      return value.userFile !=null?
                        Center(
                          child: Container(
                            height: 105,
                            width: 110,
                            decoration: BoxDecoration(
                                color:Color(0xff172D3B),
                                shape: BoxShape.circle,
                                border: Border.all(color: clWhite,width: 1),
                              image: DecorationImage(image: FileImage(value.userFile!),fit: BoxFit.fill)
                            ),
                          ),
                        ):value.userImgUrl !=""?
                        Center(
                        child: Container(
                          height: 105,
                          width: 110,
                          decoration: BoxDecoration(
                              color:Color(0xff172D3B),
                              shape: BoxShape.circle,
                              border: Border.all(color: clWhite,width: 1),
                            image: DecorationImage(image: NetworkImage(value.userImgUrl),fit: BoxFit.fill)
                          ),
                        ),
                      ):

                      Stack(
                        children:[ Center(
                          child: Container(
                            height: 105,
                            width: 110,
                            decoration: BoxDecoration(
                              color:bgBlue,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white,width: 1)
                            ),
                            child: Icon(Icons.person,size:42,color: clWhite,),
                          ),
                        ),
                          Positioned(top:76,
                              left: 179,
                              child: CircleAvatar(
                                radius: 13,
                                backgroundColor: Colors.white,
                                child: Icon(Icons.add,color:bgBlue,size: 17,),
                              )),
                        ],
                      );
                    }
                  ),
                ),
          
          
                SizedBox(height:20,),
          
                Container(
                  height: 55,
                  width: width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.white,width:1),
                      color: bgBlue,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.white,spreadRadius:-3,blurRadius:3
                        )
                      ]
                  ),
                  child:  Padding(
                    padding: const EdgeInsets.only(left:9,),
                    child: Consumer<TestProvider>(
                      builder: (context,value,child) {
                        return TextField(
                          controller: value.nameController,
                          cursorColor:Colors.white,
                          style: TextStyle(color:Colors.white,fontSize:18,fontWeight: FontWeight.w500),
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(10),
                            border: InputBorder.none,
                            hintText: "Enter Your Name",
                            hintStyle: TextStyle(color: Colors.white,fontSize:16,fontWeight: FontWeight.w300),
                            focusedBorder:
                            OutlineInputBorder(borderRadius: BorderRadius.circular(22),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        );
                      }
                    ),
                  ),
          
                ),
                SizedBox(height: 10,),
          
                Container(
                  height: 55,
                  width: width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.white,width:1),
                      color: Color(0xff172D3B),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.white,spreadRadius:-3,blurRadius:3
                        )
                      ]
                  ),
                  child:Padding(
                    padding: const EdgeInsets.only(left:9,),
                    child: Consumer<TestProvider>(
                      builder: (context,value,child) {
                        return TextField(
                          controller: value.phoneController,
                          cursorColor:Colors.white,
                          style: TextStyle(color:Colors.white,fontSize:18,fontWeight: FontWeight.w500),
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(10),
                            border: InputBorder.none,
                            hintText: "Phone Number",
                            hintStyle: TextStyle(color: Colors.white,fontSize:16,fontWeight: FontWeight.w300),
                            focusedBorder:
                            OutlineInputBorder(borderRadius: BorderRadius.circular(22),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        );
                      }
                    ),
                  ),
          
                ),
                SizedBox(height: 10,),
          
                Container(
                  height: height/8,
                  width: width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.white,width:1),
                      color: Color(0xff172D3B),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.white,spreadRadius:-3,blurRadius:3,
                        )
                      ]
                  ),

                    child: Padding(
                      padding: const EdgeInsets.only(left:9,),
                      child: Consumer<TestProvider>(
                        builder: (context,value,child) {
                          return TextField(
                            controller: value.addressController,
                            cursorColor:Colors.white,
                            style: TextStyle(color:Colors.white,fontSize:18,fontWeight: FontWeight.w500),
                            keyboardType: TextInputType.text,
                            maxLines: 5,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(10),
                              border: InputBorder.none,
                              hintText: "Address",
                              hintStyle: TextStyle(color: Colors.white,fontSize:16,fontWeight: FontWeight.w300),
                              focusedBorder:
                              OutlineInputBorder(borderRadius: BorderRadius.circular(22),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          );
                        }
                      ),
                    ),

          
                ),
                SizedBox(height: 40,),
          
                Consumer<TestProvider>(
                  builder: (context,value,child) {
                    return InkWell(
                        onTap: ()async{
                          bool ischeck= await value.CheckExistingNumber(value.phoneController.text);

                          if(! ischeck){
                            if(from=="EDIT"){
                              value.AddCustomer(from, loginusrid);
                              callNext(context, UserList());
                              finish(context);

                            }
                            else{
                              value.AddCustomer(from, loginusrid);
                              callNextReplacement(context, LoginScreen());
                            }
                          }
                          else{
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Number Already Existed"))
                            );
                          }

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
                              child: Text("Submit",style: TextStyle(color:Color(0xff172D3B),fontSize:19,fontWeight: FontWeight.w700),
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
        ),
      ),
    );
  }
}

void showBottomSheet(BuildContext context) {
  TestProvider provider =
  Provider.of<TestProvider>(context, listen: false);

  showModalBottomSheet(
      elevation: 10,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.0),
            topRight: Radius.circular(10.0),
          )),
      context: context,
      builder: (BuildContext bc) {
        return Wrap(
          children: <Widget>[
            ListTile(
                leading: Icon(
                  Icons.camera_enhance_sharp,
                  color: Colors.black,
                ),
                title: const Text(
                  'Camera',
                ),
                onTap: () =>
                {provider.getProfileImagecamera(), Navigator.pop(context)}),
            ListTile(
                leading: Icon(Icons.photo, color: Colors.black),
                title: const Text(
                  'Gallery',
                ),
                onTap: () =>
                {provider.getProfileImagegallery(), Navigator.pop(context)}),
          ],
        );
      });
  //ImageSource
}
