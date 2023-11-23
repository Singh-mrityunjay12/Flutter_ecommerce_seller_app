import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/controller/productsControlller.dart';
import 'package:emart_seller/view/product_screen/component/product_DropDown.dart';
import 'package:emart_seller/view/product_screen/component/product_image.dart';
import 'package:emart_seller/widget/custom_textfiled.dart';
import 'package:emart_seller/widget/loading_indicator.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';

import '../../widget/text_style.dart';

class AddProduct extends StatelessWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductController());
    return Obx(() => Scaffold(
          backgroundColor: purpleColor,
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: white,
                )),
            title: boldText(text: "Add Product", size: 16.0, color: white),
            actions: [
              controller.isloading.value
                  ? LoadingIndicator(circleColor: white)
                  : TextButton(
                      onPressed: () async {
                        controller.isloading(true);
                        await controller.uploadImages();
                        await controller.uploadProduct(context);
                        Get.back();
                      },
                      child: boldText(text: save, color: white))
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextField(
                      hint: "eg. BMW",
                      label: "Product Name",
                      controller: controller.pnameController),
                  10.heightBox,
                  CustomTextField(
                      hint: "eg. Nice Product",
                      label: "Description",
                      isDes: true,
                      controller: controller.pdescController),
                  10.heightBox,
                  CustomTextField(
                      hint: "eg. \$300",
                      label: "Price",
                      controller: controller.ppriceController),
                  10.heightBox,
                  CustomTextField(
                      hint: "eg. 20",
                      label: "Quantity",
                      controller: controller.pquantityController),
                  10.heightBox,
                  ProductDropDown("Category", controller.categoryList,
                      controller.categoryValue, controller),
                  10.heightBox,
                  ProductDropDown("SubCategory", controller.subcategoryList,
                      controller.subcategoryValue, controller),
                  const Divider(
                    color: white,
                  ),
                  10.heightBox,
                  noramlText(text: "Choose Product image"),
                  10.heightBox,
                  Obx(() => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(
                            3,
                            (index) => controller.pImagesList[index] != null
                                ? Image.file(
                                    controller.pImagesList[index],
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ).onTap(() {
                                    controller.pickImages(index, context);
                                  })
                                : ProductImage(label: "${index + 1}").onTap(() {
                                    controller.pickImages(index, context);
                                  })),
                      )),
                  10.heightBox,
                  noramlText(text: "First Images will be your display images"),
                  10.heightBox,
                  boldText(text: "Choose Product Colors"),
                  Obx(() => Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: List.generate(
                          7,
                          (index) =>
                              Stack(alignment: Alignment.center, children: [
                            VxBox(
                                    // child: noramlText(text: index
                                    // )
                                    )
                                .color(Vx.randomPrimaryColor)
                                .roundedFull
                                .size(50, 50)
                                .make()
                                .onTap(() {
                              controller.selectedColorIndex.value = index;
                            }),
                            controller.selectedColorIndex.value == index
                                ? const Icon(
                                    Icons.done,
                                    color: white,
                                  )
                                : const SizedBox()
                          ]),
                        ),
                      )),
                  10.heightBox
                ],
              ),
            ),
          ),
        ));
  }
}
