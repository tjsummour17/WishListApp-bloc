import 'package:wishlist_app/models/wish.dart';
import 'package:wishlist_app/services/wishlist_service.dart';

class WishlistRepository {
  const WishlistRepository({
    required this.service,
  });

  final WishlistService service;

  Future<List<Wish>> getGames(userId) async => service.fetchWishlist(userId);
}
