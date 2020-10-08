import 'package:flutter/material.dart';
import '../delegate/data_search.dart';

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
        backgroundColor: Colors.white70,
        actions: <Widget>[
          Align(
            alignment: Alignment.center,
            child: Text(
              '0',
              style: TextStyle(
                  color: Colors.grey[900],
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
          IconButton(
              icon: Icon(Icons.star, color: Colors.black87), onPressed: () {}),
          IconButton(
              icon: Icon(Icons.search, color: Colors.black87),
              onPressed: () async {
                var result =
                    await showSearch(context: context, delegate: DataSearch());
                print(result);
              }),
        ],
      ),
      body: Container(),
    );
  }
}
