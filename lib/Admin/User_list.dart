import 'package:demo/Constant/My_Function.dart';
import 'package:demo/Constant/My_colors.dart';
import 'package:demo/Registration.dart';
import 'package:demo/Provider/Main_Provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Main_Page.dart';

class UserList extends StatelessWidget {

  UserList({super.key,});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xff172D3B),
      appBar: AppBar(
        backgroundColor:Color(0xff172D3B),
        leading: InkWell(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>MainPage()));
          },
            child: Icon(Icons.arrow_back_ios_new,color: Colors.white,size:23,)),
        title: Text("User List",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 23,color:Colors.white),),
        centerTitle: true,
      ),
      body:Padding(
        padding: const EdgeInsets.all(20),
        child: Consumer<TestProvider>(
          builder: (context, value, child) {
            return value.getcustloader?CircularProgressIndicator(color: clWhite,):
              value.custList.isNotEmpty
                ? SizedBox(
              child: ListView.separated(
                separatorBuilder: (context, index) {
                  return SizedBox(height: 10);
                },
                itemCount: value.custList.length,
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemBuilder: (context, int index) {
                  var items = value.custList[index];
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.white, width: 0.5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 60,
                            width: 60,
                            child: Image.network(
                              items.photo,
                              fit: BoxFit.fill,
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Name :",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      items.name,
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Phone Number :",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      items.phone,
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Address :",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    Expanded(
                                      child: Text(
                                        items.address,
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20),
                                Row(
                                  children: [
                                    Consumer<TestProvider>(
                                      builder: (context,value,child) {
                                        return InkWell(
                                          onTap: () {
                                            value.getEditCustomer(items.id);
                                            callNext(context, Registration(from: "EDIT", loginusrid: items.id));
                                          },
                                          child: Container(
                                            height: 35,
                                            width: 60,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(10)
                                            ),
                                              child: Center(child: Text("Edit",style: TextStyle(color:Color(0xff172D3B),fontSize: 16,fontWeight: FontWeight.w700 ),))
                                          ),
                                        );
                                      }
                                    ),
                                    SizedBox(width: 10),
                                    InkWell(
                                      onTap: () {
                                        value.DeleteCustomer(items.id, context);
                                      },
                                      child: Container(
                                          height: 35,
                                          width: 70,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(10)
                                          ),
                                          child: Center(child: Text("Delete",style: TextStyle(color:Color(0xff172D3B),fontSize: 16,fontWeight: FontWeight.w700 ),))
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
                : Center(
              child: Text(
                "Your List Is Empty",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          },
        ),
      )

    );
  }
}
