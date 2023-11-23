import 'package:emart_seller/const/colors.dart';
import 'package:emart_seller/widget/text_style.dart';
import 'package:flutter/cupertino.dart';

import 'package:velocity_x/velocity_x.dart';

Widget orderPlaceDetails({title1, title2, d1, d2}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 135,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              boldText(text: "$title1", color: fontGrey),
              boldText(text: "$d1", color: red)
              // "$title1".text.fontFamily(semibold).make(),
              // "$d1".text.fontFamily(semibold).color(redColor).make(),
            ],
          ),
        ),
        SizedBox(
            width: 135,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // "$title2".text.fontFamily(semibold).make(),
                // "$d2".text.make(),
                boldText(text: '$title2', color: fontGrey),
                boldText(text: "$d2", color: red)
              ],
            ))
      ],
    ),
  );
}
