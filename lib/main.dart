import 'package:apple_album_cover/provider/album_search.dart';
// import 'package:apple_album_cover/view/album_detail_view.dart';
import 'package:apple_album_cover/view/search_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_strategy/url_strategy.dart';

void main() {
  setPathUrlStrategy();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "N-Limbo's Album Cover Downloader",
      home: ChangeNotifierProvider<AlbumSearch>(
        create: (context) => AlbumSearch(),
        child: const SearchView(),
      ),
      theme: ThemeData(
        fontFamily: 'Gmarket_Sans',
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: Colors.white,
        primarySwatch: Colors.grey,
        primaryColor: Colors.white,
        appBarTheme: const AppBarTheme(
          foregroundColor: Colors.black,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
      ),
    );
  }
}
