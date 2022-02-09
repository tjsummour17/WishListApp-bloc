import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:wishlist_app/models/wish.dart';
import 'package:wishlist_app/res/assets.dart';
import 'package:wishlist_app/views/all_games_item.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wishlist_app/views/new_wish_form.dart';

class WishlistSuccessWidget extends StatelessWidget {
  const WishlistSuccessWidget({Key? key, required this.wishlist}) : super(key: key);

  final List<Wish> wishlist;

  @override
  Widget build(BuildContext context) {
    if (wishlist.isEmpty) {
      return ListView(
        padding: const EdgeInsets.all(20.0),
        shrinkWrap: true,
        children: [
          Lottie.asset(Assets.empty, repeat: false),
          const SizedBox(height: 20),
          Text(AppLocalizations.of(context)!.noWishesFound),
          const SizedBox(height: 20),
          ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, NewWishForm.id),
              child: Text(AppLocalizations.of(context)!.addNewWish, style: Theme.of(context).textTheme.button))
        ],
      );
    } else {
      return ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.only(
          left: 24.0,
          right: 24.0,
          top: 24.0,
        ),
        itemBuilder: (context, index) {
          return AllGamesItem(game: wishlist[index]);
        },
        separatorBuilder: (_, __) => const SizedBox(height: 20.0),
        itemCount: wishlist.length,
      );
    }
  }
}
