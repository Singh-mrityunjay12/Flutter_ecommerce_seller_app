import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/controller/profileController.dart';
import 'package:emart_seller/widget/custom_textfiled.dart';
import 'package:emart_seller/widget/loading_indicator.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';

import '../../widget/text_style.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileController>();
    return Obx(() => Scaffold(
          backgroundColor: purpleColor,
          appBar: AppBar(
            title: boldText(text: shopSetting, size: 16.0),
            actions: [
              controller.isloading.value
                  ? LoadingIndicator(circleColor: white)
                  : TextButton(
                      onPressed: () async {
                        controller.isloading(true);
                        await controller.updateShop(
                          shopName: controller.shopNameController.text.trim(),
                          shopAdress:
                              controller.shopAddressController.text.trim(),
                          shopMobile:
                              controller.shopMobileController.text.trim(),
                          shopWebsite:
                              controller.shopWebsiteController.text.trim(),
                          shopDescription:
                              controller.shopDescriptionController.text.trim(),
                        );
                        VxToast.show(context, msg: "Shop Updated");
                      },
                      child: noramlText(text: save))
            ],
          ),
          body: Column(
            children: [
              CustomTextField(
                  label: shopName,
                  hint: nameHint,
                  controller: controller.shopNameController),
              10.heightBox,
              CustomTextField(
                  label: address,
                  hint: shopAddressHint,
                  controller: controller.shopAddressController),
              10.heightBox,
              CustomTextField(
                  label: mobile,
                  hint: shopMobileHint,
                  controller: controller.shopMobileController),
              10.heightBox,
              CustomTextField(
                  label: website,
                  hint: shopWebsiteHint,
                  controller: controller.shopWebsiteController),
              10.heightBox,
              CustomTextField(
                  label: description,
                  hint: shopDescHint,
                  isDes: true,
                  controller: controller.shopDescriptionController)
            ],
          ),
        ));
  }
}
