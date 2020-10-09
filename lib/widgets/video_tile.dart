import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import '../blocs/favorite_bloc.dart';
import '../models/video.dart';

class VideoTile extends StatelessWidget {
  final Video video;

  VideoTile(this.video);

  @override
  Widget build(BuildContext context) {

    final bloc = BlocProvider.of<FavoriteBloc>(context);

    return Container(
      margin: EdgeInsets.symmetric(vertical: 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Image.network(
              video.thumb,
              fit: BoxFit.cover,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
                      child: Text(
                        video.title,
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        video.channel,
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              StreamBuilder<Map<String, Video>>(
                stream: bloc.outFav,
                initialData: {},
                builder: (context, snapshot){
                  if (snapshot.hasData) {
                    return IconButton(
                      icon: Icon(snapshot.data.containsKey(video.id)
                      ? Icons.star 
                      : Icons.star_border),
                      onPressed: () {
                        bloc.toggleFavorite(video);
                      },
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                })
            ],
          ),
        ],
      ),
    );
  }
}
