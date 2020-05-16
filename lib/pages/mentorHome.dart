import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class mentorHome extends StatefulWidget{
  @override
  _mentorHomeState createState() => _mentorHomeState();
   
  }
  
class _mentorHomeState extends State<mentorHome>{
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
            elevation: 0,
            brightness: Brightness.light, // this makes status bar text color black
            backgroundColor: Colors.transparent,
            title: Text('Our Mentors',style: new TextStyle(fontSize: 20.0, color: Colors.black)),
      ),
      body: StreamBuilder(
        stream: Firestore.instance.collection('Mentors-description').snapshots(),
        builder: (context, snapshot){
          if (!snapshot.hasData) return Text('Loading data .. please wait');
          return ListView(
            children: <Widget>[
              Text(snapshot.data.documents[0]['name']),
              
              
            ],


          );
        },


      )

    );
   
  }







}