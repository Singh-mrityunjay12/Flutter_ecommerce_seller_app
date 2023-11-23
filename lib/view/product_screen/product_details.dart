import 'package:emart_seller/const/const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../../widget/text_style.dart';

class ProductDetails extends StatelessWidget {
  final dynamic data;
  const ProductDetails({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: darkGrey,
            )),
        title: boldText(text: "${data['p_name']}", size: 16.0, color: fontGrey),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              VxSwiper.builder(
                  autoPlay: true,
                  aspectRatio: 16 / 9,
                  viewportFraction: 1.0,
                  itemCount: data['p_imgs'].length,
                  itemBuilder: (context, index) {
                    return Image.network(
                      data['p_imgs'][index],
                      width: double.infinity,
                      fit: BoxFit.cover,
                    );
                  }),
              10.heightBox,
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    boldText(
                        text: "${data['p_name']}", size: 16.0, color: fontGrey),
                    10.heightBox,
                    Row(
                      children: [
                        boldText(
                            text: "${data['p_category']}",
                            size: 16.0,
                            color: fontGrey),
                        10.widthBox,
                        noramlText(
                            text: "${data['p_subcategory']}",
                            size: 16.0,
                            color: fontGrey)
                      ],
                    ),
                    10.heightBox,
                    //ratting
                    VxRating(
                        normalColor: fontGrey,
                        selectionColor: golden,
                        count: 5,
                        maxRating: 5,
                        size: 25,
                        value: double.parse(data['p_rating']),
                        isSelectable: false,
                        onRatingUpdate: (value) {}),
                    10.heightBox,
                    boldText(
                        text: "\$${data['p_price']}", size: 18.0, color: red),
                    10.heightBox,
                    Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 100,
                              child: "Color:".text.color(fontGrey).make(),
                            ),
                            Row(
                                children: List.generate(
                              3,
                              (index) => VxBox()
                                  .size(40, 40)
                                  .roundedFull
                                  .color(Color(data['p_colors'][index]))
                                  .margin(EdgeInsets.symmetric(horizontal: 4))
                                  .make()
                                  .onTap(() {
                                print(
                                    "///////////////////////////////////////");
                              }),
                            )),
                          ],
                        ).box.padding(EdgeInsets.all(8)).make(),
                        //quantity row
                        Row(
                          children: [
                            SizedBox(
                              width: 100,
                              child: "Quantity:".text.color(fontGrey).make(),
                            ),
                            noramlText(
                                text: "${data['p_quantity']} items",
                                color: fontGrey)
                          ],
                        ).box.padding(EdgeInsets.all(8)).make(),
                      ],
                    )
                        .box
                        .color(lightGrey)
                        .padding(EdgeInsets.all(8))
                        .shadowSm
                        .make(),
                    const Divider(),
                    20.heightBox,
                    boldText(text: "Description", color: fontGrey),
                    10.heightBox,
                    noramlText(text: "${data['p_desc']}", color: fontGrey)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
