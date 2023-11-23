import 'package:emart_seller/widget/text_style.dart';

import '../../../const/const.dart';

Widget ProductImage({required label, onPress}) {
  return "$label"
      .text
      .bold
      .color(fontGrey)
      .makeCentered()
      .box
      .color(lightGrey)
      .size(100, 100)
      .roundedSM
      .make();
}
