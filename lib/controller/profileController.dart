import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/const/firebase_const.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart'; //basename property use this package

class ProfileController extends GetxController {
  late QueryDocumentSnapshot snapshotData;
  var profileImagePath = ''.obs;
  var profileImageLink = '';
  var isloading = false.obs;

  //textfield
  var nameController = TextEditingController();
  var oldPassController = TextEditingController();
  var newConfirmPassController = TextEditingController();

  //shop Controller
  var shopNameController = TextEditingController();
  var shopAddressController = TextEditingController();
  var shopMobileController = TextEditingController();
  var shopWebsiteController = TextEditingController();
  var shopDescriptionController = TextEditingController();

  //change image
  changeImage(context) async {
    try {
      final img = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 70);
      if (img == null) return;
      profileImagePath.value = img.path;
    } on PlatformException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }

  //upload profile image in FirebaseStorage

  uploadProfileImage() async {
    var fileName = basename(profileImagePath.value);
    var destination = 'image/${currentUser!.uid}/$fileName';
    Reference reference = FirebaseStorage.instance.ref().child(destination);
    await reference.putFile(File(profileImagePath.value));
    profileImageLink = await reference.getDownloadURL();
  }

  //update profile(edit profile)
  updateProfile({name, password, imgUrl}) async {
    var store = firestore.collection(vendorCollection).doc(currentUser!.uid);
    await store.set(
        {'vendor_name': name, 'password': password, 'imageUrl': imgUrl},
        SetOptions(merge: true));
    isloading(false);
  }

  //changeAuthentication password

  changeAuthPassword({email, password, newPassword}) async {
    final cred = EmailAuthProvider.credential(
      email: email,
      password: password,
    );
    await currentUser!.reauthenticateWithCredential(cred).then((value) {
      currentUser!.updatePassword(newPassword);
    }).catchError((error) {});
  }

  //update shop
  updateShop(
      {shopName, shopAdress, shopMobile, shopWebsite, shopDescription}) async {
    var store = firestore.collection(vendorCollection).doc(currentUser!.uid);
    await store.set({
      'shopName': shopName,
      'shopMobile': shopMobile,
      'shopAdress': shopAdress,
      'shoWebsite': shopWebsite,
      'shopDescription': shopDescription
    }, SetOptions(merge: true));
    isloading(false);
  }
}
