part of 'wishlist_bloc.dart';

enum WishlistStatus { initial, success, error, loading }

extension WishlistStatusX on WishlistStatus {
  bool get isInitial => this == WishlistStatus.initial;

  bool get isSuccess => this == WishlistStatus.success;

  bool get isError => this == WishlistStatus.error;

  bool get isLoading => this == WishlistStatus.loading;
}

class WishlistState extends Equatable {
  const WishlistState({this.status = WishlistStatus.initial, this.wishlistStream});

  final Stream<QuerySnapshot>? wishlistStream;
  final WishlistStatus status;

  @override
  List<Object?> get props => [status, wishlistStream];

  WishlistState copyWith({Stream<QuerySnapshot>? wishlistStream, WishlistStatus? status}) {
    return WishlistState(wishlistStream: wishlistStream ?? this.wishlistStream, status: status ?? this.status);
  }
}
