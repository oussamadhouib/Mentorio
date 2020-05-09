import 'package:flutter/material.dart';
import 'package:mentorio/pages/mentee.dart';
import 'package:mentorio/pages/mentor.dart';
import 'package:mentorio/services/authentication.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:mentorio/models/todo.dart';
import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';

import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.auth, this.userId, this.logoutCallback})
      : super(key: key);

  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;

  @override
  State<StatefulWidget> createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Todo> _todoList;

  final FirebaseDatabase _database = FirebaseDatabase.instance;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final _textEditingController = TextEditingController();
  StreamSubscription<Event> _onTodoAddedSubscription;
  StreamSubscription<Event> _onTodoChangedSubscription;

  Query _todoQuery;

  //bool _isEmailVerified = false;

  @override
  void initState() {
    super.initState();

    //_checkEmailVerification();

    _todoList = new List();
    _todoQuery = _database
        .reference()
        .child("todo")
        .orderByChild("userId")
        .equalTo(widget.userId);
    _onTodoAddedSubscription = _todoQuery.onChildAdded.listen(onEntryAdded);
    _onTodoChangedSubscription =
        _todoQuery.onChildChanged.listen(onEntryChanged);
  }



  @override
  void dispose() {
    _onTodoAddedSubscription.cancel();
    _onTodoChangedSubscription.cancel();
    super.dispose();
  }

  onEntryChanged(Event event) {
    var oldEntry = _todoList.singleWhere((entry) {
      return entry.key == event.snapshot.key;
    });

    setState(() {
      _todoList[_todoList.indexOf(oldEntry)] =
          Todo.fromSnapshot(event.snapshot);
    });
  }

  onEntryAdded(Event event) {
    setState(() {
      _todoList.add(Todo.fromSnapshot(event.snapshot));
    });
  }

  signOut() async {
    try {
      await widget.auth.signOut();
      widget.logoutCallback();
    } catch (e) {
      print(e);
    }
  }

  addNewTodo(String todoItem) {
    if (todoItem.length > 0) {
      Todo todo = new Todo(todoItem.toString(), widget.userId, false);
      _database.reference().child("todo").push().set(todo.toJson());
    }
  }

  updateTodo(Todo todo) {
    //Toggle completed
    todo.completed = !todo.completed;
    if (todo != null) {
      _database.reference().child("todo").child(todo.key).set(todo.toJson());
    }
  }

  deleteTodo(String todoId, int index) {
    _database.reference().child("todo").child(todoId).remove().then((_) {
      print("Delete $todoId successful");
      setState(() {
        _todoList.removeAt(index);
      });
    });
  }

  showAddTodoDialog(BuildContext context) async {
    _textEditingController.clear();
    await showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: new Row(
              children: <Widget>[
                new Expanded(
                    child: new TextField(
                      controller: _textEditingController,
                      autofocus: true,
                      decoration: new InputDecoration(
                        labelText: 'Add new todo',
                      ),
                    ))
              ],
            ),
          );
        });
  }

  // ignore: non_constant_identifier_names
  Widget _ButtonNavigationMentee() {
    return new Padding(
        padding: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
        child: SizedBox(
          height: 40.0,
          child: new RaisedButton(
            elevation: 5.0,
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0)),
            color: Colors.red,
            child: new Text('     Mentee Space     ',
                style: new TextStyle(fontSize: 20.0, color: Colors.white)),

            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Mentee()),
              );
            },
          ),
        ));
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

  // ignore: non_constant_identifier_names
  Widget _ButtonNavigationMentor() {
    return new Padding(
        padding: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
        child: SizedBox(
          height: 40.0,
          child: new RaisedButton(
            elevation: 5.0,
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0)),
            color: Colors.black,
            child: new Text('      Mentor Space       ',
                style: new TextStyle(fontSize: 20.0, color: Colors.white)),

            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Mentor()),
              );
            },
          ),
        ));
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Mentorio Tunisia'),
        actions: <Widget>[
          new FlatButton(
              child: new Text('Logout',
                  style: new TextStyle(fontSize: 20.0, color: Colors.white)),
              onPressed: signOut)
        ],
      ),

      body: Center(

       child: Column(

        children: <Widget>[
          SizedBox(
            height: 30,
          ),

          _title(),
          SizedBox(
            height: 30,
          ),

          SizedBox(
            height: 250,
            width: 250.0,
            child: TyperAnimatedTextKit(
                onTap: () {
                  print("Tap Event");
                },
                text: [
                  "The first mentoring application in Tunisia,",
                  "If you are a mentor click on the Mentor space button",
                  "If you are a mentee click on the Mentee space button",
                  "أيا عاد فاش تستنى ..!",
                ],
                textStyle: TextStyle(
                  color: Colors.black,
                    fontSize: 30.0,
                    fontFamily: "Bobbers"
                ),
                textAlign: TextAlign.start,
                alignment: AlignmentDirectional.topStart // or Alignment.topLeft
            ),
          ),
          _ButtonNavigationMentor(),
          SizedBox(
            height: 0,
          ),
          _ButtonNavigationMentee(),
          SizedBox(
            height: 5,
          ),


            ],

         ),
      ));
  }


}