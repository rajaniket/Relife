import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';

class ProfileImageView extends StatelessWidget {
  // final String imagepath;
  final String imgUrl;
  const ProfileImageView({
    Key? key,
    required this.imgUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        border: null,
      ),
      child: InteractiveViewer(
        child: Center(
            child: CachedNetworkImage(
          imageUrl: 'https://relife.co.in/api/$imgUrl',
        )),
      ),
    );
  }
}
