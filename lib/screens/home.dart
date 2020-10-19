import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import '../blocs/favorite_bloc.dart';
import '../blocs/videos_bloc.dart';
import '../delegate/data_search.dart';
import '../models/video.dart';
import '../widgets/video_tile.dart';
import 'favorites.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<VideosBloc>(context);

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
            child: StreamBuilder<Map<String, Video>>(
                stream: BlocProvider.of<FavoriteBloc>(context).outFav,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text(
                      '${snapshot.data.length}',
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    );
                  } else {
                    return Container();
                  }
                }),
          ),
          IconButton(
              icon: Icon(Icons.star, color: Colors.black87),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Favorites()));
              }),
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
