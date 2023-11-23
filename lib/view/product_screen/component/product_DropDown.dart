import 'package:emart_seller/controller/productsControlller.dart';
import 'package:emart_seller/widget/text_style.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../const/const.dart';

Widget ProductDropDown(
    hint, List<String> list, dropvalue, ProductController controller) {
  return Obx(() => DropdownButtonHideUnderline(
          child: DropdownButton(
              hint: noramlText(text: "${hint}", color: fontGrey),
              value: dropvalue.value == "" ? null : dropvalue.value,
              isExpanded: true,
              items: list.map((e) {
                return DropdownMenuItem(
                  child: e.toString().text.make(),
                  value: e,
                );
              }).toList(), //toList()  ka use karake hamlog jo bhi value access karate h list se use phir list me convert kar dete h
              onChanged: (neWvalue) {
                if (hint == "Category") {
                  controller.subcategoryValue.value = '';
                  controller.populatesubCategory(neWvalue.toString());
                }
                dropvalue.value = neWvalue.toString();
              }))
      .box
      .white
      .padding(const EdgeInsets.symmetric(horizontal: 4))
      .roundedSM
      .make());
}
