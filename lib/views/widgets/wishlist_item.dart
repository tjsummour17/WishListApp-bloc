import 'package:flutter/material.dart';
import 'package:wishlist_app/models/wish.dart';
import 'package:wishlist_app/views/edit_wish_form.dart';
import 'package:wishlist_app/views/widgets/wishlist_item_image.dart';
import 'package:wishlist_app/views/widgets/default_themes.dart';
import 'package:intl/intl.dart';

class WishlistItem extends StatelessWidget {
  const WishlistItem({Key? key, required this.wish}) : super(key: key);

  final Wish wish;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: DefaultThemes.defaultContainerTheme(context),
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.symmetric(vertical: 7.5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              children: [
                AllGamesItemImage(backgroundImage: wish.imageRef),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(wish.title, style: Theme.of(context).textTheme.subtitle1!.copyWith(fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis),
                      if (wish.description != null) Text(wish.description!, maxLines: 3, overflow: TextOverflow.ellipsis),
                    ],
                  ),
                ),
                IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => EditWishForm(wish: wish)));
                    }),
              ],
            ),
            Text(DateFormat("MM/dd hh:mm:ss").format(wish.dateCreated), style: Theme.of(context).textTheme.caption, overflow: TextOverflow.ellipsis),
          ],
        ));
  }
}
