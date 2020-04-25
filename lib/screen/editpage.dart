import 'package:flutter/material.dart';
import 'package:khatam_counter/services/auth.dart';

class EditPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff423FA5),
      body: Center(
        child: MaterialButton(
          onPressed: () => authService.googleSignIn()
        )
      ),
    );
  }
}
