import 'package:emart_seller/widget/text_style.dart';

import '../../../const/const.dart';

Widget ChatBubble() {
  return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.only(bottom: 8),
        decoration: const BoxDecoration(
            color: purpleColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                bottomLeft: Radius.circular(20))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            noramlText(text: "Your message here....."),
            10.heightBox,
            noramlText(text: "10.30 PM")
          ],
        ),
      ));
}
