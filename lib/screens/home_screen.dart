

import 'package:flutter/material.dart';
import 'package:teacher_app/widget/studdent assignment widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:teacher_app/api_manager/api_manager.dart';




class HomeScreen extends StatefulWidget{

  final String name;
  HomeScreen({@required this.name});


  @override
  HomeScreenState createState() =>HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {

    super.initState();
    listOfUploadedDocuments();

  }

  List<StudentAssignmentWidget> studentAssignmentWidgets = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Home Screen"),backgroundColor: Colors.purpleAccent),
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
                RaisedButton(onPressed: (){sendNotificationToTeacher();},child: Text("bbb"),),
          Column(children: studentAssignmentWidgets)
        ],)

    );
  }


  sendNotificationToTeacher()
  {
    ApiManager().sendNotification(studentName:"Hi you got status for assignment",teacherDeviceId:"f7tLPkeuPLA:APA91bG6z9W7bzBQSH_60X7G63hS2N11_PNUBmMkCy1X0SZ1dWePEVnDonbdCUw0_VD5UCgDIO2kdohmWATFqgrrRcAwziRfXHR6HdVvYJS12KMhdjRP41JcmJtJIdfZ2Dn2RbhEp4wW");

  }
  String student1 ="student1@123";
  String student2="student2@123";

  Future<List<StudentAssignmentWidget>> listOfUploadedDocuments()async{
    List<StudentAssignmentWidget> listAssignmentUrl=[];
    Firestore.instance
        .collection('assignmentDownloadLinks')
        .where("toview" ,isEqualTo:true)
        .snapshots()
        .listen((data) =>
        data.documents.forEach((doc) =>
            listAssignmentUrl.add(StudentAssignmentWidget(studentName:doc["student_name"],
                assignmentUrl:doc["assignmentDownloadUrl"],
              studentDeviceId:doc["student_deviceId"],
              teacherDeviceId: doc["teacher_deviceId"],
            ))
        ));
    print("im printing llll");
    setState(() {
      studentAssignmentWidgets=listAssignmentUrl;
    });

    print(listAssignmentUrl.length);
    return listAssignmentUrl;
  }
}

