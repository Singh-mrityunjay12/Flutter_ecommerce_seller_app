import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/widget/text_style.dart';

Widget DashBoardButton({context, title, count, iconImg}) {
  var size = MediaQuery.of(context).size;
  return Row(
    children: [
      Expanded(
        //column widget ko Expanded widget se isliye wrap kiye h ki column ko jitana space mile sab use kar le
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            boldText(text: title.toString(), size: 16.0),
            boldText(text: count.toString(), size: 20.0),
          ],
        ),
      ),
      Image.asset(
        iconImg,
        width: 40,
        color: white,
      ),
    ],
  )
      .box
      .rounded
      .color(purpleColor)
      .size(size.width * 0.4, 80)
      .padding(const EdgeInsets.all(8))
      .make();
}
