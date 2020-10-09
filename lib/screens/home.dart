import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import '../blocs/videos_bloc.dart';
import '../delegate/data_search.dart';
import '../widgets/video_tile.dart';

class Home extends StatelessWidget {
  final bloc = BlocProvider.of<VideosBloc>(context);

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
                  bloc.inSearch.add(result);
                }
              }),
        ],
      ),
      body: StreamBuilder(
          stream: bloc.outVideos,
          initialData: [],
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  if (index < snapshot.data.length) {
                    return VideoTile(snapshot.data[index]);
                  } else if (index > 1) {
                    bloc.inSearch.add(null);
                    return Container(
                      width: 40,
                      height: 40,
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
                itemCount: snapshot.data.length + 1,
              );
            } else {
              return Container();
            }
          }),
    );
  }
}
