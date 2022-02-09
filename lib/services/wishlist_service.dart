import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:wishlist_app/models/wish.dart';
import 'package:firebase_storage/firebase_storage.dart';

class WishlistService {
  final String _wishlistCollectionName = "wishlist";

  Future<Stream<QuerySnapshot<Object?>>> fetchWishlist(String userId) async {
    await Firebase.initializeApp();
    // List<Wish> wishlist = [];
    // try {
    //   var list = await FirebaseFirestore.instance.collection(_wishlistCollectionName).get();
    //   var result = list.docs.where((element) => element["userId"] == userId);
    //   log(result.length.toString());
    //   for (var item in result) {
    //     Wish wish = Wish.fromJson(item.data());
    //     wish.imageRef = await getImageUrl(wish.imageRef);
    //     log(wish.imageRef);
    //     wishlist.add(wish);
    //   }
    // } catch (e) {
    //   log(e.toString());
    // }
    try {
      Stream<QuerySnapshot> wish = FirebaseFirestore.instance.collection(_wishlistCollectionName).where('userId', isEqualTo: userId).snapshots();
      return wish;
    } catch (e) {
      log(e.toString());
      return FirebaseFirestore.instance.collection(_wishlistCollectionName).where('userId', isEqualTo: userId).snapshots();
    }
  }

  Future<bool> addWish({required Wish wish, File? wishImage}) async {
    await Firebase.initializeApp();
    try {
      if (wishImage != null) {
        wish.imageRef = await _uploadFile(wishImage.path);
      }
      FirebaseFirestore.instance.collection(_wishlistCollectionName).add(wish.toJson());
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future<bool> editWish({required Wish wish, File? wishImage}) async {
    await Firebase.initializeApp();
    try {
      if (wishImage != null) {
        wish.imageRef = await _uploadFile(wishImage.path);
      }
      FirebaseFirestore.instance.collection(_wishlistCollectionName).doc(wish.docId).update(wish.toJson()).then((value) => log("Wish Updated")).catchError((error) => log("Failed to update Wish: $error"));
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future<String> _uploadFile(String filePath) async {
    File file = File(filePath);
    try {
      String fileName = filePath.split('/').last;
      await FirebaseStorage.instance.ref('uploads/$fileName').putFile(file);
      return fileName;
    } catch (e) {
      // e.g, e.code == 'canceled'
      log(e.toString());
      return "";
    }
  }

  static Future<String> getImageUrl(String fileName) async => await FirebaseStorage.instance.ref("uploads/$fileName").getDownloadURL();
}
