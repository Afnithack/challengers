


import 'dart:collection';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/Provider/My_Models.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart'as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../Constant/My_Function.dart';

class TestProvider with ChangeNotifier {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final DatabaseReference root = FirebaseDatabase.instance.ref();
  firebase_storage.Reference ref = FirebaseStorage.instance.ref("Images");

  TextEditingController gamenamecontroller = TextEditingController();

  String gamename = '';
  File? fileImage;
  String imageUrl = "";
  List<GameList> game_list = [];



  Future<void> AddGames(String from, String id) async {
    String game_id = DateTime.now().millisecondsSinceEpoch.toString();
    HashMap<String, Object>gamemap = HashMap();

    gamemap['NAME'] = gamenamecontroller.text.toString();
    gamemap['DATE'] = dateController.text;
    gamemap['TIME'] = timeController.text;
    gamemap['STATUS'] = SelectOption;

    if (fileImage != null) {
      String photoId = DateTime
          .now()
          .millisecondsSinceEpoch
          .toString();

      ref = FirebaseStorage.instance.ref().child(photoId);
      await ref.putFile(fileImage!).whenComplete(() async {
        await ref.getDownloadURL().then((value) {
          gamemap["PHOTO"] = value;

          notifyListeners();
        });
        notifyListeners();
      });
      notifyListeners();
    } else {
      gamemap['PHOTO'] = '';
      // editMap['IMAGE_URL'] = imageUrl;
    }

    if(from == "NEW"){
      db.collection("GAMES").doc(game_id).set(gamemap);
    }else{
      db.collection("GAMES").doc(id).update(gamemap);
    }
    GetGames();

    notifyListeners();
  }

