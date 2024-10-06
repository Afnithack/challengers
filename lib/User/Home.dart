import 'package:demo/Constant/My_Function.dart';
import 'package:demo/Provider/Main_Provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Constant/My_colors.dart';
import '../Login.dart';


class Home extends StatelessWidget {
  String username;
  String userphone;
  String userphoto;
  String userId;
  Home({super.key,required this.username,required this.userphone,
    required this.userphoto,required this.userId
  });

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff172D3B),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          title: Text("Home",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 23,color:Color(0xff172D3B), ),),
          centerTitle: true,
          actions: [
            Row(
              children: [
                InkWell(
                    onTap: (){
                      FirebaseAuth auth = FirebaseAuth.instance;
                      auth.signOut();
                      callNextReplacement(context, LoginScreen());
                    },
                    child: Container(
                      height: 37,
                      width: 80,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color:Color(0xff172D3B),
                      ),
                      child: Row(mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Logout",style: TextStyle(color:Colors.white,fontSize:15,fontWeight: FontWeight.w500),
                          ),
                          SizedBox(width: 5,),
                          Icon(Icons.logout,size: 15,color:Colors.white,),
                        ],
                      ),
                    )
                ),
                SizedBox(width: 5,)
              ],
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 20),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Choose From Below",style: TextStyle(
                  fontSize: 20,fontWeight: FontWeight.w500,color: Colors.white
                ),),
               SizedBox(height: 10,),
               Consumer<TestProvider>(
                 builder: (context,value,child) {
                   return value.gameloader?CircularProgressIndicator(color: clWhite,): value.game_list.isNotEmpty?
                     ListView.separated(
                     separatorBuilder: (context,int index){
                       return SizedBox(height: 15,);
                     },
                     itemCount: value.game_list.length,
                       physics: ScrollPhysics(),
                       shrinkWrap: true,
                       itemBuilder: (context,int index){
                       var item = value.game_list[index];
                        return item.status=="Active"? Column(crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Container(
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
                                  color: Color(0xff172D3B).withOpacity(0.5),
                                  child: Row(
                                    children: [
                                      Column(crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(item.name,style: TextStyle(
                                              color: Colors.white,fontWeight: FontWeight.w500,fontSize: 18
                                          ),),
                                          Row(
                                            children: [
                                              SizedBox(width: 3,),
                                              Text("Date:",style: TextStyle(
                                                  color: Colors.white,fontWeight: FontWeight.w500,fontSize: 14
                                              ),),
                                              SizedBox(width: 3,),
                                              Text(item.date,style: TextStyle(
                                                  color: Colors.white,fontWeight: FontWeight.w500,fontSize: 14
                                              ),),
                                              SizedBox(width: 10,),
                                              Text("Time:",style: TextStyle(
                                                  color: Colors.white,fontWeight: FontWeight.w500,fontSize: 14
                                              ),),
                                              SizedBox(width: 3,),
                                              Text(item.time,style: TextStyle(
                                                  color: Colors.white,fontWeight: FontWeight.w500,fontSize: 14
                                              ),),

                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(width: 10,),
                                      Padding(
                                        padding: const EdgeInsets.only(top:12),
                                        child: Consumer<TestProvider>(
                                          builder: (context,value,child) {
                                            return InkWell(
                                              onTap: (){
                                                if(value.changeParticipantlist.contains(item.id))
                                                  {
                                                    ScaffoldMessenger.of(context).showSnackBar(
                                                      SnackBar(
                                                        backgroundColor: Colors.red,
                                                        content: Text("Already Booked",
                                                          style: TextStyle(
                                                            fontSize: 15,
                                                            fontFamily: 'Amikosemi',
                                                            color: Colors.white,
                                                          ),),
                                                      ),
                                                    );
                                                  }
                                                else{
                                                  value.AddParticipants(context, username, userphone, userphoto, item.name, item.id,userId);
                                                }
                                              },
                                              child: Container(
                                                  height: 35,
                                                  width: 80,
                                                  decoration: BoxDecoration(
                                                      color: Color(0xff172D3B),
                                                      borderRadius: BorderRadius.circular(10),
                                                      border: Border.all(width: 1,color: Colors.white)

                                                  ),
                                                  child: Center(child: Text(value.changeParticipantlist.contains(item.id)?"Booked":"Book Now",style: TextStyle(
                                                      color: Colors.white,fontWeight: FontWeight.w400,fontSize: 15
                                                  ),))),
                                            );
                                          }
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                          ],
                        ):SizedBox();
                       }):SizedBox();
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
