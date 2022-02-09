import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:wishlist_app/bloc/wishlist_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wishlist_app/models/wish.dart';
import 'package:wishlist_app/providers/user_provider.dart';
import 'package:wishlist_app/res/assets.dart';
import 'package:wishlist_app/services/wishlist_repository.dart';
import 'package:wishlist_app/services/wishlist_service.dart';
import 'package:wishlist_app/views/new_wish_form.dart';
import 'package:wishlist_app/views/widgets/default_themes.dart';
import 'package:wishlist_app/views/widgets/wishlist_item.dart';

class WishlistView extends StatefulWidget {
  const WishlistView({Key? key}) : super(key: key);

  @override
  State<WishlistView> createState() => _WishlistViewState();
}

class _WishlistViewState extends State<WishlistView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    return RepositoryProvider(
      create: (context) => WishlistRepository(service: WishlistService()),
      child: MultiBlocProvider(
        providers: [BlocProvider<WishlistBloc>(create: (context) => WishlistBloc()..add(GetWishlist(userProvider.user!.id)))],
        child: BlocBuilder<WishlistBloc, WishlistState>(builder: (context, state) {
          return Column(children: [
            Container(
                margin: const EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width - 40,
                padding: const EdgeInsets.all(20),
                decoration: DefaultThemes.defaultContainerTheme(context),
                child: Text(AppLocalizations.of(context)!.welcomeMessage(userProvider.user!.name), style: Theme.of(context).textTheme.headline6)),
            if (state.wishlistStream != null)
              Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                      stream: state.wishlistStream,
                      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return Center(child: Text('Something went wrong'));
                        }

                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        }
                        if (snapshot.data!.docs.isEmpty) {
                          return ListView(
                            padding: const EdgeInsets.all(20.0),
                            shrinkWrap: true,
                            children: [
                              Lottie.asset(Assets.empty, repeat: false),
                              const SizedBox(height: 20),
                              Text(AppLocalizations.of(context)!.noWishesFound),
                              const SizedBox(height: 20),
                              ElevatedButton(
                                  onPressed: () => Navigator.pushNamed(context, NewWishForm.id), child: Text(AppLocalizations.of(context)!.addNewWish, style: Theme.of(context).textTheme.button))
                            ],
                          );
                        }
                        return Scaffold(
                          body: ListView(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            children: snapshot.data!.docs.map((DocumentSnapshot document) {
                              Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                              Wish wish = Wish.fromJson(data);
                              wish.docId = document.id;
                              return WishlistItem(wish: wish);
                            }).toList().reversed.toList(),
                          ),
                          floatingActionButton: FloatingActionButton(onPressed: () => Navigator.pushNamed(context, NewWishForm.id), child: const Icon(Icons.add, color: Colors.white)),
                        );
                      }))
          ]);
        }),
      ),
    );
  }
}
