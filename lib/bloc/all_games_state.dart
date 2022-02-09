part of 'wishlist_bloc.dart';

enum WishlistStatus { initial, success, error, loading }

extension WishlistStatusX on WishlistStatus {
  bool get isInitial => this == WishlistStatus.initial;

  bool get isSuccess => this == WishlistStatus.success;

  bool get isError => this == WishlistStatus.error;

  bool get isLoading => this == WishlistStatus.loading;
}

class WishlistState extends Equatable {
  const WishlistState({this.status = WishlistStatus.initial, required this.wishlist});

  final List<Wish> wishlist;
  final WishlistStatus status;

  @override
  List<Object?> get props => [status, wishlist];

  WishlistState copyWith({List<Wish>? wishlist, WishlistStatus? status}) {
    return WishlistState(wishlist: wishlist ?? this.wishlist, status: status ?? this.status);
  }
}
