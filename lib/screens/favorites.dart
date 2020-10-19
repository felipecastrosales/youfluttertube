import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_youtube/flutter_youtube.dart';
import '../api.dart';
import '../blocs/favorite_bloc.dart';
import '../models/video.dart';

class Favorites extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<FavoriteBloc>(context);

    return Scaffold(
        appBar: AppBar(
          title: Text('Favorites'),
          centerTitle: true,
          backgroundColor: Colors.red,
        ),
        body: StreamBuilder<Map<String, Video>>(
          stream: bloc.outFav,
          initialData: {},
          builder: (context, snapshot) {
            return ListView(
              children: snapshot.data.values.map((v) {
                return InkWell(
                    onTap: () {
                      FlutterYoutube.playYoutubeVideoById(
                          apiKey: API_KEY, videoId: v.id);
                    },
                    onLongPress: () {
                      bloc.toggleFavorite(v);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: 300,
                          height: 100,
                          child: Image.network(v.thumb),
                        ),
                        Expanded(
                          child: Text(
                            v.title,
                            maxLines: 2,
                          ),
                        )
                      ],
                    ));
              }).toList(),
            );
          },
        ));
  }
}
