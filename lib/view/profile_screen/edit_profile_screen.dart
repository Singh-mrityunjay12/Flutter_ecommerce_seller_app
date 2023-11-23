import 'dart:io';

import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/controller/profileController.dart';
import 'package:emart_seller/widget/custom_textfiled.dart';
import 'package:emart_seller/widget/loading_indicator.dart';
import 'package:emart_seller/widget/text_style.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class EditProfileScreen extends StatefulWidget {
  final String? Username;
  const EditProfileScreen({Key? key, this.Username}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  var controller = Get.put(ProfileController());

  @override
  void initState() {
    controller.nameController.text = widget.Username!;
    // TODO: implement initState
    super.initState();
    // setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: purpleColor,
        appBar: AppBar(
          title: boldText(text: editProfile, size: 16.0),
          actions: [
            controller.isloading.value
                ? LoadingIndicator()
                : TextButton(
                    onPressed: () async {
                      controller.isloading(true);
                      //if image is not selected
                      if (controller.profileImagePath.value.isNotEmpty) {
                        await controller.uploadProfileImage();
                      } else {
                        //if image selected form gallery
                        controller.profileImageLink =
                            controller.snapshotData['imageUrl'];
                      }
                      //if old password matches database password
                      if (controller.snapshotData['password'] ==
                          controller.oldPassController.text.trim()) {
                        await controller.changeAuthPassword(
                            email: controller.snapshotData['email'],
                            password: controller.oldPassController.text.trim(),
                            newPassword: controller
                                .newConfirmPassController.text
                                .trim());
                        //old password ko newConfirmPassword se change kar denge in cloud storage
                        await controller.updateProfile(
                            imgUrl: controller.profileImageLink,
                            name: controller.nameController.text.trim(),
                            password: controller.newConfirmPassController.text
                                .trim());
                        VxToast.show(context, msg: "Updated");
                      } else if (controller
                              .oldPassController.text.isEmptyOrNull &&
                          controller
                              .newConfirmPassController.text.isEmptyOrNull) {
                        //aisa ho to only profile ko update kar de
                        await controller.updateProfile(
                            imgUrl: controller.profileImageLink,
                            name: controller.nameController.text.trim(),
                            password: controller.snapshotData['password']);
                      } else {
                        VxToast.show(
                          context,
                          msg: "Some error occurred",
                          bgColor: white,
                        );
                        controller.isloading(false);
                      }
                    },
                    child: noramlText(text: save))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              //if snapshotData image url and controller path is empty
              controller.snapshotData['imageUrl'] == '' &&
                      controller.profileImagePath.isEmpty
                  ? Image.asset(
                      imgProduct,
                      width: 150,
                      fit: BoxFit.cover,
                    ).box.roundedFull.clip(Clip.antiAlias).make()
                  :
                  //if snapshotData is not empty but controller profileImage is empty
                  controller.snapshotData['imageUrl'] != '' &&
                          controller.profileImagePath.isEmpty
                      ? Image.network(
                          controller.snapshotData['imageUrl'],
                          width: 150,
                          fit: BoxFit.cover,
                        ).box.roundedFull.clip(Clip.antiAlias).make()
                      :
                      //else if controller.profileImagePath is not empty but data image url is
                      Image.file(
                          File(
                            controller.profileImagePath.value,
                          ),
                          width: 150,
                          fit: BoxFit.cover,
                        ).box.roundedFull.clip(Clip.antiAlias).make(),
              10.heightBox,
              ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.white),
                  onPressed: () {
                    controller.changeImage(context);
                  },
                  child: noramlText(text: changeImage, color: fontGrey)),
              10.heightBox,
              const Divider(
                color: white,
              ),
              10.heightBox,
              CustomTextField(
                  label: name,
                  hint: nameHint,
                  controller: controller.nameController),
              30.heightBox,
              Align(
                  alignment: Alignment.centerLeft,
                  child: boldText(text: "Change your password")),
              10.heightBox,
              CustomTextField(
                  label: password,
                  hint: passHint,
                  controller: controller.oldPassController),
              10.heightBox,
              CustomTextField(
                  label: confirmPassword,
                  hint: passHint,
                  controller: controller.newConfirmPassController),
            ],
          ),
        ),
      ),
    );
  }
}
