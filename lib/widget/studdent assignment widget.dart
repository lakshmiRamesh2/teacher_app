



import 'package:flutter/material.dart';
import "package:http/http.dart"as http;
import 'dart:io';
import "package:teacher_app/screens/assignment_screen.dart";
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';



class StudentAssignmentWidget extends StatefulWidget{

  final String studentName;
  final String assignmentUrl;
  final String studentDeviceId;
  final String  assignmentName;
  final String teacherDeviceId;
  StudentAssignmentWidget({this.assignmentUrl,this.studentName,this.studentDeviceId,
    this.assignmentName,this.teacherDeviceId});
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
                        builder: (context) => AssignmentScreen(
                          studentName: widget.studentName,
                          studentDeviceId: widget.studentDeviceId,
                          assignmentName: widget.assignmentName,
                          assignmentUrl: widget.assignmentUrl,
                          teacherDeviceId: "eGKhVGqD5-Q:APA91bHFSjGi58VC_CkTwnOKXn1ovnEMbCtygdhptN73LHAXN6FSBCr1Wo6l3IUtlh7XE6yEdN3xHNn2y1Zk3gzNoik_vRFDQBDkKWTzE778rUXRR1LZ9rVNQ0tebdJNAShlPuAbj3Fj",
                        ),
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

                      _launchURL(widget.assignmentUrl);
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


  _launchURL( String url ) async {
   // const url = 'https://flutter.dev';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
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

//  downloadUrl(String url)async{
//    final http.Response downlodedData=await http.get(url);
//    final Directory systemTempDir= Directory.systemTemp;
//    // downlodedData.bodyBytes
//    print(widget.assignmentUrl);
//  }

//
//  Future<void> downloadFile(String url) async {
//
//    final http.Response downloadData = await http.get(url);
//    final Directory systemTempDir = Directory.systemTemp;
//    final File tempFile = File('${systemTempDir.path}/tmp.jpg');
//    if (tempFile.existsSync()) {
//      await tempFile.delete();
//    }
//    await tempFile.create();
//
//    final StorageFileDownloadTask task = ref.writeToFile(tempFile);
//    final int byteCount = (await task.future).totalByteCount;
//    var bodyBytes = downloadData.bodyBytes;
//    final String name = await ref.getName();
//    final String path = await ref.getPath();
//    print(
//      'Success!\nDownloaded $name \nUrl: $url'
//          '\npath: $path \nBytes Count :: $byteCount',
//    );
//  }

}