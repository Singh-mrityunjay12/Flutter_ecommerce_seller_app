import 'package:emart_seller/widget/text_style.dart';

import '../const/const.dart';

Widget CustomTextField({label, hint, controller, isDes = false}) {
  return TextFormField(
    controller: controller,
    style: const TextStyle(color: white),
    maxLines: isDes ? 4 : 1,
    decoration: InputDecoration(
        isDense: true,
        label: noramlText(text: label),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: white),
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: white)),
        hintText: hint,
        hintStyle: const TextStyle(color: lightGrey)),
  );
}
