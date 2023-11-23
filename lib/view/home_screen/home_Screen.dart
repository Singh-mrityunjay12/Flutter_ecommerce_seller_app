import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/const/firebase_const.dart';
import 'package:emart_seller/services/store_services.dart';
import 'package:emart_seller/view/product_screen/product_details.dart';
import 'package:emart_seller/widget/appbar_widget.dart';
import 'package:emart_seller/widget/dashboard_button.dart';
import 'package:emart_seller/widget/loading_indicator.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:intl/intl.dart' as intl;
import '../../widget/text_style.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarWidget(title: dashboard),
        body: StreamBuilder(
          stream: StoreServices.getProduct(currentUser!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return LoadingIndicator();
            } else {
              var data = snapshot.data!.docs;
              data = data.sortedBy((a, b) {
                return a['p_wishlist'].length.compareTo(b['p_wishlist'].length);
              });
              print(data);
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        DashBoardButton(
                            context: context,
                            title: products,
                            count: data.length,
                            iconImg: icProducts),
                        DashBoardButton(
                            context: context,
                            title: orders,
                            count: "75p",
                            iconImg: icOrders),
                      ],
                    ),
                    10.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        DashBoardButton(
                            context: context,
                            title: rating,
                            count: "75",
                            iconImg: icStar),
                        DashBoardButton(
                            context: context,
                            title: totalSales,
                            count: "75",
                            iconImg: icVerify),
                      ],
                    ),
                    10.heightBox,
                    const Divider(),
                    10.heightBox,
                    boldText(text: popularProduct, size: 16.0, color: fontGrey),
                    10.heightBox,
                    ListView(
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      children: List.generate(data.length, (index) {
                        return data[index]['p_wishlist'].length == 0
                            ? const SizedBox()
                            : ListTile(
                                onTap: () {
                                  Get.to(() => ProductDetails(
                                        data: data[index],
                                      ));
                                },
                                leading: Image.network(
                                  data[index]['p_imgs'][0],
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                                title: boldText(
                                    text: data[index]['p_name'],
                                    color: fontGrey),
                                subtitle: noramlText(
                                    text: "\$${data[index]['p_price']}",
                                    color: darkGrey),
                              );
                      }),
                    )
                  ],
                ),
              );
            }
          },
        ));
  }
}
