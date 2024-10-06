import 'package:demo/Admin/Main_Page.dart';
import 'package:demo/Constant/My_Texts.dart';
import 'package:demo/Constant/My_colors.dart';
import 'package:demo/Provider/Main_Provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Constant/My_Function.dart';
import 'Add_Matches.dart';
import 'View_Participents.dart';

class Home2 extends StatelessWidget {
  const Home2({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    TestProvider provider = Provider.of<TestProvider>(context,listen: false);
    provider.GetGames();

    return SafeArea(
      child: Scaffold(
        floatingActionButton: Consumer<TestProvider>(
          builder: (context,value,child) {
            return FloatingActionButton(
              backgroundColor: Colors.white,
              shape: CircleBorder(),
              child: Icon(Icons.add,color:bgBlue,size: 27,),
              onPressed: (){
                value.clearfn();
                callNext(context,  AddMatches(from: "NEW",gid: '',));

              },
            );
          }
        ),
        backgroundColor:bgBlue,
        appBar: AppBar(

          leading: InkWell(
              onTap: (){
                callNext(context, MainPage());
              },
              child: Icon(Icons.arrow_back_ios_new,color: clWhite,size:23,)),
          backgroundColor: Color(0xff172D3B),
          title: Text("Home",style: TextStyle(fontWeight: FontWeight.w500,fontSize: textSize23,color:clWhite,fontFamily: fontMedium ),),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 20),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Choose From Below",style: TextStyle(
                    fontSize: textSize20,fontWeight: FontWeight.w500,color: clWhite,fontFamily: fontSemibold
                ),),
                SizedBox(height: 10,),
                Consumer<TestProvider>(
                  builder: (context,value,child) {
                    return SizedBox(
                      child:value.gameloader?CircularProgressIndicator(color: clWhite,):value.game_list.isNotEmpty? ListView.separated(
                          separatorBuilder: (context,int index){
                            return SizedBox(height: 15,);
                          },
                          itemCount: value.game_list.length,
                          physics: ScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context,int index){
                            var item = value.game_list[index];
                            return Column(crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Status :${item.status}",style: TextStyle(
                                    fontSize: textSize16,
                                    color: clWhite
                                ),),
                                SizedBox(
                                  height: 15.0,
                                ),

                                InkWell(
                                  onLongPress: (){
                                    showDialog(
                                      context: context,
                                      builder: (ctx) => AlertDialog(
                                        backgroundColor: bgBlue,

                                        content:Text("Are you sure want to edit or delete?",
                                          style: TextStyle(
                                              fontSize: textSize15,
                                              color: clWhite
                                          ),),
                                        actions: [
                                          Row(
                                            children: [
                                              Consumer<TestProvider>(
                                                  builder: (context,value,child) {
                                                    return TextButton(
                                                        onPressed: () {
                                                          value.EditGames(value.game_list[index].id );
                                                          print(value.game_list[index].id+"kjjjj");
                                                          callNext(context, AddMatches(from: "EDIT",gid :value.game_list[index].id ,));

                                                        },
                                                        child: Text("EDIT",
                                                          style: TextStyle(fontSize: 15,color:clWhite
                                                          ),));
                                                  }
                                              ),

                                              Consumer<TestProvider>(
                                                  builder: (context,value,child) {
                                                    return TextButton(
                                                      onPressed: () {
                                                        provider.DeleteGame(value.game_list[index].id,context);
                                                        finish(context);

                                                      },

                                                      child: Text("DELETE",
                                                        style: TextStyle(fontSize: 15,color:clWhite
                                                        ),),
                                                    );
                                                  }
                                              ),

                                            ],
                                          ),
                                        ],



                                      ),
                                    );
                                  },
                                  onTap: (){
                                    value.GetParticipants(value.gamename,item.id);
                                    callNext(context, ViewParticipents());
                                  },
                                  child: Container(
                                    height: height/5.4,
                                    width: width,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(image: NetworkImage(item.photo),fit: BoxFit.fill),
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    child:  Align(alignment: Alignment.bottomRight,
                                      child: Container(
                                        height: 50,
                                        width: width,
                                        color: bgBlue.withOpacity(0.5),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 10),
                                          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(item.name,style: TextStyle(
                                                  color: clWhite,fontWeight: FontWeight.w500,fontSize: 18
                                              ),),
                                              Row(mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  SizedBox(width: 3,),
                                                  Text("Date:",style: TextStyle(
                                                      color: clWhite,fontWeight: FontWeight.w500,fontSize: 14,fontFamily: fontMedium
                                                  ),),
                                                  SizedBox(width: 3,),
                                                  Text(item.date,style: TextStyle(
                                                      color: clWhite,fontWeight: FontWeight.w500,fontSize: 14,fontFamily: fontMedium
                                                  ),),
                                                  SizedBox(width: 10,),
                                                  Text("Time:",style: TextStyle(
                                                      color: clWhite,fontWeight: FontWeight.w500,fontSize: 14,fontFamily: fontMedium
                                                  ),),
                                                  SizedBox(width: 3,),
                                                  Text(item.time,style: TextStyle(
                                                      color: clWhite,fontWeight: FontWeight.w500,fontSize: 14,fontFamily: fontMedium
                                                  ),),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                              ],
                            );
                          }):SizedBox(
                      child: Text("List is empty...",style: TextStyle(
                        color: clWhite,fontWeight: FontWeight.w500,fontSize: 14,fontFamily: fontMedium
                    ),),
                                        )
                    );
                  }
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
