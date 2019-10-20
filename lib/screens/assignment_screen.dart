


import 'package:flutter/material.dart';
import "package:teacher_app/api_manager/api_manager.dart";
import 'package:cloud_firestore/cloud_firestore.dart';


class AssignmentScreen extends StatefulWidget {
  final String studentName;
  final String studentDeviceId;
  final String assignmentUrl;
  final String  assignmentName;
  final String teacherDeviceId;

  AssignmentScreen({this.assignmentUrl,this.studentName,this.studentDeviceId,this.assignmentName,this.teacherDeviceId});

  @override
  AssignmentScreenState createState() => AssignmentScreenState();
}
  class AssignmentScreenState extends State<AssignmentScreen>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Column(
        children: <Widget>[
          Text(widget.studentName),
          Text(widget.assignmentName),
          assignmentWidget(widget.assignmentName,widget.assignmentUrl),
          Row(children: <Widget>[
            statusButton("BAD"),
            statusButton("GOOD"),
            statusButton("EXLENT"),
          ],)
        ],
      ),
    );
  }
Widget assignmentWidget(String assignmentName,String studentUrl) {
  return Card(child: Column(
    children: <Widget>[
      Text(assignmentName),
      RaisedButton(onPressed: () {}, child: Text("download"))
    ],
  ),);
}

String result;

Widget statusButton(String resultStatus){

    return RaisedButton(
      onPressed: (){
        setState(() {
          result=resultStatus;
        });
      },
    );
}

uploadStatusForCloud(){
  Firestore.instance.collection('assignmentstatus').document()
      .setData({ 'assignment_name':widget.assignmentName,"assignment_status":result,
    "assignment_url":widget.assignmentUrl,"student_deviceId":widget.studentDeviceId,
    "teacher_devicceId":widget.teacherDeviceId});
}


  sendNotificationToTeacher()
  {
    ApiManager().sendNotification(studentName:"Hi you got status for assignment",teacherDeviceId:widget.studentDeviceId);

  }

  Widget sendButton(){
    return  RaisedButton(onPressed: (){
      uploadStatusForCloud();
      sendNotificationToTeacher();
    }, child:Text("Send Status"));

  }
}