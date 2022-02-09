import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wishlist_app/models/wish.dart';
import 'package:wishlist_app/services/wishlist_service.dart';

part 'wishlist_event.dart';

part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  late WishlistService wishlistService;
  late Stream<QuerySnapshot> wishList;

  WishlistBloc() : super(const WishlistState()) {
    wishlistService = WishlistService();
    on<GetWishlist>(_mapGetWishlistEventToState);
    on<AddToWishlist>(_mapAddWishEventToState);
    on<EditWish>(_mapEditWishEventToState);
    on<DeleteWish>(_mapDeleteWishEventToState);
  }

  void _mapGetWishlistEventToState(GetWishlist event, Emitter<WishlistState> emit) async {
    try {
      emit(state.copyWith(status: WishlistStatus.loading));
      wishList = await WishlistService().fetchWishlist(event.userId);
      emit(state.copyWith(status: WishlistStatus.success, wishlistStream: wishList));
    } catch (error) {
      emit(state.copyWith(status: WishlistStatus.error));
      log(error.toString());
    }
  }

  void _mapAddWishEventToState(AddToWishlist event, Emitter<WishlistState> emit) async {
    try {
      emit(state.copyWith(status: WishlistStatus.loading));
      await WishlistService().addWish(wish: event.wish, wishImage: event.file);
      emit(state.copyWith(status: WishlistStatus.success, wishlistStream: wishList));
    } catch (error) {
      emit(state.copyWith(status: WishlistStatus.error));
      log(error.toString());
    }
  }

  void _mapEditWishEventToState(EditWish event, Emitter<WishlistState> emit) async {
    try {
      emit(state.copyWith(status: WishlistStatus.loading));
      await WishlistService().editWish(wish: event.wish, wishImage: event.file);
      emit(state.copyWith(status: WishlistStatus.success, wishlistStream: wishList));
    } catch (error) {
      emit(state.copyWith(status: WishlistStatus.error));
      log(error.toString());
    }
  }

  void _mapDeleteWishEventToState(DeleteWish event, Emitter<WishlistState> emit) async {
    try {
      emit(state.copyWith(status: WishlistStatus.loading));
      await WishlistService().deleteWish(wishId: event.wishId);
      emit(state.copyWith(status: WishlistStatus.success, wishlistStream: wishList));
    } catch (error) {
      emit(state.copyWith(status: WishlistStatus.error));
      log(error.toString());
    }
  }
}
