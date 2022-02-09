import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wishlist_app/models/wish.dart';
import 'package:wishlist_app/services/wishlist_service.dart';
import 'package:wishlist_app/views/edit_wish_form.dart';
import 'package:wishlist_app/views/widgets/wishlist_item_image.dart';
import 'package:wishlist_app/views/widgets/default_themes.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WishlistItem extends StatelessWidget {
  const WishlistItem({Key? key, required this.wish}) : super(key: key);

  final Wish wish;

  _buildLogoutDialog(BuildContext context) async {
    return await showDialog(
        builder: (BuildContext context) => (Platform.isIOS)
            ? CupertinoAlertDialog(title: Text(AppLocalizations.of(context)!.delete), content: Text(AppLocalizations.of(context)!.areYouSureToDeleteWish), actions: [
                TextButton(onPressed: () => Navigator.pop(context, true), child: Text(AppLocalizations.of(context)!.yes)),
                TextButton(onPressed: () => Navigator.pop(context, false), child: Text(AppLocalizations.of(context)!.no))
              ])
            : AlertDialog(title: Text(AppLocalizations.of(context)!.delete), content: Text(AppLocalizations.of(context)!.areYouSureToDeleteWish), actions: [
                TextButton(onPressed: () => Navigator.pop(context, true), child: Text(AppLocalizations.of(context)!.yes)),
                TextButton(onPressed: () => Navigator.pop(context, false), child: Text(AppLocalizations.of(context)!.no))
              ]),
        context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(wish.docId),
      confirmDismiss: (_) async {
        bool? result = await _buildLogoutDialog(context);
        if (result != null && result) {
          await WishlistService().deleteWish(wishId: wish.docId);
          return true;
        }
        return false;
      },
      child: Container(
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
          )),
    );
  }
}
