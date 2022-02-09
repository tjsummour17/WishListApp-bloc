part of 'wishlist_bloc.dart';

class WishlistEvent extends Equatable {
  final String userId;

  WishlistEvent(this.userId);

  @override
  List<Object?> get props => [];
}

class GetWishlist extends WishlistEvent {
  GetWishlist(String userId) : super(userId);

  @override
  List<Object?> get props => [];
}

class AddToWishlist extends WishlistEvent {
  final Wish wish;
  final File? file;

  AddToWishlist({required String userId, required this.wish, this.file}) : super(userId);

  @override
  List<Object?> get props => [];
}

class EditWish extends WishlistEvent {
  final Wish wish;
  final File? file;

  EditWish({required String userId, required this.wish, this.file}) : super(userId);

  @override
  List<Object?> get props => [];
}
