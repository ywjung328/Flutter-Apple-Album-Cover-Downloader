import 'dart:convert';
import 'dart:js';

// import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:apple_album_cover/jsonp/jsonp.dart' as jsonp;

import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

import 'package:apple_album_cover/model/album.dart';

class AlbumSearch extends ChangeNotifier {
  bool loadStatus = true;
  String title = "N-Limbo's Album Cover Downloader";

  String getTitle() {
    return title;
  }

  void setTitle(String title) {
    this.title = title;
  }

  List<Album> resultList = [];

  List<Album> getResults() {
    return resultList;
  }

  Future search(String keyword,
      {String country = "kr", String entry = "album", int limit = 500}) async {
    loadStatus = false;
    notifyListeners();

    resultList.clear();
    var url =
        'https://itunes.apple.com/search?term=${Uri.encodeQueryComponent(keyword)}&country=$country&entity=$entry&limit=$limit&callback=?';
    // ex : https://itunes.apple.com/search?term=%EC%9D%B4%EB%8B%AC%EC%9D%98%EC%86%8C%EB%85%80&country=kr&entity=album&limit=500&callback=callbackMethod

    var response = await jsonp.fetch(
      uri: url,
      uriGenerator: (uri) => uri,
    );

    for (int i = 0; i < response['resultCount']; i++) {
      // JsObject temp = response['results'][i];
      resultList.add(Album.fromJson(response['results'][i]));
      // print(response['results'][i]['collectionName']);
    }

    // BELOW CODES ONLY WORK ON PLATFORMS THOSE ARE NOT WEB!!
    // AND ABOVE CODES WON'T WORK IF THOSE ARE NOT ON WEB!!

    // var response = await http.get(Uri.parse(url));

    // resultList =
    //     List<Album>.from(rawResult.asMap((album) => Album.fromJson(album)));

    loadStatus = true;
    notifyListeners();
  }
}
