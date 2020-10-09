import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'api.dart';
import 'blocs/favorite_bloc.dart';
import 'blocs/videos_bloc.dart';
import 'screens/home.dart';

void main() {
  var api = Api();
  api.search('flutter');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: VideosBloc(),
      child: BlocProvider(
        bloc: FavoriteBloc(),
          child: MaterialApp(
            title: 'YouFlutterTube',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              brightness: Brightness.light,
              accentColor: Colors.cyan[900],
              fontFamily: 'Roboto',
            ),
          home: Home(),
        ),
      ),
    );
  }
}
