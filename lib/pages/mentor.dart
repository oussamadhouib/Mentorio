
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentorio/pages/home_page.dart';
import 'package:mentorio/pages/mentorHome.dart';

class Mentor extends StatefulWidget{
  @override
  _MentorState createState() => _MentorState();
}

class _MentorState extends State<Mentor> {

  final FirebaseMessaging _fcm = FirebaseMessaging();

  void initState()
  {
    super.initState();

    updatePost("YjjDuXgxQAfHTgoNhYZ4");

    _fcm.getToken().then((token){
      Firestore.instance.collection('tokens').add({
        'token':token
      });
    });

  }

  final _formkey = GlobalKey<FormState>();

  TextEditingController _name = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _phonenumber = TextEditingController();
  TextEditingController _feild = TextEditingController();
  TextEditingController _problem = TextEditingController();

  @override
  void dispose()
  {
    _name.dispose();

    _email.dispose();

    _phonenumber.dispose();

    _feild.dispose();

    _problem.dispose();

    super.dispose();
  }

  updatePost(String ID){
    Firestore.instance.collection('Posts_mentor').document(ID).setData({

      'name':"name Edited",
      'email':"email Edited"



    }).then((value){
      print('record updated successflly');
    });
  }

showAlertDialog(BuildContext context) {

  // set up the button
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
       );
     },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Success"),
    content: Text("Thanks for your submission,you will be answered soon."),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}


//loading function
 void _onLoading() {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
        child: new Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            new CircularProgressIndicator(),
            new Text("Loading"),
          ],
        ),
      );
    },
  );
  new Future.delayed(new Duration(seconds: 4), () {
    Navigator.pop(context); //pop dialog
    showAlertDialog(context);
  });
}

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'Me',
          style: GoogleFonts.portLligatSans(
            textStyle: Theme.of(context).textTheme.display1,
            fontSize: 40,
            fontWeight: FontWeight.w700,
            color: Colors.red,
          ),
          children: [
            TextSpan(
              text: 'nto',
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),
            TextSpan(
              text: 'rio',
              style: TextStyle(color: Colors.red, fontSize: 40),
            ),
          ]),
    );
  }
  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light, // this makes status bar text color black
        backgroundColor: Colors.transparent,
        title: Text('Mentor Space',style: new TextStyle(fontSize: 20.0, color: Colors.black)),

        actions: <Widget>[
           IconButton(
              icon: Icon(
                Icons.notification_important,
                color: Colors.black,
              ),
              onPressed: () {
                // do something
              },
            ),
            IconButton(
              icon: Icon(
                Icons.home,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => mentorHome()),
              );
                // do something
              },
            ),
             IconButton(
              icon: Icon(
                Icons.account_circle
               // color: Colors.black,
              ),
              onPressed: () {
                // do something
              },
            )

        ],
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formkey,
          child:SingleChildScrollView(
              child:Container(
                height: MediaQuery.of(context).size.height,
                child:Stack(

                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          
                          _title(),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: _name,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              fillColor: Color(0xfff3f3f4),
                              filled: true,
                              hintText: 'Enter your name',

                            ),
                            validator: (value){
                              if(value.isEmpty){
                                return 'Please Fill Post Title Input';
                              }
                              // return 'Valid Name';
                            },
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          TextFormField(
                            controller: _email,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              fillColor: Color(0xfff3f3f4),
                              filled: true,
                              hintText: 'Enter your email',
                            ),
                            validator: (value){
                              if(value.isEmpty){
                                return 'Please Fill Post Title Input';
                              }
                              // return 'Valid Name';
                            },
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          TextFormField(
                            controller: _phonenumber,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              fillColor: Color(0xfff3f3f4),
                              filled: true,
                              hintText: 'Enter your Phone Number',
                            ),
                            validator: (value){
                              if(value.isEmpty){
                                return 'Please Fill Post Title Input';
                              }
                              // return 'Valid Name';
                            },
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          TextFormField(
                            controller: _feild,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              fillColor: Color(0xfff3f3f4),
                              filled: true,
                              hintText: 'Enter your feild',
                            ),
                            validator: (value){
                              if(value.isEmpty){
                                return 'Please Fill Post Title Input';
                              }
                              // return 'Valid Name';
                            },
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.multiline,
                            maxLines: 5,
                            controller: _problem,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              fillColor: Color(0xfff3f3f4),
                              filled: true,
                              hintText: 'Decribe your self',
                            ),
                            validator: (value){
                              if(value.isEmpty){
                                return 'Please Fill Description Input';
                              }
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          RaisedButton(
                            elevation: 5.0,
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(30.0)),

                            color: Colors.red,
                            child: Text('    Submit    ',style: TextStyle(color: Colors.white,fontSize: 23.0),),
                            onPressed: () async{
                              if(_formkey.currentState.validate()){

                                // add post
                                var currentUser = await FirebaseAuth.instance.currentUser();
                                Firestore.instance.collection('Posts_mentor').document().setData({
                                  'Name':_name.text,
                                  'Email' : _email.text,
                                  'Phone Number' : _phonenumber.text,
                                  'Feild' : _feild.text,
                                  'Description' : _problem.text,
                                  'user':{
                                    'uid':currentUser.uid,
                                    'email':currentUser.email,
                                  }
                                });
              
                               _onLoading();
                                

                              }
                              
                            
                             /* Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Dashboard()),
                              );*/
                            },
                          ),
                          Expanded(
                            flex: 2,
                            child: SizedBox(),
                          )
                        ],
                      ),
                    ),



                  ],
                ),
              )
          )
        ),
      ),
    );
  }


}