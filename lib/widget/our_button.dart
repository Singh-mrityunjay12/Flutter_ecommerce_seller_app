import 'package:emart_seller/widget/text_style.dart';

import '../const/const.dart';

Widget ourButton({title, color = Colors.purple, onPress}) {
  return ElevatedButton(
      style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          primary: color,
          padding: const EdgeInsets.all(12)),
      onPressed: onPress,
      child: boldText(text: title, size: 16.0));
}
