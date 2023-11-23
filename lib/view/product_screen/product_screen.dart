import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/const/firebase_const.dart';
import 'package:emart_seller/controller/productsControlller.dart';
import 'package:emart_seller/services/store_services.dart';
import 'package:emart_seller/view/product_screen/add_product.dart';
import 'package:emart_seller/view/product_screen/product_details.dart';
import 'package:emart_seller/widget/appbar_widget.dart';
import 'package:emart_seller/widget/loading_indicator.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:intl/intl.dart' as intl;
import '../../widget/text_style.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductController());
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await controller.getCategories();
            controller.populateCategoryList();
            Get.to(() => AddProduct());
          },
          backgroundColor: purpleColor,
          child: Icon(Icons.add),
        ),
        appBar: AppBarWidget(title: products),
        body: StreamBuilder(
          stream: StoreServices.getProduct(currentUser!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return LoadingIndicator();
            } else {
              var data = snapshot.data!.docs;
              print(data[0].id);
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: List.generate(
                        data.length,
                        (index) => Card(
                              child: ListTile(
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
                                    text: "${data[index]['p_name']}",
                                    color: fontGrey),
                                subtitle: Row(
                                  children: [
                                    noramlText(
                                        text: "\$${data[index]['p_price']}",
                                        color: darkGrey),
                                    10.widthBox,
                                    boldText(
                                        text: data[index]['is_featured'] == true
                                            ? "Featured"
                                            : "",
                                        color: green),
                                  ],
                                ),
                                trailing: VxPopupMenu(
                                    child: Icon(Icons.more_vert_rounded),
                                    menuBuilder: () => Column(
                                          children: List.generate(
                                              popMenuTitle.length,
                                              (i) => Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Row(
                                                      children: [
                                                        Icon(
                                                          popMenuIconList[i],
                                                          color: data[index][
                                                                          'featured_id'] ==
                                                                      currentUser!
                                                                          .uid &&
                                                                  i == 0
                                                              ? green
                                                              : darkGrey,
                                                        ),
                                                        10.widthBox,
                                                        noramlText(
                                                            text: data[index][
                                                                            'featured_id'] ==
                                                                        currentUser!
                                                                            .uid &&
                                                                    i == 0
                                                                ? "Remove feature"
                                                                : popMenuTitle[
                                                                    i],
                                                            color: darkGrey)
                                                      ],
                                                    ).onTap(() {
                                                      switch (i) {
                                                        case 0:
                                                          if (data[index][
                                                                  'is_featured'] ==
                                                              true) {
                                                            controller
                                                                .removeFeatured(
                                                                    data[index]
                                                                        .id); //data[index].id is docId
                                                          } else {
                                                            controller
                                                                .addFeatured(
                                                                    data[index]
                                                                        .id);
                                                          }
                                                          break;
                                                        case 1:
                                                          break;
                                                        case 2:
                                                          controller
                                                              .removeProduct(
                                                                  data[index]
                                                                      .id);
                                                      }
                                                    }),
                                                  )),
                                        ).box.rounded.white.width(200).make(),
                                    clickType: VxClickType.singleClick),
                              ),
                            )),
                  ),
                ),
              );
            }
          },
        ));
  }
}
