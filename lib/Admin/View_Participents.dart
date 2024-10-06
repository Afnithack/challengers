import 'package:demo/Constant/My_colors.dart';
import 'package:demo/Provider/Main_Provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Home.dart';


class ViewParticipents extends StatelessWidget {
  const ViewParticipents({Key? key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xff172D3B),
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Home2()),
            );
          },
          child: Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 21),
        ),
        backgroundColor: Color(0xff172D3B),
        title: Text(
          "Participants",
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 21, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Consumer<TestProvider>(
          builder: (context, value, child) {
            return value.participantloader?CircularProgressIndicator(color: clWhite,):
              value.participantsList.isNotEmpty
                ? SizedBox(
                  child: ListView.separated(
                                separatorBuilder: (context, index) {
                  return SizedBox(height: 10);
                                },
                                itemCount: value.participantsList.length,
                                shrinkWrap: true,
                                physics: ScrollPhysics(),
                                itemBuilder: (context, int index) {
                  var item = value.participantsList[index];
                  return Container(
                    width: width,
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
                          Padding(
                            padding: const EdgeInsets.only(top:12),
                            child: Container(
                              height: 50,
                              width: 50,
                              child: Image.network(item.photo, fit: BoxFit.fill),
                            ),
                          ),
                          SizedBox(width: 5),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Name :",
                                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.white),
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        item.name,
                                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: Colors.white),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Phone Number :",
                                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: Colors.white),
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        item.phone,
                                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: Colors.white),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Game Name :",
                                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: Colors.white),
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        item.gamename,
                                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                                },
                              ),
                )
                : Center(
              child: Text(
                "Participant List Is Empty",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 21, color: Colors.white),
              ),
            );
          },
        ),
      ),
    );
  }
}

