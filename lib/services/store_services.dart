import 'package:emart_seller/const/firebase_const.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class StoreServices {
  static getProfile() {
    return firestore
        .collection(vendorCollection)
        .where('id', isEqualTo: currentUser!.uid)
        .snapshots();
  }

  static getMassage(uid) {
    return firestore
        .collection(chatCollection)
        .where('fromId', isEqualTo: uid)
        .snapshots();
  }
//get orders

  static getOrders(uid) {
    return firestore
        .collection(orderCollection)
        .where('vendors', arrayContains: uid)
        .snapshots();
  }

//get products
  static getProduct(uid) {
    return firestore
        .collection(productCollection)
        .where('vendor_id', isEqualTo: uid)
        .snapshots();
  }

  //get popular product
  static getPopularProduct(uid) {
    return firestore
        .collection(productCollection)
        .where('vendor_id', isEqualTo: uid)
        .orderBy('p_wishlist'
            .length); //orderBy ka use karake according to p_wishlist show karayenge
  }

//dummy method
  static prooo() {
    return firestore.collection(vendorCollection).doc().id;
  }
}
