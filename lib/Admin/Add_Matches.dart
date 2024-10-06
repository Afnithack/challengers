import 'package:demo/Constant/My_Function.dart';
import 'package:demo/Constant/My_colors.dart';
import 'package:demo/Provider/Main_Provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Constant/My_Texts.dart';
import 'Home.dart';

class AddMatches extends StatelessWidget {
  String from;
  String gid;
  AddMatches ({super.key,required this.from,required this.gid});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor:bgBlue,
        appBar: AppBar(
          backgroundColor: bgBlue,
          leading:  InkWell(
              onTap: (){
            callNext(context, Home2());              },
              child:Icon(Icons.arrow_back_ios_new,color:clWhite,size: 20,)
          ),
          title: Text("Add Matches",style: TextStyle(fontWeight: FontWeight.w500,fontSize: textSize20,color:clWhite,fontFamily: fontSemibold ),),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal:30),
          child: Column(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap:(){
                        showBottomSheet(context);
                        },
                      child: Consumer<TestProvider>(
                        builder: (context,value,child) {
                          return value.fileImage != null
                            ?Container(
                            height: 100,
                            width: width,
                            decoration: BoxDecoration(
                                color: bgBlue,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(width: 1.5,color: Colors.white.withOpacity(0.5),),
                              image: DecorationImage(image: FileImage(value.fileImage!),fit: BoxFit.fill)
                            ),
                          ): value.imageUrl !=""
                          ? Center(
                          child: Container(
                            height: 100,
                            width: width,
                            decoration: BoxDecoration(
                                color: bgBlue,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(width: 1.5,color: Colors.white.withOpacity(0.5)),
                            ),
                          child: Image(image:NetworkImage(value.imageUrl,),fit: BoxFit.fill,)
                          ),
                          )
                              : Center(
                          child:Container(
                              height: 100,
                              width: width,
                              decoration: BoxDecoration(
                                color: bgBlue,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(width: 1.5,color: Colors.white.withOpacity(0.5)),
                              ),
                            child: Row(
                              children: [
                                Icon(Icons.image_outlined,size:90,color: Colors.white.withOpacity(0.3),),
                                Text("Add Image",style: TextStyle(fontWeight: FontWeight.w400,fontSize: textSize21,color:Colors.white.withOpacity(0.4),fontFamily: fontSemibold),)
                              ],
                            ),

                          ),
                          );
                        }
                      ),
                    ),
                    SizedBox(height:5,),
                    Row(
                      children: [
                        Consumer<TestProvider>(
                          builder: (context,value,child) {
                            return Container(
                                height: 50,
                                width: width/2.55,
                                decoration: BoxDecoration(
                                    color: bgBlue,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(width: 1.5,color: Colors.white.withOpacity(0.5))
                                ),
                                child: InkWell(
                                  child: Center(
                                    child: TextField(
                                      controller:value.dateController,
                                      cursorColor:clWhite,
                                      style: TextStyle(color:clWhite,fontSize:16,fontWeight: FontWeight.w500,fontFamily: fontSemibold),
                                     decoration: InputDecoration(
                                       contentPadding: EdgeInsets.all(10),
                                       border: InputBorder.none,
                                       hintText: "Select Date",
                                       hintStyle: TextStyle(color: Colors.white.withOpacity(0.5),fontSize:textSize12,fontWeight: FontWeight.w400,fontFamily: fontRegular),
                                    ),
                                    onTap: (){
                                      value.selectDate(context);
                                    },
                                                                      ),
                                  ),
                                                                )

                            );
                          }
                        ),
                        SizedBox(width: 6,),
                        Consumer<TestProvider>(
                          builder: (context,value,child) {
                            return Container(
                                height: 50,
                                width: width/2.55,
                                decoration: BoxDecoration(
                                    color: bgBlue,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(width: 1.5,color: Colors.white.withOpacity(0.5))
                                ),
                                child: InkWell(
                                  child: Center(
                                    child: TextField(
                                      controller:value.timeController,
                                      cursorColor:clWhite,
                                      style: TextStyle(color:clWhite,fontSize:textSize16,fontWeight: FontWeight.w500,fontFamily: fontSemibold),
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.all(10),
                                        border: InputBorder.none,
                                        hintText: "Select Time",
                                        hintStyle: TextStyle(color: Colors.white.withOpacity(0.5),fontSize:textSize12,fontWeight: FontWeight.w400,fontFamily: fontRegular),
                                      ),
                              onTap: (){
                                value.selectTime(context);
                                      },
                                    ),
                                  ),


                                )

                            );
                          }
                        )
                      ],
                    ),
                    SizedBox(height:15,),
                    Consumer<TestProvider>(
                      builder: (context,value,child) {
                        return Container(
                            height: 65,
                            width: width,
                            decoration: BoxDecoration(
                                color: bgBlue,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(width: 1.5,color: Colors.white.withOpacity(0.5))
                            ),
                            child:TextField(
                              controller: value.gamenamecontroller,
                              cursorColor:clWhite,
                              style: TextStyle(color:clWhite,fontSize:textSize18,fontWeight: FontWeight.w500,fontFamily: fontMedium),
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(left: 5),
                                border: InputBorder.none,
                                hintText: "Enter Name",
                                hintStyle: TextStyle(fontWeight: FontWeight.w400,fontSize: textSize16,color:Colors.white.withOpacity(0.4),),
                                prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
                                focusedBorder:
                                OutlineInputBorder(borderRadius: BorderRadius.circular(22),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            )

                        );
                      }
                    ),

                    Consumer<TestProvider>(
                      builder: (context,value,child) {
                        return Row(crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Flexible(
                              child: RadioListTile<String>(contentPadding: EdgeInsets.zero,
                                fillColor:MaterialStatePropertyAll(clWhite),
                                title: Text('Active',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontFamily: 'AmikoRegular',
                                    fontWeight: FontWeight.normal,
                                    color: Colors.green.shade400,
                                  ),
                                ),
                                value: 'Active',
                                groupValue: value.SelectOption,
                                onChanged: (data) {
                                  value.setSelectedOption(data!);
                                },
                              ),
                            ),
                            Flexible(
                              child: RadioListTile<String>(
                                contentPadding: EdgeInsets.zero,
                                fillColor:MaterialStatePropertyAll(clWhite),
                                title: Text('Non-Active',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontFamily: 'AmikoRegular',
                                    fontWeight: FontWeight.normal,
                                    color: Colors.red,
                                  ),
                                ),
                                value: 'Non-Active',
                                groupValue:value.SelectOption,
                                onChanged: (data) {
                                  value.setSelectedOption(data!);
                                },
                              ),
                            ),
                          ],
                        );
                      }
                    )

                  ],
                ),
              ),
              SizedBox(height: 60,),

              Consumer<TestProvider>(
                builder: (context,value,child) {
                  return InkWell(
                      onTap: (){
                        if(from == "NEW"){
                          value.AddGames("NEW",'');
                        } else{
                          value.AddGames("EDIT",gid);
                        }

                        value.GetGames();
                       callNext(context, Home2());                      },
                      child: Center(
                        child: Container(
                          height: 45,
                          width: width/3,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white.withOpacity(0.8)
                          ),
                          child: Center(
                            child: Text("Save",style: TextStyle(color:bgBlue,fontSize:textSize18,fontWeight: FontWeight.w700,fontFamily: fontSemibold),
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
    );
  }
}

void showBottomSheet(BuildContext context) {
  TestProvider provider =
  Provider.of<TestProvider>(context, listen: false);

  showModalBottomSheet(
      elevation: 10,
      backgroundColor: clWhite,
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
                {provider.getImagecamera(), Navigator.pop(context)}),
            ListTile(
                leading: Icon(Icons.photo, color: Colors.black),
                title: const Text(
                  'Gallery',
                ),
                onTap: () =>
                {provider.getImagegallery(), Navigator.pop(context)}),
          ],
        );
      });
  //ImageSource
}