

import 'package:flutter/material.dart';
import 'package:teacher_app/widget/studdent assignment widget.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart';
import 'package:teacher_app/api_manager/api_manager.dart';




class HomeScreen extends StatefulWidget{

  final String name;
  HomeScreen({@required this.name});


  @override
  HomeScreenState createState() =>HomeScreenState();
}

class HomeScreenState extends State<HomeScreen>{

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    studentAssignmentWidgets=listofUploadeddocuments();

    //  Future.delayed(Duration(seconds: 2)).then((d){
    //listofUploadeddocuments();
    // });
  }
  List<StudentAssignmentWidget> studentAssignmentWidgets=[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Home Screen"),),
        body: ListView(children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Hi " + widget.name, style: TextStyle(fontSize: 25.0,
                color: Colors.purpleAccent,
                fontWeight: FontWeight.bold),),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Student Assignment List", style: TextStyle(
                    fontSize: 20.0, fontWeight: FontWeight.bold),),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Divider(color: Colors.purpleAccent,),
          ),

          Column(children: studentAssignmentWidgets
          )
        ],)

    );
  }


  List<StudentAssignmentWidget> listofUploadeddocuments(){
      List<StudentAssignmentWidget> listAssignmentUrl=[];
      Firestore.instance
          .collection('assignmentDownloadLinks').getDocuments().then((querySnapshot){
            querySnapshot.documents.forEach((element){
           //  print(element.data["student_name"]);
              listAssignmentUrl.add(StudentAssignmentWidget(studentName:element.data["student_name"],
                  assignmentUrl:element.data["assignmentDownloadUrl"],
              teacherDeviceId: element.data["teacher_deviceId"],studentDeviceId: element.data["student_deviceId"],
              assignmentName: element.data["assignment_name"],));
            });
      });
//          .snapshots()
//          .listen((data) =>
//          data.documents.forEach((doc) =>
//
//              listAssignmentUrl.add(StudentAssignmentWidget(studentName:doc["student_name"],
//                  assignmentUrl:doc["assignmentDownloadUrl"]))
//
//          ));
      print("im printkkk");
      print(listAssignmentUrl.length);
      return listAssignmentUrl;
    }
  }



