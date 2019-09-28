import 'package:flutter/material.dart';

class ListData extends StatelessWidget {
  final String title;
  final String subTitle;
  ListData(this.title, this.subTitle);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 10, bottom: 10),
              child: Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 15,),
              child: Text(subTitle),
            ),
          ],
        ),
      ),
    );
  }
}
