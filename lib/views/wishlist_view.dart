import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:wishlist_app/bloc/wishlist_bloc.dart';
import 'package:wishlist_app/providers/main_page_provider.dart';
import 'package:wishlist_app/providers/user_provider.dart';
import 'package:wishlist_app/res/assets.dart';
import 'package:wishlist_app/services/wishlist_repository.dart';
import 'package:wishlist_app/services/wishlist_service.dart';
import 'package:wishlist_app/views/widgets/error_widget.dart';
import 'package:wishlist_app/views/wishlist_success_widget.dart';

class WishlistView extends StatelessWidget {
  const WishlistView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    return BlocProvider(
      create: (context) => WishlistBloc()..add(GetWishlist()),
      child: BlocBuilder<WishlistBloc, WishlistState>(builder: (context, state) {
        return state.status.isSuccess
            ? WishlistSuccessWidget(wishlist: state.wishlist)
            : state.status.isLoading
                ? const Center(child: CircularProgressIndicator())
                : state.status.isError
                    ? const SomethingWentWrongWidget()
                    : Lottie.asset(Assets.empty);
      }),
    );
  }
}
