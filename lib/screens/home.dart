import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import '../blocs/videos_bloc.dart';
import '../delegate/data_search.dart';
import '../widgets/video_tile.dart';

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
                if (result != null) {
                  BlocProvider.of<VideosBloc>(context).inSearch.add(result);
                }
              }),
        ],
      ),
      body: StreamBuilder(
          stream: BlocProvider.of<VideosBloc>(context).outVideos,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(itemBuilder: (context, index) {
                return VideoTile(snapshot.data[index]);
              });
            } else {
              return Container();
            }
          }),
    );
  }
}
