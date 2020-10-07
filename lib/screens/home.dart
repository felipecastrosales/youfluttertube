import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          height: 20,
          child: Image.asset('assets/images/youtube.png'),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        actions: <Widget>[
          Align(
            alignment: Alignment.center,
            child: Text(
              '0',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.bold),
            ),
          ),
          IconButton(
              icon: Icon(Icons.star, color: Colors.black87),
              onPressed: () {

              }),
          IconButton(
              icon: Icon(Icons.search, color: Colors.black87),
              onPressed: () {
                
              }),
        ],
      ),
      body: Container(),
    );
  }
}
