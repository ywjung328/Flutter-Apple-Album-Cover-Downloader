import 'dart:js';

class Album {
  final String artistName;
  final String collectionName;
  final String artworkThumbnail;
  final String artworkUrl;

  Album({
    required this.artistName,
    required this.collectionName,
    required this.artworkThumbnail,
    required this.artworkUrl,
  });

  factory Album.fromJson(JsObject json) {
    return Album(
        artistName: json['artistName'],
        collectionName: json['collectionName'],
        artworkThumbnail: json['artworkUrl100']
            // .replaceAll('https://', 'http://')
            // .replaceAll('-ssl', '')
            .replaceAll('100x100bb', '600x600bb'),
        artworkUrl: json['artworkUrl100']
            .replaceAll('https://', 'http://')
            .replaceAll('-ssl', '')
            .replaceAll('100x100bb', '10000x10000-999'));
  }
}
