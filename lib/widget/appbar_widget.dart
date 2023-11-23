import 'package:emart_seller/widget/text_style.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart' as intl;
import '../const/const.dart';

AppBar AppBarWidget({title}) {
  return AppBar(
    automaticallyImplyLeading: false, //isase arrow remove ho jati h
    title: boldText(text: title, color: fontGrey, size: 18.0),
    actions: [
      Center(
        child: noramlText(
            text: intl.DateFormat('EEE, MMM d, ' 'yy').format(DateTime.now()),
            color: purpleColor),
      ),
      10.widthBox
    ],
  );
}