  Future getImagegallery() async {
    final imagePicker = ImagePicker();
    final pickedImage =
    await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      // setImage(File(pickedImage.path));
      cropImage(pickedImage.path);
      // print("hjkl"+pickedImage.path);
    } else {
      print('No image selected.');
    }
  }

  Future getImagecamera() async {
    final imagePicker = ImagePicker();
    final pickedImage =
    await imagePicker.pickImage(source: ImageSource.camera);

    if (pickedImage != null) {
      // print("dfghjk"+pickedImage.path);
      cropImage(pickedImage.path);
      // setImage(File(pickedImage.path));

    } else {
      print('No image selected.');
    }
  }

  Future<void> cropImage(String path) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: path,
      aspectRatioPresets: Platform.isAndroid
          ? [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9,
      ]
          : [
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio5x3,
        CropAspectRatioPreset.ratio5x4,
        CropAspectRatioPreset.ratio7x5,
        CropAspectRatioPreset.ratio16x9,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.white,
            toolbarWidgetColor: Colors.black,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        )
      ],
    );
    if (croppedFile != null) {
      fileImage = File(croppedFile.path);
      notifyListeners();
    }
    GetGames();
    notifyListeners();
  }

  TimeOfDay _time = TimeOfDay.now();
  DateTime _date = DateTime.now();
  DateTime scheduledTime = DateTime.now();
  DateTime scheduledDate = DateTime.now();
  String scheduledDayNode = "";
  var outputDateFormat = DateFormat('dd/MM/yyyy');
  var outputTimeFormat = DateFormat('hh:mm a');

  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2023),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      _date = picked;
      scheduledDate = DateTime(_date.year, _date.month, _date.day);
      dateController.text = outputDateFormat.format(scheduledDate);
      notifyListeners();
    }
  }

  Future<void> selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _time,
    );

    if (picked != null) {
      _time = picked;
      scheduledDayNode =
          _date.year.toString() + '/' + _date.month.toString() + '/' +
              _date.day.toString();
      scheduledTime = DateTime(
          _date.year, _date.month, _date.day, _time.hour, _time.minute);
      timeController.text = outputTimeFormat.format(scheduledTime);
      notifyListeners();
    }
  }

  bool gameloader=false;
  void GetGames(){
    gameloader = true;
    db.collection("GAMES").get().then((e) {
      if (e.docs.isNotEmpty){
        game_list.clear();
        gameloader =false;
        for(var value in e.docs){
          game_list.add(
            GameList(
                value.id, value.get("NAME").toString(),
                value.get("PHOTO").toString(),
                value.get("DATE").toString(),
                value.get("TIME").toString(),
                value.get("STATUS").toString(),
            ));
          notifyListeners();
          print(game_list.length.toString());
        }

      }
      notifyListeners();
    });
  }

  void EditGames(String gid){
    db.collection("GAMES").doc(gid).get().then((e){
      if (e .exists){
        Map<dynamic,dynamic>gamemap = e.data() as Map;

        gamenamecontroller.text = gamemap["NAME"].toString();
        imageUrl = gamemap["PHOTO"].toString();
        dateController.text = gamemap["DATE"].toString();
        timeController.text = gamemap["TIME"].toString();
       SelectOption= gamemap["STATUS"].toString();
        notifyListeners();
      }
    });
  }

  void DeleteGame(gid,context){
    db.collection("GAMES").doc(gid).delete();
    ScaffoldMessenger.of(context).
    showSnackBar(SnackBar(
        content: Text("Deleted",style: TextStyle(color:Colors.white,fontSize:18,fontWeight: FontWeight.w500),),
    backgroundColor: Colors.white.withOpacity(0.5),
    ));
    GetGames();
    notifyListeners();
  }

  void clearfn() {
    gamenamecontroller.clear();
    dateController.clear();
    timeController.clear();
    fileImage = null;
    imageUrl = "";
    SelectOption ='';
  }


  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  File? userFile;
  String userImgUrl ='';
  List<CustList>custList =[];


  void AddCustomer(String from, String uId) async {
    String id = DateTime.now().microsecondsSinceEpoch.toString();
    HashMap<String, Object> customerMap = HashMap();
    HashMap<String, Object> userMap = HashMap();
    if(from=="NEW"){
      customerMap["ID"] = id;
    }
    customerMap["NAME"] = nameController.text;
    customerMap["PHONE_NUMBER"] = phoneController.text;
    customerMap["ADDRESS"] = addressController.text;


    if (userFile != null) {
      String photoId = DateTime.now().millisecondsSinceEpoch.toString();
      ref = FirebaseStorage.instance.ref().child(photoId);
      await ref.putFile(userFile!).whenComplete(() async {
        await ref.getDownloadURL().then((value) {
          customerMap["PHOTO"] = value;
          notifyListeners();
        });
        notifyListeners();
      });
    } else if(userImgUrl!=""){
      customerMap["PHOTO"] = userImgUrl;
    }
    else {
      customerMap['PHOTO'] = "";
    }

    userMap["NAME"] = nameController.text;
    userMap["PHONE_NUMBER"] = "+91${phoneController.text}";
    userMap["TYPE"] = "USER";
    if(from=="NEW"){
      db.collection("CUSTOMERS").doc(id).set(customerMap);
      db.collection("USERS").doc(id).set(userMap);
    }
    else{
      db.collection("CUSTOMERS").doc(uId).update(customerMap);
      db.collection("USERS").doc(uId).update(userMap);
    }
    notifyListeners();
  }

  Future getProfileImagegallery() async {
    final imagePicker = ImagePicker();
    final pickedImage =
    await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      // setImage(File(pickedImage.path));
      cropProfileImage(pickedImage.path);
      // print("hjkl"+pickedImage.path);
    } else {
      print('No image selected.');
    }
  }

  Future getProfileImagecamera() async {
    final imagePicker = ImagePicker();
    final pickedImage =
    await imagePicker.pickImage(source: ImageSource.camera);

    if (pickedImage != null) {
      // print("dfghjk"+pickedImage.path);
      cropProfileImage(pickedImage.path);
      // setImage(File(pickedImage.path));

    } else {
      print('No image selected.');
    }
  }

  Future<void> cropProfileImage(String path) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: path,
      aspectRatioPresets: Platform.isAndroid
          ? [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9,
      ]
          : [
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio5x3,
        CropAspectRatioPreset.ratio5x4,
        CropAspectRatioPreset.ratio7x5,
        CropAspectRatioPreset.ratio16x9,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.white,
            toolbarWidgetColor: Colors.black,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        )
      ],
    );
    if (croppedFile != null) {
      userFile = File(croppedFile.path);
      notifyListeners();
    }
    notifyListeners();
  }

  String userid ="";
  String username ="";
  String userphone ="";
  String userphoto ="";
  String useraddress ="";

  bool getcustloader = false;
  void GetCutomerdtls(){
    getcustloader = true;
    db.collection("CUSTOMERS").get().then((e) {
      custList.clear();
      getcustloader = false;
      if(e.docs.isNotEmpty){
        for(var value in e.docs){
          custList.add(
              CustList(
                  value.id,
                  value.get("NAME").toString(),
                  value.get("PHONE_NUMBER").toString(),
                  value.get("PHOTO").toString(),
                  value.get("ADDRESS").toString()
              ));
          notifyListeners();
        }
        notifyListeners();
      }
    });
  }


  void getEditCustomer(gcId) {
    db.collection("CUSTOMERS").doc(gcId).get().then((e) {
      if (e.exists) {
        Map<dynamic, dynamic> map = e.data() as Map;
        nameController.text = map["NAME"].toString();
        phoneController.text = map["PHONE_NUMBER"].toString();
        addressController.text = map["ADDRESS"].toString();
        userImgUrl = map["PHOTO"].toString();
        notifyListeners();
      }
    });
  }

    void DeleteCustomer(String dcid,BuildContext context){
      db.collection("CUSTOMERS").doc(dcid).delete();
      notifyListeners();
      ScaffoldMessenger.of(context).
      showSnackBar(SnackBar(
        content: Text("Deleted",style: TextStyle(color:Colors.white,fontSize:18,fontWeight: FontWeight.w500),),
        backgroundColor: Colors.white.withOpacity(0.5),
      ));
      notifyListeners();
    }
    
    List<ParticipantList>participantsList=[];

    void AddParticipants(context,String name,String phone,String photo,String gamename,String gameid,String userId){
      db.collection("PARTICIPANTS").where("GAME_ID", isEqualTo: gameid).where("USER_ID", isEqualTo: userId)
          .get()
          .then((value) {
        if (value.docs.isNotEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red,
              content: Text("Already registered",
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: 'Amikosemi',
                  color: Colors.white,
                ),),
            ),
          );
        }
      else {
          String id = DateTime
              .now()
              .microsecondsSinceEpoch
              .toString();
          HashMap<String, Object> map = HashMap();
          map["PARTICIPANT_ID"] = id;
          map["PARTICIPANT_NAME"] = name;
          map["GAME_NAME"] = gamename;
          map["GAME_ID"] = gameid;
          map["PHONE_NUMBER"] = phone;
          map["PHOTO"] = photo;
          map["USER_ID"] = userId;
          changeParticipantlist.add(gameid);

          db.collection("PARTICIPANTS").doc(id).set(map);
          GetParticipants(gamename, gameid);
          notifyListeners();
        }
        });

          }

  bool participantloader=false;
  void GetParticipants(String gamename,String gameid){
    participantloader=true;
      db.collection("PARTICIPANTS")
          .where("GAME_ID", isEqualTo:gameid).get().then((e){
        participantsList.clear();
        participantloader = false;
        if(e.docs.isNotEmpty){
          for(var value in e.docs){
            participantsList.add(ParticipantList(
                value.get("GAME_ID"),
                value.get("PARTICIPANT_NAME"),
                value.get("PHONE_NUMBER"),
                value.get("PHOTO"),
                value.get("GAME_NAME"),
                value.get("GAME_ID")
            ));
          }
          notifyListeners();
        }
        notifyListeners();
      });

      }

  String SelectOption = '';

  String get Selectedoption => SelectOption;

  void setSelectedOption(String option) {
    SelectOption = option;
    notifyListeners();
  }

  List<String> changeParticipantlist=[];
  void changeBookingsts(String number) {
    print(number);
    print(number);
    notifyListeners();
    db
        .collection("PARTICIPANTS")
        .where("PHONE_NUMBER", isEqualTo:  number)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        for (var value in value.docs) {
          changeParticipantlist.add(value.get("GAME_ID"));
        }
        print(changeParticipantlist.length);
        print("sejdnsikedni");
        notifyListeners();
      }
    });}

  Future<bool> CheckExistingNumber(String number) async {
    var val=await db
        .collection("USERS")
        .where("PHONE_NUMBER", isEqualTo: "+91" + number)
        .get();
    if(val.docs.isNotEmpty){
      return true;
    }else{
      return false;
    }

  }



    }












