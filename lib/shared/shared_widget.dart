import 'package:flutter/material.dart';
import 'package:khatam_counter/dataUser.dart';
import 'package:provider/provider.dart';

class Cardwidget extends StatelessWidget {
  final String text1;
  final String text2;
  final Color setColor;
  

  const Cardwidget({Key key, this.text1, this.text2, this.setColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dataProgress = Provider.of<List<DataUser>>(context);
    dataProgress.forEach((f){
      print(f.ayat);
      print(f.surat);
      print(f.juz);
      print(f.hari);
    });
    
    return Container(
      padding: EdgeInsets.all(12.0),
      width: 200.0,
      height: 200.0,
      child: Card(
        elevation: 8,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        child: Container(
          padding: EdgeInsets.all(8.0),
          width: 200.0,
          height: 200.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.library_books,
                color: setColor,
                size: 48,
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                "$text1",
                style: TextStyle(
                  letterSpacing: 2.0,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
                softWrap: true,
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                "${dataProgress.elementAt(0).ayat}",
                style: TextStyle(fontSize: 16.0),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class TextWidgets extends StatelessWidget {
  final String text;
  const TextWidgets({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dataProgress = Provider.of<List<DataUser>>(context);
    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: 150.0,
      ),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "${dataProgress.elementAt(0).ayat} $text",
              textAlign: TextAlign.left,
              style: TextStyle(
                letterSpacing: 2.0,
                fontSize: 20.0,
                fontWeight: FontWeight.w400,
                color: Colors.teal[600],
              ),
            ),
            SizedBox(height: 24),
          ],
        ),
        
      ),
    );
  }
}
