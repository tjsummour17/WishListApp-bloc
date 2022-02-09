import 'package:flutter/material.dart';
import 'package:wishlist_app/models/wish.dart';
import 'package:wishlist_app/views/all_games_item_button.dart';
import 'package:wishlist_app/views/all_games_item_image.dart';

class AllGamesItem extends StatelessWidget {
  const AllGamesItem({
    Key? key,
    required this.game,
  }) : super(key: key);

  final Wish game;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.grey.withOpacity(.1),
      ),
      child: Stack(
        children: [
          Positioned(left: 20.0, top: 15.0, bottom: 15.0, child: AllGamesItemImage(backgroundImage: '')),
          Positioned(
            top: 25.0,
            left: 100.0,
            child: Container(
              width: MediaQuery.of(context).size.width * .5,
              child: Text(game.title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0), overflow: TextOverflow.ellipsis),
            ),
          ),
          Positioned(left: 100.0, top: 45.0, child: Text(game.description ?? '', style: TextStyle(fontSize: 12.0))),
          Positioned(
            right: 20.0,
            bottom: 10.0,
            child: AllGamesItemButton(
              callback: () {
                print('item name-->${game.title}');
              },
            ),
          ),
        ],
      ),
    );
  }
}
