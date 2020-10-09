import 'dart:convert';
import 'package:http/http.dart' as http;
import 'models/video.dart';

// ignore: constant_identifier_names
const API_KEY = 'AIzaSyDPNJjyJAvsBarsR_PqKN1bTi_TIA7_Xwc';

class Api {
  String _search;
  String _nextToken;

  Future<List<Video>> search(String search) async {
    _search = search;
    var response = await http
        .get('https://www.googleapis.com/youtube/v3/search?part=snippet&q='
            '$search&type=video&key=$API_KEY&maxResults=10');
    return decode(response);
  }

  Future<List<Video>> nextPage() async {
    var response = await http.get(
        'https://www.googleapis.com/youtube/v3/search?part=snippet&q='
        '$_search&type=video&key=$API_KEY&maxResults=10&pageToken=$_nextToken');
    return decode(response);
  }

  // ignore: type_annotate_public_apis
  List<Video> decode(http.Response response) {
    if (response.statusCode == 200) {
      var decoded = json.decode(response.body);

      _nextToken = decoded['nextPageToken'];

      List<Video> videos = decoded['items'].map<Video>((map) {
        return Video.fromJson(map);
      }).toList();
      return videos;
    } else {
      throw Exception('Failed to load videos');
    }
  }
}
