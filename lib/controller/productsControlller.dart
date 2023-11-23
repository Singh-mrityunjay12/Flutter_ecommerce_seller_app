import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/const/firebase_const.dart';
import 'package:emart_seller/controller/home_controller.dart';
import 'package:emart_seller/model/category_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class ProductController extends GetxController {
  //text field controller
  var pnameController = TextEditingController();
  var pdescController = TextEditingController();
  var ppriceController = TextEditingController();
  var pquantityController = TextEditingController();

  var isloading = false.obs;
  var categoryList = <String>[].obs;
  var subcategoryList = <String>[].obs;
  List<Category> category = [];
  var pImagesLinks = [];
  var pImagesList = RxList<dynamic>.generate(3, (index) => null);
  var categoryValue = ''.obs;
  var subcategoryValue = ''.obs;
  var selectedColorIndex = 0.obs;
  //get categories
  getCategories() async {
    var data = await rootBundle.loadString(
        "lib/services/category_model.json"); //convert json data into string
    var cat = categoryModelFromJson(data);
    category = cat.categories;
  }

  populateCategoryList() {
    categoryList.clear();
    for (var item in category) {
      categoryList.add(item.name);
    }
  }

  populatesubCategory(cat) {
    subcategoryList.clear();

    var data = category.where((element) => element.name == cat).toList();
    for (var i = 0; i < data.first.subcategories.length; i++) {
      subcategoryList.add(data.first.subcategories[i]);
    }
  }

  //pick Images
  pickImages(index, context) async {
    try {
      final img = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 80);
      if (img == null) {
        return;
      } else {
        pImagesList[index] = File(img.path);
      }
    } catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }

  //uploadImages
  uploadImages() async {
    pImagesLinks.clear();
    for (var item in pImagesList) {
      if (item != null) {
        var filename = basename(item.path);
        var destination = 'images/vendors/${currentUser!.uid}/$filename';
        Reference ref = FirebaseStorage.instance.ref().child(destination);
        await ref.putFile(item);
        var n = await ref.getDownloadURL();
        pImagesLinks.add(n);
      }
    }
  }

  //upload product
  uploadProduct(context) async {
    var store = firestore.collection(productCollection).doc();
    await store.set({
      'is_featured': false,
      'p_category': categoryValue.value,
      'p_subcategory': subcategoryValue.value,
      'p_colors': FieldValue.arrayUnion([
        Colors.red.value,
        Colors.brown.value,
        Colors.deepOrange.value,
        Colors.tealAccent.value
      ]),
      'p_imgs': FieldValue.arrayUnion(pImagesLinks),
      'p_wishlist': FieldValue.arrayUnion([]),
      'p_desc': pdescController.text.trim(),
      'p_name': pnameController.text.trim(),
      'p_price': ppriceController.text.trim(),
      'p_quantity': pquantityController.text.trim(),
      'p_seller': Get.find<HomeController>().username,
      'p_rating': "5.0",
      'vendor_id': currentUser!.uid,
      'featured_id': '',
    });
    //product add hone ke bad hamlog isloading ko false kar dete h
    isloading(false);
    VxToast.show(context, msg: "Product Uploaded");
  }

  //add feature
  addFeatured(docId) async {
    await firestore.collection(productCollection).doc(docId).set(
        {
          'featured_id': currentUser!.uid,
          'is_featured': true,
        },
        SetOptions(
            merge:
                true)); //SetOptions ka use karake ham jo bhi change karate change karane ke bad bache huye ko merge kar dete h
    //yadi nahi use karenge to dusara file create kar dega
  }

  //reamove feature
  removeFeatured(docId) async {
    await firestore.collection(productCollection).doc(docId).set(
        {
          'featured_id': "",
          'is_featured': false,
        },
        SetOptions(
            merge:
                true)); //SetOptions ka use karake ham jo bhi change karate change karane ke bad bache huye ko merge kar dete h
    //yadi nahi use karenge to dusara file create kar dega
  }

  //remove product
  removeProduct(docId) {
    firestore.collection(productCollection).doc(docId).delete();
  }
}
