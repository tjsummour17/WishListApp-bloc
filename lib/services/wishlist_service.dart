import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wishlist_app/models/wish.dart';
import 'package:firebase_storage/firebase_storage.dart';

class WishlistService {
  late CollectionReference wishlist;

  Future<List<Wish>> fetchWishlist(String userId) async {
    try {
      var list = await wishlist.get();
      var result = list.docs.where((element) => element["userId"] == userId);
      log(result.toString());
    } catch (e) {
      log(e.toString());
    }
    return [];
  }

  Future<void> addWish({required Wish wish, File? wishImage}) async {
    if (wishImage != null) {
      wish.imageRef = await _uploadFile(wishImage.path);
    }
    wishlist.add(wish);
  }

  Future<String> _uploadFile(String filePath) async {
    File file = File(filePath);
    try {
      String fileName = filePath.split('/').last;
      await FirebaseStorage.instance.ref('uploads/$fileName}').putFile(file);
      return fileName;
    } catch (e) {
      // e.g, e.code == 'canceled'
      log(e.toString());
      return "";
    }
  }

  Future<String> getImageUrl(String fileName) async => await FirebaseStorage.instance.ref(fileName).getDownloadURL();

  WishlistService() {
    wishlist = FirebaseFirestore.instance.collection('wishlist');
  }
}
