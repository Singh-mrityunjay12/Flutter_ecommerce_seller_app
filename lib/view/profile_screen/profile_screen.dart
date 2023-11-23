import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/const/firebase_const.dart';
import 'package:emart_seller/controller/authController.dart';
import 'package:emart_seller/controller/profileController.dart';
import 'package:emart_seller/services/store_services.dart';
import 'package:emart_seller/view/auth_screen/login_screen.dart';
import 'package:emart_seller/view/messages_screen/messages_screen.dart';
import 'package:emart_seller/view/profile_screen/edit_profile_screen.dart';
import 'package:emart_seller/view/shop_screen/shop_setting_screen.dart';
import 'package:emart_seller/widget/loading_indicator.dart';
import 'package:emart_seller/widget/text_style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());
    return Scaffold(
        backgroundColor: purpleColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: boldText(text: setting, size: 16.0),
          actions: [
            IconButton(
                onPressed: () {
                  Get.to(() => EditProfileScreen(
                        Username: controller.snapshotData['vendor_name'],
                      ));
                },
                icon: Icon(Icons.edit)),
            TextButton(
                onPressed: () async {
                  await Get.find<AuthController>()
                      .signOutMethod(context: context);
                  Get.offAll(() => const LoginScreen());
                },
                child: noramlText(text: logout)),
          ],
        ),
        body: StreamBuilder(
            stream: StoreServices.getProfile(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return LoadingIndicator();
              } else {
                var data = snapshot.data!.docs;
                controller.snapshotData = snapshot.data!.docs[0];
                print(data[0]);
                print(StoreServices.prooo());
                print("///////////////////////");
                print(currentUser!.uid);
                return Column(
                  children: [
                    ListTile(
                      leading: controller.snapshotData['imageUrl'] == ""
                          ? Image.asset(
                              imgProduct,
                              width: 100,
                              fit: BoxFit.cover,
                            ).box.roundedFull.clip(Clip.antiAlias).make()
                          : Image.network(
                              controller.snapshotData['imageUrl'],
                              width: 100,
                              fit: BoxFit.cover,
                            ).box.roundedFull.clip(Clip.antiAlias).make(),
                      title: boldText(
                          text: "${controller.snapshotData['vendor_name']}"),
                      subtitle: noramlText(
                          text: "${controller.snapshotData['email']}"),
                    ),
                    const Divider(),
                    10.heightBox,
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Column(
                        children: List.generate(
                            profileButtonTitles.length,
                            (index) => ListTile(
                                  onTap: () {
                                    switch (index) {
                                      case 0:
                                        Get.to(() => const ShopScreen());
                                        break;
                                      case 1:
                                        Get.to(() => const MessagesScreen());
                                        break;

                                      default:
                                    }
                                  },
                                  leading: Icon(
                                    profileButtonsIcons[index],
                                    color: white,
                                  ),
                                  title: noramlText(
                                      text: profileButtonTitles[index]),
                                )),
                      ),
                    )
                  ],
                );
              }
            }));
  }
}
