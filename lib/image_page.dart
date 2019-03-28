import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:unsplash_client/models.dart';
import 'package:url_launcher/url_launcher.dart';

/// Screen for showing an individual [UnsplashImage].
class ImagePage extends StatefulWidget {
  final UnsplashImage image;

  ImagePage({Key key, this.image}) : super(key: key);

  @override
  _ImagePageState createState() => _ImagePageState();
}

/// Provide a state for [ImagePage].
class _ImagePageState extends State<ImagePage> {
  _downloadImage() async {
    // TODO
  }

  /// Returns AppBar.
  Widget _buildAppBar() => AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading:
            // back button
            IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white70,
                ),
                onPressed: () => Navigator.pop(context)),
        actions: <Widget>[
          // open in browser icon button
          IconButton(
              icon: Icon(
                Icons.open_in_browser,
                color: Colors.white70,
              ),
              tooltip: 'Open in Browser',
              onPressed: () =>
                  // open url in browser
                  launch(widget.image.getDownloadLink())),
          // set as wallpaper */
          IconButton(
            icon: Icon(
              Icons.file_download,
              color: Colors.white70,
            ),
            onPressed: () =>
                // download image
                _downloadImage(),
          ),
        ],
      );

  /// Returns PhotoView around given [image].
  Widget _buildPhotoView(UnsplashImage image) => PhotoView(
        imageProvider: NetworkImage(image.getRegularUrl()),
        initialScale: PhotoViewComputedScale.covered,
        minScale: PhotoViewComputedScale.covered,
        maxScale: PhotoViewComputedScale.covered,
        heroTag: '${image.getId()}',
        loadingChild: const Center(
            child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white70),
        )),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: <Widget>[
          _buildPhotoView(widget.image),
          // wrap in Positioned to not use entire screen
          Positioned(top: 0.0, left: 0.0, right: 0.0, child: _buildAppBar()),
        ],
      ),
    );
  }
}
