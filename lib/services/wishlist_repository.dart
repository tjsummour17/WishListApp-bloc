import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wishlist_app/services/wishlist_service.dart';

class WishlistRepository {
  const WishlistRepository({
    required this.service,
  });

  final WishlistService service;

  Future<Stream<QuerySnapshot<Object?>>> fetchWishlist(userId) async => await service.fetchWishlist(userId);
}
