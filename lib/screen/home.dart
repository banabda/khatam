import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:khatam_counter/dataUser.dart';
import 'package:khatam_counter/services/auth.dart';
import 'package:khatam_counter/screen/editpage.dart';
import 'package:khatam_counter/services/database.dart';
import 'package:khatam_counter/shared/shared_widget.dart';
import 'package:provider/provider.dart';
import 'package:khatam_counter/user.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return StreamProvider<List<DataUser>>.value(
      value: DatabaseService(uid: user.uid).progress,
      child: Scaffold(
        backgroundColor: Color(0xff423FA5),
        body: Stack(
          children: <Widget>[
            Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 24.0, left: 24.0, right: 24.0),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Hey, ${user.name}!",
                            style: TextStyle(
                              fontSize: 36.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.teal[50],
                            ),
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          Text(
                            "Have a nice day and stay safe!",
                            style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.greenAccent[200],
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      IconButton(
                          icon: Icon(
                            Icons.exit_to_app,
                            size: 36.0,
                            color: Colors.teal[50],
                          ),
                          onPressed: () => authService.signOut())
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24.0),
                child: Container(
                  child: Wrap(
                    children: <Widget>[
                      Cardwidget(
                        text1: "Juz",
                        text2: "5",
                        setColor: Colors.red,
                      ),
                      Cardwidget(
                        text1: "Surat",
                        text2: "45",
                        setColor: Colors.blue,
                      ),
                      Cardwidget(
                        text1: "Ayat",
                        text2: "52",
                        setColor: Colors.green,
                      ),
                      Cardwidget(
                        text1: "Day",
                        text2: "12",
                        setColor: Colors.orange,
                      ),
                    ],
                  ),
                ),
              ),
              
            ],
          ),
          Container(
            child: 
            DraggableScrollableSheet(
              initialChildSize: 0.3,
              minChildSize: 0.2,
              maxChildSize: 0.4,
              builder: (BuildContext context, myscrollController) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                      // gradient: LinearGradient(
                      //     begin: Alignment.topRight,
                      //     end: Alignment.bottomLeft,
                      //     colors: [
                      //       Colors.greenAccent[100],
                      //       Colors.green[600]
                      //     ]),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(64.0),
                          topRight: Radius.circular(64.0)),
                      boxShadow: [
                        BoxShadow(
                            color: Color.fromRGBO(143, 148, 251, .2),
                            blurRadius: 10.0,
                            offset: Offset(0, -10))
                      ]),
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(64.0),
                      topRight: Radius.circular(64.0)),
                    child: ListView(
                      controller: myscrollController,
                      children: <Widget>[
                        Stack(children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(48.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Your Progress",
                                  style: TextStyle(
                                    fontSize: 32.0,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.teal[700],
                                  ),
                                ),
                                SizedBox(height: 48),
                                Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 12.0),
                                    child: Column(
                                      children: <Widget>[
                                        TextWidgets(text: "Juz(s)"),
                                        TextWidgets(text: "Surat(s)"),
                                        TextWidgets(text: "Ayat(s)"),
                                        TextWidgets(text: "Day(s)"),
                                      ],
                                    ))
                              ],
                            ),
                          ),
                          Positioned(
                            bottom: -75,
                            right: -100,
                            child: Hero(
                              tag: "Edit",
                              child: GestureDetector(
                                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => EditPage())),
                                child: Container(
                                  //   child: Image.asset(
                                  // "assets/images/alquran_2.png",
                                  // fit: BoxFit.cover,
                                  // height: 325.0,
                                  // )
                                ),
                              ),
                            )
                          )
                        ]),
                      ]
                    ),
                  ),
                );
              }
            ),
          )
          ]
        ),
      ),
    );
  }
}
