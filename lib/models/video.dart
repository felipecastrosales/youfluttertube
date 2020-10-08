import 'package:flutter/material.dart';

class Video {
  final String id;
  final String title;
  final String thumb;
  final String channel;

  Video(
      {@required this.id,
      @required this.title,
      @required this.thumb,
      @required this.channel});

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      id: json['id']['videoId'],
      title: json['snippet']['title'],
      thumb: json['thumbnails']['high']['url'],
      channel: json['channelTitle'],
    );
  }
}
