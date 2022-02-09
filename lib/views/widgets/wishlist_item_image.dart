import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wishlist_app/services/wishlist_service.dart';

class AllGamesItemImage extends StatefulWidget {
  AllGamesItemImage({Key? key, required this.backgroundImage}) : super(key: key);
  String backgroundImage;

  @override
  State<AllGamesItemImage> createState() => _AllGamesItemImageState();
}

class _AllGamesItemImageState extends State<AllGamesItemImage> {
  String imageUrl = "";
  @override
  void initState() {
    super.initState();
    getImage();
  }

  getImage() async {
    imageUrl = await WishlistService.getImageUrl(widget.backgroundImage);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (imageUrl.isNotEmpty) {
      return CachedNetworkImage(
          imageUrl: imageUrl,
          imageBuilder: (context, imageProvider) {
            return Container(
                width: 70, height: 70, decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0), image: DecorationImage(image: NetworkImage(imageUrl), fit: BoxFit.cover)));
          },
          placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
          errorWidget: (context, url, error) =>
              Icon(Icons.error, color: Theme
                  .of(context)
                  .primaryColor));
    } else {
      return Icon(Icons.error, color: Theme
          .of(context)
          .primaryColor);
    }
  }
}
