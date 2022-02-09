import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wishlist_app/models/wish.dart';
import 'package:wishlist_app/services/wishlist_repository.dart';
import 'package:wishlist_app/services/wishlist_service.dart';

part 'all_games_event.dart';

part 'all_games_state.dart';

class WishlistBloc extends Bloc<AllGamesEvent, WishlistState> {
  // final WishlistRepository wishListRepository;
  // String userId;
  WishlistBloc() : super(const WishlistState(wishlist: [])) {
    on<GetWishlist>(_mapGetGamesEventToState);
  }

  void _mapGetGamesEventToState(GetWishlist event, Emitter<WishlistState> emit) async {
    try {
      emit(state.copyWith(status: WishlistStatus.loading));
      // final wishList = await wishListRepository.getGames(userId);
      emit(state.copyWith(status: WishlistStatus.success, wishlist: []));
    } catch (error) {
      emit(state.copyWith(status: WishlistStatus.error));
    }
  }
}
