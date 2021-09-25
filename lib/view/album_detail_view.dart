import 'package:apple_album_cover/model/album.dart';
import 'package:apple_album_cover/widget/bouncing_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marquee_widget/marquee_widget.dart';
import 'package:url_launcher/url_launcher.dart';

enum ScreenType { MOBILE, TABLET, DESKTOP }

class AlbumDetailView extends StatelessWidget {
  final Album album;
  final int index;
  const AlbumDetailView({Key? key, required this.album, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    ScreenType screenType = screenSize.width > 800
        ? (screenSize.width > 1200 ? ScreenType.DESKTOP : ScreenType.TABLET)
        : ScreenType.MOBILE;

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: screenType == ScreenType.DESKTOP
            ? const EdgeInsets.symmetric(horizontal: 256.0)
            : const EdgeInsets.symmetric(horizontal: 32.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 32),
                Hero(
                  tag: 'cover_$index',
                  child: Image.network(
                    // album.artworkUrl,
                    album.artworkThumbnail,
                    fit: BoxFit.fitWidth,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      }
                      return const Center(child: CupertinoActivityIndicator());
                    },
                  ),
                ),
                const SizedBox(height: 24),
                Marquee(
                  // directionMarguee: DirectionMarguee.oneDirection,
                  forwardAnimation: Curves.easeInOut,
                  backwardAnimation: Curves.easeInOut,
                  pauseDuration: const Duration(milliseconds: 600),
                  backDuration: const Duration(milliseconds: 1200),
                  child: Text(
                    album.collectionName,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                  ),
                ),
                const SizedBox(height: 12),
                Marquee(
                  // directionMarguee: DirectionMarguee.oneDirection,
                  forwardAnimation: Curves.easeInOut,
                  backwardAnimation: Curves.easeInOut,
                  pauseDuration: const Duration(milliseconds: 600),
                  backDuration: const Duration(milliseconds: 1200),
                  child: Text(
                    album.artistName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                  ),
                ),
                const SizedBox(height: 24),
                BouncingButton(
                  radius: 100,
                  width: 75,
                  height: 75,
                  color: Colors.black,
                  child: const Center(
                    child: Icon(
                      Icons.download_rounded,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () async {
                    if (await canLaunch(album.artworkUrl)) {
                      await launch(album.artworkUrl,
                          forceSafariVC: false, forceWebView: false);
                    }
                  },
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
