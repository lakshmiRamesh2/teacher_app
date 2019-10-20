



import 'package:flutter/material.dart';
import "package:http/http.dart"as http;
import 'dart:io';
import "package:teacher_app/screens/assignment_screen.dart";



class StudentAssignmentWidget extends StatefulWidget{

  final String studentName;
  final String assignmentUrl;
  final String studentDeviceId;
  final String  assignmentName;
  final String teacherDeviceId;

  StudentAssignmentWidget({this.assignmentUrl,this.studentName,this.studentDeviceId,this.assignmentName,this.teacherDeviceId});




  StudentAssignmentWidgetState createState()=>StudentAssignmentWidgetState();
}

class StudentAssignmentWidgetState extends State<StudentAssignmentWidget>{
  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap:(){
        Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AssignmentScreen(),
                      ),
                    );
      } ,
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            child:Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(widget.studentName,style: TextStyle(fontSize: 14.0,color: Colors.redAccent)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RaisedButton(onPressed: (){
                      // _showDownloadurl();
                      downloadUrl(widget.assignmentUrl);
                    },child:Row(
                      children: <Widget>[
                        Icon(Icons.file_download,color: Colors.blue,),
                        Text(" Download",style: TextStyle(fontSize: 14.0,color: Colors.blue),),
                      ],
                    ),),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showDownloadurl() {
    print("dialog box called");
    AlertDialog dialog = AlertDialog(
      content: Column(
        children: <Widget>[
          Text("please tap on the link"+widget.assignmentUrl),

        ],
      ),
      actions: <Widget>[

      ],
    );
    showDialog(
      context: context,
      builder: (context) => dialog,
      // child: dialog,
    );
  }

  downloadUrl(String url)async{
    final http.Response downlodedData=await http.get(url);
    final Directory systemTempDir= Directory.systemTemp;
    // downlodedData.bodyBytes
    print(widget.assignmentUrl);
  }
}