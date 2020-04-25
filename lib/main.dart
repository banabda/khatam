import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:khatam_counter/screen/editpage.dart';
import 'package:khatam_counter/screen/home.dart';
import 'package:khatam_counter/services/auth.dart';
import 'package:khatam_counter/user.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      title: 'Khatam Apps',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xff423FA5),
        // body: PageView(
        //         scrollDirection: Axis.horizontal,
        //         children: <Widget>[
        //           HomePage(),
        //           EditPage()
        //         ]
        //       ),
        body: StreamProvider<User>.value(
          value: AuthService().user,
          child: LoginButton())
      )
    );
  }
}

class LoginButton extends StatelessWidget {
  const LoginButton({Key key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    if (user == null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage("assets/images/alquran_2.png"), height: 200.0,),
            SizedBox(height: 50.0),
            Text(
              "Khatam Counter Apps",
              textAlign: TextAlign.center,
              softWrap: true,
              style: TextStyle(
                letterSpacing: 3.0,
                wordSpacing: 3.0,
                color: Colors.white,
                fontSize: 45.0,
                fontWeight: FontWeight.bold
              ),),
            SizedBox(height: 50.0),
            _signInButton(),
          ],
        ));
    } else {
      return PageView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          HomePage(),
          EditPage()
        ]
      );
    }
  }
}

Widget _signInButton() {
    return OutlineButton(
      splashColor: Colors.grey,
      onPressed: () => authService.googleSignIn(),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.white, width: 3.0),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: NetworkImage("http://pngimg.com/uploads/google/google_PNG19630.png"), height: 35.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Sign in with Google',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }