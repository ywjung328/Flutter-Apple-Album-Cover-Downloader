import 'package:apple_album_cover/widget/album_card.dart';
import 'package:apple_album_cover/widget/logo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:apple_album_cover/provider/album_search.dart';
import 'package:provider/provider.dart';

enum ScreenType { MOBILE, TABLET, DESKTOP }

class SearchView extends StatefulWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  max(var a, var b) {
    return a > b ? a : b;
  }

  min(var a, var b) {
    return a < b ? a : b;
  }

  @override
  Widget build(BuildContext context) {
    final albumProvider = Provider.of<AlbumSearch>(context);
    var screenSize = MediaQuery.of(context).size;
    ScreenType screenType = screenSize.width > 800
        ? (screenSize.width > 1200 ? ScreenType.DESKTOP : ScreenType.TABLET)
        : ScreenType.MOBILE;

    int getCrossAxisCount() {
      double availableWidth =
          (screenSize.width - (screenType == ScreenType.DESKTOP ? 512 : 64));

      if (screenType == ScreenType.DESKTOP) {
        return min(max(1, albumProvider.getResults().length),
            max(1, min(availableWidth ~/ 200, 5)));
      } else {
        return min(max(1, albumProvider.getResults().length),
            max(1, min(availableWidth ~/ 250, 4)));
      }
    }

    return Title(
      title: albumProvider.getTitle(),
      color: Colors.white,
      child: Scaffold(
        appBar: AppBar(
          title: const Padding(
            padding: EdgeInsets.only(top: 18.0),
            child: Logo(size: 24.0),
          ),
          centerTitle: true,
          bottom: PreferredSize(
            child: Padding(
              padding: screenType == ScreenType.DESKTOP
                  ? const EdgeInsets.symmetric(horizontal: 256.0)
                  : const EdgeInsets.symmetric(horizontal: 32.0),
              child: TextField(
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  // labelText: "Search keyword here",
                  hintText: "Search with keyword here!",
                  alignLabelWithHint: true,
                ),
                onSubmitted: (text) {
                  albumProvider.setTitle(text);
                  albumProvider.search(text);
                },
              ),
            ),
            preferredSize: const Size(0, 72),
          ),
        ),
        // onTap: () => FocusScope.of(context).unfocus(), <= WITH GESTURE DETECTOR
        body: Center(
          child: !albumProvider.loadStatus
              ? const CupertinoActivityIndicator()
              : SingleChildScrollView(
                  child: Padding(
                    padding: screenType == ScreenType.DESKTOP
                        ? const EdgeInsets.symmetric(horizontal: 256.0)
                        : const EdgeInsets.symmetric(horizontal: 32.0),
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: GridView.builder(
                        clipBehavior: Clip.none,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          // crossAxisCount: screenType == ScreenType.DESKTOP
                          //     ? 3
                          //     : (screenType == ScreenType.TABLET ? 2 : 1),
                          crossAxisCount: getCrossAxisCount(),
                          crossAxisSpacing: 12,
                          // mainAxisExtent: 700,
                          mainAxisSpacing: 18,
                          childAspectRatio: 0.75,
                        ),
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(8),
                        itemCount: albumProvider.getResults().length,
                        itemBuilder: (BuildContext context, int index) {
                          return AlbumCard(
                            album: albumProvider.getResults()[index],
                            index: index,
                          );
                        },
                      ),
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
