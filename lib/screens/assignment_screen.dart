


import 'package:flutter/cupertino.dart';
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
    return Scaffold(
      appBar: AppBar(title: Text("Status Screen"),backgroundColor: Colors.purpleAccent,),
      body: Column(
mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(widget.studentName),
        //  Text(widget.assignmentName),
        //  assignmentWidget(ass:widget.assignmentName,widget.assignmentUrl),
          Row(children: <Widget>[
            statusButton("BAD"),
            statusButton("GOOD"),
            statusButton("EXELENT"),
          ],),
          sendButton()
        ],
      ),
    );
  }
Widget assignmentWidget({String assignmentName=" ",String studentUrl}) {
  return Card(child: Column(
    children: <Widget>[
      Text(assignmentName),
      RaisedButton(onPressed: () {}, child: Text("download"))
    ],
  ),);
}

String result;

Widget statusButton(String resultStatus){

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: RaisedButton(
        child:Text(resultStatus),
        color:Colors.green,
        onPressed: (){
          setState(() {
            result=resultStatus;
          });
        },
      ),
    );
}

uploadStatusForCloud(){
  Firestore.instance.collection('assignmentstatus').document()
      .setData({"assignment_status":result,
    "assignment_url":widget.assignmentUrl,"student_deviceId":widget.studentDeviceId,
    "teacher_devicceId":widget.teacherDeviceId});
}


  sendNotificationToTeacher()
  {
    ApiManager().sendNotification(studentName:"Hi you got status for assignment",studentDeviceId:widget.studentDeviceId);

  }

  Widget sendButton(){
    return  RaisedButton(onPressed: (){
      uploadStatusForCloud();
      sendNotificationToTeacher();
    }, child:Text("Send Status"));

  }
}