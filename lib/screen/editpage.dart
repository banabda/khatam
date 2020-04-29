import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:khatam_counter/services/auth.dart';
import 'package:provider/provider.dart';

import '../user.dart';

class EditPage extends StatefulWidget {
  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return Scaffold(
      backgroundColor: Color(0xff423FA5),
      body: FutureBuilder(
        initialData: Firestore.instance.collection("user/${user.uid}/progress").getDocuments(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!=null) {
                return MaterialButton(
                onPressed: () => authService.googleSignIn(),
                child: Text(snapshot.data.documents.toList()[0].data["ayat"].toString()),);
              }
            } else {
              return Text("kosooongngggg");
            }
            return Text("testing..");
        },
      ),
    );
  }
}
