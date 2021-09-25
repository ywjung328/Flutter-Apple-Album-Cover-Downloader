import 'package:apple_album_cover/model/album.dart';
import 'package:apple_album_cover/view/album_detail_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// import 'package:http/http.dart' as http;

class AlbumCard extends StatelessWidget {
  final Album album;
  final int index;
  const AlbumCard({Key? key, required this.album, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      // color: Colors.grey[50],
      color: Colors.white,
      elevation: 16.0,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, a1, a2) {
                return FadeTransition(
                  opacity: a1,
                  child: AlbumDetailView(
                    album: album,
                    index: index,
                  ),
                );
              },
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Hero(
                tag: 'cover_$index',
                // child: Image.network(
                //   album.artworkThumbnail,
                //   fit: BoxFit.fitWidth,
                // ),
                child: Image.network(
                  album.artworkThumbnail,
                  fit: BoxFit.cover,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }
                    return const Center(child: CupertinoActivityIndicator());
                  },
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      album.collectionName,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 1,
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      album.artistName,
                      style: const TextStyle(
                        fontSize: 8,
                        fontWeight: FontWeight.w300,
                      ),
                      maxLines: 1,
                    ),
                    const SizedBox(height: 8.0),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
