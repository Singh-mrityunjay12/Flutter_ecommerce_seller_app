import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/const/firebase_const.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class AuthController extends GetxController {
  var isloading = false
      .obs; //ye RxBool h jise ham reactive boolean bolate h aur yadi hamlog obs remove kar de to this is a simple boolean h
  //ak reactive boolean ko simple boolean value provide nahi kar sakate h
  //how to provide simple value of reactive boolean (reactive boolean ko pahale get karenge like isloading.value=false  .value lagane ke bad ham simple value provide kar sakate h)
  //after using value to convert reactive boolean to simple boolean then we can easily assign the simple value
  //textController
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  //login method
  Future<UserCredential?> loginMethod({context}) async {
    UserCredential?
        userCredential; //jo bhi token milata h from FirebaseAuth this token ka type userCredential hota h
    try {
      userCredential = await auth.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
    return userCredential;
  }

  //signUp method
  Future<UserCredential?> signUpMethod({context}) async {
    UserCredential? userCredential;
    try {
      userCredential = await auth.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
    return userCredential;
  }

//signOut method

  signOutMethod({context}) async {
    try {
      await auth.signOut();
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }
}
