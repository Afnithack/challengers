import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/Admin/Main_Page.dart';
import 'package:demo/Provider/Main_Provider.dart';
import 'package:demo/User/Home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Constant/My_Function.dart';
import '../Otp.dart';


class LoginProvider extends ChangeNotifier {

  FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore db = FirebaseFirestore.instance;

  String VerificationId = '';
  TextEditingController phoneController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  bool loader = false;


  void sendOtp(BuildContext context) async {
    loader = true;
    notifyListeners();
    await auth.verifyPhoneNumber(
      phoneNumber: "+91${phoneController.text}",
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Color(0xff172D3B),
          content: Text(
              "Verification Completed",
              style: TextStyle(color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w800,)),
          duration:
          Duration(milliseconds: 3000),
        ));
        if (kDebugMode) {}
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == "invalid-phone-number") {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(
            content:
            Text("Sorry, Verification Failed"),
            duration: Duration(milliseconds: 3000),
          ));
          if (kDebugMode) {

          }
        }
      },

      codeSent: (String verificationId, int? resendToken) {
        VerificationId = verificationId;
        loader = false;
        notifyListeners();
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => Otp(),
            ));
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Color(0xff172D3B),
          content: Text(
              "OTP sent to phone successfully", style: TextStyle(
            color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600,)),
          duration:
          Duration(milliseconds: 3000),
        ));
        phoneController.clear();
        // print
        log("Verification Id : $verificationId");
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
      timeout: const Duration(seconds: 60),
    );
  }


  void verify(BuildContext context) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: VerificationId, smsCode: otpController.text);
    print(credential.toString() + "sjjss");
    await auth.signInWithCredential(credential).then((value) {
      final user = value.user;
      if (value.user != null) {
        userAuthorized(user?.phoneNumber, context);
      } else {
        if (kDebugMode) {}
      }
    });
  }


  Future<void> userAuthorized(String? phoneNumber, BuildContext context) async {
    String loginUsername = '';
    String loginUsertype = '';
    String userId = '';
    String loginPhone = "";
    String loginUserId = "";
    String loginPhoto = "";
    String address = "";
    TestProvider mainProvider = Provider.of<TestProvider>(
        context, listen: false);
    try {
      var phone = phoneNumber!;
      print(phoneNumber.toString() + "duudud");
      db.collection("USERS").where("PHONE_NUMBER", isEqualTo: phone)
          .get()
          .then((value) {
        if (value.docs.isNotEmpty) {
          print("fiifuif");
          for (var element in value.docs) {
            Map<dynamic, dynamic> map = element.data();
            loginUsername = map['NAME'].toString();
            loginUsertype = map['TYPE'].toString();
            loginPhone = map["PHONE_NUMBER"].toString();
            loginUserId = element.id;
            notifyListeners();
            print(loginUsertype);
            if (loginUsertype == "ADMIN") {
              print("cb bcb");
              callNextReplacement(context, MainPage());
            }
            else {
              print("mxnxn");

              db.collection("CUSTOMERS").doc(loginUserId).get().then((value) {
                if (value.exists) {
                  address = value.get("ADDRESS").toString();
                  loginPhoto = value.get("PHOTO").toString();
                  mainProvider.GetGames();
                  mainProvider.changeBookingsts(loginPhone);
                  notifyListeners();
                  callNextReplacement(context, Home(username: loginUsername,
                    userphone: loginPhone,
                    userphoto: loginPhoto,
                    userId: loginUserId,),);
                }
              });
              print("dkdkdd");
            }
          }
        }
        else {
          const snackBar = SnackBar(
              backgroundColor: Colors.white,
              duration: Duration(milliseconds: 3000),
              content: Text("Sorry , You don't have any access",
                textAlign: TextAlign.center,
                softWrap: true,
                style: TextStyle(
                    fontSize: 18,
                    color: Color(0xff172D3B),
                    fontWeight: FontWeight.bold),
              ));

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      });
    } catch (e) {
      const snackBar = SnackBar(
          backgroundColor: Colors.white,
          duration: Duration(milliseconds: 3000),
          content: Text("Sorry , Some Error Occurred",
            textAlign: TextAlign.center,
            softWrap: true,
            style: TextStyle(
                fontSize: 18,
                color: Color(0xff172D3B),
                fontWeight: FontWeight.bold),
          ));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  void clearOtp() {
    otpController.clear();
    phoneController.clear();
  }
}
